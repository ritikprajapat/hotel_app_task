import '../../../app/app.dart';

class HotelSearchListWidget extends StatelessWidget {
  final bool isVisible;
  final List<SearchAutoCompleteResponse> suggestions;
  final bool isLoading;
  final void Function(SearchAutoCompleteResponse suggestion, String type) onSelectSuggestion;

  const HotelSearchListWidget({
    Key? key,
    required this.isVisible,
    required this.suggestions,
    required this.isLoading,
    required this.onSelectSuggestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      constraints: const BoxConstraints(maxHeight: 300),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade800,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Searching...',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    final allResults = _getAllResults();

    if (allResults.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              color: Colors.grey.shade700,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'No results found',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: allResults.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade900,
        indent: 56,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final result = allResults[index];
        return _buildSuggestionTile(result);
      },
    );
  }

  List<Map<String, dynamic>> _getAllResults() {
    final List<Map<String, dynamic>> results = [];

    if (suggestions.isEmpty) return results;

    final autoCompleteList = suggestions.first.data?.autoCompleteList;
    if (autoCompleteList == null) return results;

    final cityResults = autoCompleteList.byCity?.listOfResult;
    if (cityResults != null && cityResults.isNotEmpty) {
      for (var city in cityResults) {
        results.add({
          'type': 'city',
          'icon': Icons.location_city_rounded,
          'data': city,
          'response': suggestions.first,
        });
      }
    }

    final propertyResults = autoCompleteList.byPropertyName?.listOfResult;
    if (propertyResults != null && propertyResults.isNotEmpty) {
      for (var property in propertyResults) {
        results.add({
          'type': 'property',
          'icon': Icons.hotel_rounded,
          'data': property,
          'response': suggestions.first,
        });
      }
    }

    final stateResults = autoCompleteList.byState?.listOfResult;
    if (stateResults != null && stateResults.isNotEmpty) {
      for (var state in stateResults) {
        results.add({
          'type': 'state',
          'icon': Icons.map_rounded,
          'data': state,
          'response': suggestions.first,
        });
      }
    }

    final countryResults = autoCompleteList.byCountry?.listOfResult;
    if (countryResults != null && countryResults.isNotEmpty) {
      for (var country in countryResults) {
        results.add({
          'type': 'country',
          'icon': Icons.public_rounded,
          'data': country,
          'response': suggestions.first,
        });
      }
    }

    return results;
  }

  Widget _buildSuggestionTile(Map<String, dynamic> result) {
    final type = result['type'] as String;
    final icon = result['icon'] as IconData;
    final data = result['data'];
    final response = result['response'] as SearchAutoCompleteResponse;

    String title = '';
    String subtitle = '';

    if (type == 'city') {
      title = data.valueToDisplay ?? '';
      final state = data.address?.state ?? '';
      final country = data.address?.country ?? '';
      subtitle = [state, country].where((s) => s.isNotEmpty).join(', ');
    } else if (type == 'property') {
      title = data.propertyName ?? data.valueToDisplay ?? '';
      final city = data.address?.city ?? '';
      final state = data.address?.state ?? '';
      subtitle = [city, state].where((s) => s.isNotEmpty).join(', ');
    } else if (type == 'state') {
      title = data.valueToDisplay ?? '';
      subtitle = data.address?.country ?? '';
    } else if (type == 'country') {
      title = data.valueToDisplay ?? '';
      subtitle = 'Country';
    }

    return InkWell(
      onTap: () => onSelectSuggestion(response, type),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.grey.shade600,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFE5E5E5),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.arrow_outward_rounded,
              color: Colors.grey.shade700,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
