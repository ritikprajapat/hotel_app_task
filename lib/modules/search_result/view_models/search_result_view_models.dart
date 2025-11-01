import '../../../app/app.dart';

class SearchResultsViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  List<ArrayOfHotelList> hotels = [];
  List<ArrayOfHotelList> allHotels = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  String searchQuery = '';
  String? searchId;
  String? searchType;
  String? displayType;
  List<String> excludedHotels = [];

  static const int itemsPerPage = 10;
  int currentPage = 0;
  bool hasMoreData = false;
  bool isLoadingMore = false;

  SearchResultsViewModel() {
    scrollController.addListener(_onScroll);
  }

  void init(Map<String, dynamic>? args) {
    if (args == null) return;
    searchQuery = args['query'] ?? '';
    searchId = args['id'];
    searchType = args['type'];
    displayType = args['displayType'];
    fetchHotels();
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoading && !isLoadingMore && hasMoreData) {
        loadMoreHotels();
      }
    }
  }

  Future<void> fetchHotels() async {
    if (isLoading) return;

    _setLoading(true);

    try {
      final response = await ApiService.searchHotels(
        query: searchQuery,
        searchId: searchId,
        searchType: searchType,
        excludedHotels: excludedHotels,
        limit: itemsPerPage,
      );

      allHotels = response.data?.arrayOfHotelList ?? [];
      excludedHotels = response.data?.arrayOfExcludedHotels ?? [];
      currentPage = 0;
      _loadPage();

      _setLoading(false);
    } catch (e) {
      _handleError(e);
    }
  }

  void _loadPage() {
    final endIndex = (currentPage + 1) * itemsPerPage;
    hotels = allHotels.sublist(
      0,
      endIndex.clamp(0, allHotels.length),
    );
    hasMoreData = endIndex < allHotels.length;
    notifyListeners();
  }

  void loadMoreHotels() {
    if (!hasMoreData || isLoadingMore) return;
    isLoadingMore = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 800), () {
      currentPage++;
      _loadPage();
      isLoadingMore = false;
      notifyListeners();
    });
  }

  void _handleError(dynamic e) {
    debugPrint('Error fetching hotels: $e');
    hasError = true;
    errorMessage =
        e.toString().contains('Failed to load') ? 'Unable to connect to server. Please try again.' : e.toString();

    if (hotels.isEmpty) {
      allHotels = _getSampleHotels(searchQuery);
      _loadPage();
    }

    _setLoading(false);
  }

  List<ArrayOfHotelList> _getSampleHotels(String query) {
    return sampleHotels.where((hotel) {
      final queryLower = query.toLowerCase();
      return hotel.propertyName!.toLowerCase().contains(queryLower) ||
          hotel.propertyAddress!.city!.toLowerCase().contains(queryLower) ||
          hotel.propertyAddress!.state!.toLowerCase().contains(queryLower);
    }).toList();
  }

  void _setLoading(bool value) {
    isLoading = value;
    hasError = false;
    errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
