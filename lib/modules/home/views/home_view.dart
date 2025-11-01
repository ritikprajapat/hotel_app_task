import '../../../app/app.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, _) => Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          title: const Text(
            'Stay',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 22,
              letterSpacing: -0.5,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(vm),
              _buildSearchBar(context, vm),
              _buildCategories(vm),
              _buildFeaturedHotels(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(HomeViewModel vm) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello! 👋',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Color(0xFFE5E5E5),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Where would you like to stay?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      );

  Widget _buildSearchBar(BuildContext context, HomeViewModel vm) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF151515),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: vm.searchFocusNode.hasFocus ? Colors.grey.shade700 : Colors.grey.shade900,
                width: vm.searchFocusNode.hasFocus ? 1.5 : 1,
              ),
            ),
            child: TextField(
              controller: vm.searchController,
              focusNode: vm.searchFocusNode,
              style: const TextStyle(color: Color(0xFFE5E5E5), fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Search hotels, cities, destinations...',
                hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                prefixIcon: vm.isSearching
                    ? Padding(
                        padding: const EdgeInsets.all(14),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade600),
                          ),
                        ),
                      )
                    : Icon(Icons.search_rounded, color: Colors.grey.shade600),
                suffixIcon: vm.searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close_rounded, color: Colors.grey.shade600),
                        onPressed: vm.clearSearch,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              onSubmitted: (query) {
                final args = vm.handleSearch(context, query);
                if (args != null) {
                  Navigator.pushNamed(context, '/search', arguments: args);
                }
              },
            ),
          ),
          if (vm.showSuggestions)
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: HotelSearchListWidget(
                isVisible: vm.showSuggestions,
                suggestions: vm.suggestions,
                isLoading: vm.isSearching && vm.suggestions.isEmpty,
                onSelectSuggestion: (suggestion, type) {
                  final args = vm.onSuggestionTap(context, suggestion, type);
                  if (args.isNotEmpty) {
                    Navigator.pushNamed(context, '/search', arguments: args);
                  }
                },
              ),
            ),
        ],
      );

  Widget _buildCategories(HomeViewModel vm) => SizedBox(
        height: 44,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: vm.categories.length,
          itemBuilder: (context, index) {
            final category = vm.categories[index];
            final isSelected = vm.selectedCategory == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => vm.selectCategory(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFE5E5E5) : const Color(0xFF151515),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: isSelected ? const Color(0xFFE5E5E5) : Colors.grey.shade900,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category['icon'],
                        size: 18,
                        color: isSelected ? const Color(0xFF0A0A0A) : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        category['label'],
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF0A0A0A) : Colors.grey.shade500,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );

  Widget _buildFeaturedHotels() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Hotels',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFE5E5E5)),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sampleHotels.length,
            itemBuilder: (context, index) => HotelCardWidget(hotel: sampleHotels[index]),
          ),
        ],
      );
}
