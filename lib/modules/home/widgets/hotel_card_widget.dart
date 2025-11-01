import '../../../app/app.dart';

class HotelCardWidget extends StatelessWidget {
  final ArrayOfHotelList? hotel;

  const HotelCardWidget({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final isFav = vm.isFavorite;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade900),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(vm, isFav, context),
          _buildInfo(context, vm),
        ],
      ),
    );
  }

  // 🖼️ Image Section
  Widget _buildImage(HomeViewModel vm, bool isFav, BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            hotel?.propertyImage?.fullUrl ?? '',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 200,
              color: Colors.grey.shade900,
              child: Icon(Icons.bed_outlined, size: 40, color: Colors.grey.shade800),
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: () => vm.toggleFavorite(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A).withValues(alpha: 0.8),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade800),
              ),
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : Colors.grey.shade500,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 🏨 Info Section
  Widget _buildInfo(BuildContext context, HomeViewModel vm) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 6),
          _buildLocationRow(),
          const SizedBox(height: 12),
          _buildFooter(context, vm),
        ],
      ),
    );
  }

  // 📋 Header: Hotel name + type + rating
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotel?.propertyName ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFE5E5E5),
                  letterSpacing: -0.3,
                ),
              ),
              if (hotel?.propertyType != null) ...[
                const SizedBox(height: 4),
                Text(
                  hotel!.propertyType!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (hotel?.propertyStar != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, size: 14, color: Color(0xFFE5E5E5)),
                const SizedBox(width: 4),
                Text(
                  hotel?.propertyStar.toString() ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFE5E5E5),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // 📍 Address + Reviews
  Widget _buildLocationRow() {
    final address = hotel?.propertyAddress?.mapAddress ?? 'Address not available';
    final reviewCount = hotel?.googleReview?.data?.totalUserRating;

    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            address,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (reviewCount != null)
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              '$reviewCount reviews',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
            ),
          ),
      ],
    );
  }

  // 💰 Price + Book button
  Widget _buildFooter(BuildContext context, HomeViewModel vm) {
    final price = hotel?.propertyMaxPrice?.displayAmount ?? 'N/A';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '\$$price',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE5E5E5),
                ),
              ),
              TextSpan(
                text: ' / night',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () => vm.handleBooking(context, hotel?.propertyName),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade800),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: const Text(
            'Book',
            style: TextStyle(
              color: Color(0xFFE5E5E5),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
