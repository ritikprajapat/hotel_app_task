import '../../app/app.dart';

final sampleHotels = [
  ArrayOfHotelList(
    propertyCode: '1',
    propertyName: 'The Grand Plaza',
    propertyImage: PropertyImage(
      fullUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
    ),
    propertyType: 'Hotel',
    propertyStar: 5,
    googleReview: GoogleReview(
      data: GoogleReviewData(totalUserRating: 1250),
    ),
    propertyAddress: PropertyAddress(mapAddress: '123 Main Street, Downtown, New York, NY 10001'),
    propertyMaxPrice: PropertyMaxPrice(displayAmount: '249.99'),
  ),
  ArrayOfHotelList(
    propertyCode: '2',
    propertyName: 'Ocean View Resort',
    propertyImage: PropertyImage(
      fullUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
    ),
    propertyType: 'Resort',
    propertyStar: 5,
    googleReview: GoogleReview(
      data: GoogleReviewData(totalUserRating: 890),
    ),
    propertyAddress: PropertyAddress(
      mapAddress: 'Beachside Road, Malibu, California 90265',
    ),
    propertyMaxPrice: PropertyMaxPrice(displayAmount: '319.50'),
  ),
  ArrayOfHotelList(
    propertyCode: '3',
    propertyName: 'Mountain Lodge',
    propertyImage: PropertyImage(
      fullUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
    ),
    propertyType: 'Lodge',
    propertyStar: 4,
    googleReview: GoogleReview(
      data: GoogleReviewData(totalUserRating: 456),
    ),
    propertyAddress: PropertyAddress(
      mapAddress: '45 Alpine Trail, Aspen, Colorado 81611',
    ),
    propertyMaxPrice: PropertyMaxPrice(displayAmount: '189.00'),
  ),
  ArrayOfHotelList(
    propertyCode: '4',
    propertyName: 'City Center Inn',
    propertyImage: PropertyImage(
      fullUrl: 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800',
    ),
    propertyType: 'Hotel',
    propertyStar: 4,
    googleReview: GoogleReview(
      data: GoogleReviewData(totalUserRating: 678),
    ),
    propertyAddress: PropertyAddress(
      mapAddress: '789 5th Avenue, Midtown, Chicago, IL 60611',
    ),
    propertyMaxPrice: PropertyMaxPrice(displayAmount: '159.99'),
  ),
];
