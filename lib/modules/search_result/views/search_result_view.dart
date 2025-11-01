import '../../../app/app.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchResultsViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFFE5E5E5)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Results',
              style: TextStyle(
                color: Color(0xFFE5E5E5),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (vm.searchQuery.isNotEmpty)
              Text(
                vm.displayType != null ? '${vm.searchQuery} • ${vm.displayType}' : vm.searchQuery,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 🔸 Error banner
          if (vm.hasError)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade900.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade800.withValues(alpha: .3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: Colors.orange.shade400),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      vm.errorMessage,
                      style: TextStyle(color: Colors.orange.shade300, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

          // 🔸 Result summary header
          if (!vm.isLoading && vm.hotels.isNotEmpty)
            Container(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '${vm.allHotels.length}',
                        style: const TextStyle(
                          color: Color(0xFFE5E5E5),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' ${vm.allHotels.length == 1 ? 'hotel' : 'hotels'} found',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                      ),
                    ]),
                  ),
                  if (vm.hasMoreData || vm.hotels.length < vm.allHotels.length)
                    Text(
                      'Showing ${vm.hotels.length} of ${vm.allHotels.length}',
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                    ),
                ],
              ),
            ),

          // 🔸 Main content
          Expanded(
            child: vm.hotels.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade800),
                        const SizedBox(height: 16),
                        Text(
                          'No hotels found',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try searching for a different location',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: vm.scrollController,
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    itemCount: vm.hotels.length + (vm.hasMoreData ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == vm.hotels.length) {
                        return const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Loading more...',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return HotelCardWidget(hotel: vm.hotels[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
