import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkService {
  static const String _baseUrl = 'https://api.mytravaly.com/public/v1/';
  static const String _authToken = '71523fdd8d26f585315b4233e39d9263';

  Dio prepareRequest(String? visitorToken) {
    final headers = <String, String>{
      'authtoken': _authToken,
    };

    if (visitorToken != null && visitorToken.isNotEmpty) {
      headers['visitortoken'] = visitorToken;
    }

    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: headers,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: false,
      ),
    );

    return dio;
  }
}
