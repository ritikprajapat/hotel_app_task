import '../../../app/app.dart';
import 'dart:async';

class HomeViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  int _selectedCategory = 0;
  bool _isSearching = false;
  bool _showSuggestions = false;

  List<SearchAutoCompleteResponse> _suggestions = [];
  Timer? _debounceTimer;

  int get selectedCategory => _selectedCategory;
  bool get isSearching => _isSearching;
  bool get showSuggestions => _showSuggestions;
  List<SearchAutoCompleteResponse> get suggestions => _suggestions;

  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.terrain_outlined, 'label': 'All'},
    {'icon': Icons.water_outlined, 'label': 'Beach'},
    {'icon': Icons.landscape_outlined, 'label': 'Mountain'},
    {'icon': Icons.location_city_outlined, 'label': 'City'},
  ];

  HomeViewModel() {
    searchController.addListener(_onSearchChanged);
    searchFocusNode.addListener(_onFocusChanged);
  }

  // ─────────────────────────── SEARCH LOGIC ───────────────────────────
  void _onSearchChanged() {
    final query = searchController.text.trim();

    // Cancel previous timer
    _debounceTimer?.cancel();

    if (query.length >= 2) {
      // Show loading state immediately
      _isSearching = true;
      notifyListeners();

      // Set new timer with 500ms delay
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        fetchSuggestions(query);
      });
    } else {
      _clearSuggestions();
    }
  }

  void _onFocusChanged() {
    if (searchFocusNode.hasFocus && _suggestions.isNotEmpty) {
      _showSuggestions = true;
    } else if (!searchFocusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 150), () {
        _showSuggestions = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  Future<void> fetchSuggestions(String query) async {
    _isSearching = true;
    notifyListeners();

    try {
      final results = await ApiService.searchAutoComplete(query);
      _suggestions = results;
      _showSuggestions = results.isNotEmpty && searchFocusNode.hasFocus;
    } catch (e) {
      debugPrint('[HomeViewModel] fetchSuggestions error → $e');
      _showSuggestions = false;
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    searchController.clear();
    _clearSuggestions();
  }

  Map<String, dynamic>? handleSearch(BuildContext context, [String? query]) {
    _debounceTimer?.cancel();
    final searchQuery = (query ?? searchController.text).trim();

    if (searchQuery.isEmpty) {
      _showSnackBar(context, 'Please enter a search term');
      return null;
    }

    _showSuggestions = false;
    searchFocusNode.unfocus();
    notifyListeners();

    return {'query': searchQuery};
  }

  Map<String, dynamic> onSuggestionTap(
    BuildContext context,
    SearchAutoCompleteResponse suggestion,
    String resultType,
  ) {
    _debounceTimer?.cancel();
    final autoCompleteList = suggestion.data?.autoCompleteList;
    if (autoCompleteList == null) {
      _showSnackBar(context, 'Invalid suggestion');
      return {};
    }

    dynamic result;
    String value = '';
    String id = '';
    String type = '';
    String displayType = '';

    // Get the appropriate result based on type
    if (resultType == 'city') {
      result = autoCompleteList.byCity?.listOfResult?.first;
      if (result != null) {
        value = result.valueToDisplay ?? '';
        id = result.searchArray?.type ?? '';
        type = result.searchArray?.query?.join(', ') ?? '';
        displayType = 'City';
      }
    } else if (resultType == 'property') {
      result = autoCompleteList.byPropertyName?.listOfResult?.first;
      if (result != null) {
        value = result.propertyName ?? result.valueToDisplay ?? '';
        id = result.searchArray?.query?.first ?? '';
        type = result.searchArray?.type ?? '';
        displayType = 'Hotel';
      }
    } else if (resultType == 'state') {
      result = autoCompleteList.byState?.listOfResult?.first;
      if (result != null) {
        value = result.valueToDisplay ?? '';
        id = result.searchArray?.type ?? '';
        type = result.searchArray?.query?.join(', ') ?? '';
        displayType = 'State';
      }
    } else if (resultType == 'country') {
      result = autoCompleteList.byCountry?.listOfResult?.first;
      if (result != null) {
        value = result.valueToDisplay ?? '';
        id = result.searchArray?.type ?? '';
        type = result.searchArray?.query?.join(', ') ?? '';
        displayType = 'Country';
      }
    }

    if (value.isEmpty) {
      _showSnackBar(context, 'Invalid suggestion');
      return {};
    }

    searchController.text = value;
    searchFocusNode.unfocus();
    _showSuggestions = false;
    notifyListeners();

    return {
      'query': value,
      'id': id,
      'type': type,
      'displayType': displayType,
      'resultType': resultType,
    };
  }

  void selectCategory(int index) {
    if (_selectedCategory == index) return;
    _selectedCategory = index;
    notifyListeners();
  }

  // ─────────────────────────── HELPERS ───────────────────────────
  void _showSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF151515),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearSuggestions() {
    _suggestions = [];
    _showSuggestions = false;
    _isSearching = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  String formatPrice(num? amount) {
    if (amount == null) return "\$0";
    return amount >= 1000 ? '₹${(amount / 1000).toStringAsFixed(1)}k' : '\$${amount.toStringAsFixed(0)}';
  }

  void handleBooking(BuildContext context, String? hotelName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking ${hotelName ?? ''}...'),
        backgroundColor: const Color(0xFF151515),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
