import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app_task/data/models/register_device_response.dart';
import 'package:travel_app_task/data/models/search_auto_complete_response.dart';
import 'package:travel_app_task/data/models/search_result_response.dart';
import 'network_service.dart';

class ApiService {
  static const String _visitorTokenKey = 'visitor_token';
  static final NetworkService _network = NetworkService();

  static Future<String?> _getSavedVisitorToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_visitorTokenKey);
  }

  static Future<void> _saveVisitorToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_visitorTokenKey, token);
  }

  static Future<String> _ensureVisitorToken() async {
    final existingToken = await _getSavedVisitorToken();
    if (existingToken?.isNotEmpty ?? false) return existingToken!;

    final token = await _registerDeviceAndGetToken();
    if (token?.isNotEmpty ?? false) return token!;
    throw Exception('Unable to obtain visitor token');
  }

  static const _deviceData = {
    'deviceModel': 'RMX3521',
    'deviceFingerprint': 'realme/RMX3521/RE54E2L1:13/RKQ1.211119.001/S.f1bb32-7f7fa_1:user/release-keys',
    'deviceBrand': 'realme',
    'deviceId': 'RE54E2L1',
    'deviceName': 'RMX3521_11_C.10',
    'deviceManufacturer': 'realme',
    'deviceProduct': 'RMX3521',
    'deviceSerialNumber': 'unknown',
  };

  static Future<RegisterDeviceResponse?> registerDeviceResponse() async {
    try {
      final dio = _network.prepareRequest(null);
      final response = await dio.post(
        '',
        data: {'action': 'deviceRegister', 'deviceRegister': _deviceData},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = response.data as Map<String, dynamic>;
        final parsed = RegisterDeviceResponse.fromJson(decoded);
        final token = parsed.data?.visitorToken;

        if (token != null && token.isNotEmpty) {
          await _saveVisitorToken(token);
        }
        return parsed;
      }
      return null;
    } catch (e) {
      print('[ApiService] registerDeviceResponse error → $e');
      return null;
    }
  }

  static Future<String?> _registerDeviceAndGetToken() async {
    final resp = await registerDeviceResponse();
    return resp?.data?.visitorToken;
  }

  static Future<List<SearchAutoCompleteResponse>> searchAutoComplete(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final token = await _ensureVisitorToken();
      final dio = _network.prepareRequest(token);

      final response = await dio.post(
        '',
        data: {
          'action': 'searchAutoComplete',
          'searchAutoComplete': {
            'inputText': query,
            'searchType': ['byCity', 'byState', 'byCountry', 'byPropertyName'],
            'limit': 10,
          },
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final results = data['data']?['results'];

        if (results is List) {
          return results.map((e) => SearchAutoCompleteResponse.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      print('[ApiService] searchAutoComplete error → $e');
      return [];
    }
  }

  static Future<SearchResultResponse> searchHotels({
    required String query,
    String? searchId,
    String? searchType,
    List<String> preloaderList = const [],
    int limit = 10,
    required List<String> excludedHotels,
  }) async {
    try {
      final now = DateTime.now();
      final checkIn = DateTime(now.year, now.month, now.day + 1).toIso8601String().split('T')[0];
      final checkOut = DateTime(now.year, now.month, now.day + 2).toIso8601String().split('T')[0];

      final token = await _ensureVisitorToken();
      final dio = _network.prepareRequest(token);

      final String finalSearchType = (searchId != null && searchType != null) ? 'hotelIdSearch' : 'hotelIdSearch';
      final List<String> finalSearchQuery = (searchId != null && searchId.isNotEmpty) ? [searchId] : [query];

      final response = await dio.post(
        '',
        data: {
          'action': 'getSearchResultListOfHotels',
          'getSearchResultListOfHotels': {
            'searchCriteria': {
              'checkIn': checkIn,
              'checkOut': checkOut,
              'rooms': 2,
              'adults': 2,
              'children': 0,
              'searchType': finalSearchType,
              'searchQuery': finalSearchQuery,
              'accommodation': ['all'],
              'arrayOfExcludedSearchType': ['street'],
              'highPrice': '3000000',
              'lowPrice': '0',
              'limit': limit,
              'preloaderList': preloaderList,
              'currency': 'INR',
              'rid': 0,
            },
          },
        },
      );

      final data = response.data;
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data['responseCode'] == 200 &&
          data['status'] == true) {
        return SearchResultResponse.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Failed to load hotels');
      }
    } catch (e) {
      print('[ApiService] searchHotels error → $e');
      throw Exception('Failed to load hotels');
    }
  }
}
