class SearchResultResponse {
  bool? status;
  String? message;
  int? responseCode;
  SearchResult? data;

  SearchResultResponse({this.status, this.message, this.responseCode, this.data});

  SearchResultResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? new SearchResult.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['responseCode'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SearchResult {
  List<ArrayOfHotelList>? arrayOfHotelList;
  List<String>? arrayOfExcludedHotels;
  List<String>? arrayOfExcludedSearchType;

  SearchResult({this.arrayOfHotelList, this.arrayOfExcludedHotels, this.arrayOfExcludedSearchType});

  SearchResult.fromJson(Map<String, dynamic> json) {
    if (json['arrayOfHotelList'] != null) {
      arrayOfHotelList = <ArrayOfHotelList>[];
      json['arrayOfHotelList'].forEach((v) {
        arrayOfHotelList!.add(new ArrayOfHotelList.fromJson(v));
      });
    }
    arrayOfExcludedHotels = json['arrayOfExcludedHotels'].cast<String>();
    arrayOfExcludedSearchType = json['arrayOfExcludedSearchType'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arrayOfHotelList != null) {
      data['arrayOfHotelList'] = this.arrayOfHotelList!.map((v) => v.toJson()).toList();
    }
    data['arrayOfExcludedHotels'] = this.arrayOfExcludedHotels;
    data['arrayOfExcludedSearchType'] = this.arrayOfExcludedSearchType;
    return data;
  }
}

class ArrayOfHotelList {
  String? propertyCode;
  String? propertyName;
  PropertyImage? propertyImage;
  String? propertyType;
  int? propertyStar;
  PropertyPoliciesAndAmmenities? propertyPoliciesAndAmmenities;
  PropertyAddress? propertyAddress;
  String? propertyUrl;
  String? roomName;
  int? numberOfAdults;
  MarkedPrice? markedPrice;
  PropertyMaxPrice? propertyMaxPrice;
  PropertyMaxPrice? propertyMinPrice;
  List<AvailableDeals>? availableDeals;
  SubscriptionStatus? subscriptionStatus;
  int? propertyView;
  bool? isFavorite;
  SimplPriceList? simplPriceList;
  GoogleReview? googleReview;

  ArrayOfHotelList({
    this.propertyCode,
    this.propertyName,
    this.propertyImage,
    this.propertyType,
    this.propertyStar,
    this.propertyPoliciesAndAmmenities,
    this.propertyAddress,
    this.propertyUrl,
    this.roomName,
    this.numberOfAdults,
    this.markedPrice,
    this.propertyMaxPrice,
    this.propertyMinPrice,
    this.availableDeals,
    this.subscriptionStatus,
    this.propertyView,
    this.isFavorite,
    this.simplPriceList,
    this.googleReview,
  });

  ArrayOfHotelList.fromJson(Map<String, dynamic> json) {
    propertyCode = json['propertyCode'];
    propertyName = json['propertyName'];
    propertyImage = json['propertyImage'] != null ? new PropertyImage.fromJson(json['propertyImage']) : null;
    propertyType = json['propertytype'];
    propertyStar = json['propertyStar'];
    propertyPoliciesAndAmmenities = json['propertyPoliciesAndAmmenities'] != null
        ? new PropertyPoliciesAndAmmenities.fromJson(json['propertyPoliciesAndAmmenities'])
        : null;
    propertyAddress = json['propertyAddress'] != null ? new PropertyAddress.fromJson(json['propertyAddress']) : null;
    propertyUrl = json['propertyUrl'];
    roomName = json['roomName'];
    numberOfAdults = json['numberOfAdults'];
    markedPrice = json['markedPrice'] != null ? new MarkedPrice.fromJson(json['markedPrice']) : null;
    propertyMaxPrice =
        json['propertyMaxPrice'] != null ? new PropertyMaxPrice.fromJson(json['propertyMaxPrice']) : null;
    propertyMinPrice =
        json['propertyMinPrice'] != null ? new PropertyMaxPrice.fromJson(json['propertyMinPrice']) : null;
    if (json['availableDeals'] != null) {
      availableDeals = <AvailableDeals>[];
      json['availableDeals'].forEach((v) {
        availableDeals!.add(new AvailableDeals.fromJson(v));
      });
    }
    subscriptionStatus =
        json['subscriptionStatus'] != null ? new SubscriptionStatus.fromJson(json['subscriptionStatus']) : null;
    propertyView = json['propertyView'];
    isFavorite = json['isFavorite'];
    simplPriceList = json['simplPriceList'] != null ? new SimplPriceList.fromJson(json['simplPriceList']) : null;
    googleReview = json['googleReview'] != null ? new GoogleReview.fromJson(json['googleReview']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propertyCode'] = this.propertyCode;
    data['propertyName'] = this.propertyName;
    if (this.propertyImage != null) {
      data['propertyImage'] = this.propertyImage!.toJson();
    }
    data['propertytype'] = this.propertyType;
    data['propertyStar'] = this.propertyStar;
    if (this.propertyPoliciesAndAmmenities != null) {
      data['propertyPoliciesAndAmmenities'] = this.propertyPoliciesAndAmmenities!.toJson();
    }
    if (this.propertyAddress != null) {
      data['propertyAddress'] = this.propertyAddress!.toJson();
    }
    data['propertyUrl'] = this.propertyUrl;
    data['roomName'] = this.roomName;
    data['numberOfAdults'] = this.numberOfAdults;
    if (this.markedPrice != null) {
      data['markedPrice'] = this.markedPrice!.toJson();
    }
    if (this.propertyMaxPrice != null) {
      data['propertyMaxPrice'] = this.propertyMaxPrice!.toJson();
    }
    if (this.propertyMinPrice != null) {
      data['propertyMinPrice'] = this.propertyMinPrice!.toJson();
    }
    if (this.availableDeals != null) {
      data['availableDeals'] = this.availableDeals!.map((v) => v.toJson()).toList();
    }
    if (this.subscriptionStatus != null) {
      data['subscriptionStatus'] = this.subscriptionStatus!.toJson();
    }
    data['propertyView'] = this.propertyView;
    data['isFavorite'] = this.isFavorite;
    if (this.simplPriceList != null) {
      data['simplPriceList'] = this.simplPriceList!.toJson();
    }
    if (this.googleReview != null) {
      data['googleReview'] = this.googleReview!.toJson();
    }
    return data;
  }
}

class PropertyImage {
  String? fullUrl;
  String? location;
  String? imageName;

  PropertyImage({this.fullUrl, this.location, this.imageName});

  PropertyImage.fromJson(Map<String, dynamic> json) {
    fullUrl = json['fullUrl'];
    location = json['location'];
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullUrl'] = this.fullUrl;
    data['location'] = this.location;
    data['imageName'] = this.imageName;
    return data;
  }
}

class PropertyPoliciesAndAmmenities {
  bool? present;
  PropertyPoliciesAndAmenitiesData? data;

  PropertyPoliciesAndAmmenities({this.present, this.data});

  PropertyPoliciesAndAmmenities.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    data = json['data'] != null ? new PropertyPoliciesAndAmenitiesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PropertyPoliciesAndAmenitiesData {
  String? cancelPolicy;
  String? refundPolicy;
  String? childPolicy;
  String? damagePolicy;
  String? propertyRestriction;
  bool? petsAllowed;
  bool? coupleFriendly;
  bool? suitableForChildren;
  bool? bachularsAllowed;
  bool? freeWifi;
  bool? freeCancellation;
  bool? payAtHotel;
  bool? payNow;
  String? lastUpdatedOn;

  PropertyPoliciesAndAmenitiesData(
      {this.cancelPolicy,
      this.refundPolicy,
      this.childPolicy,
      this.damagePolicy,
      this.propertyRestriction,
      this.petsAllowed,
      this.coupleFriendly,
      this.suitableForChildren,
      this.bachularsAllowed,
      this.freeWifi,
      this.freeCancellation,
      this.payAtHotel,
      this.payNow,
      this.lastUpdatedOn});

  PropertyPoliciesAndAmenitiesData.fromJson(Map<String, dynamic> json) {
    cancelPolicy = json['cancelPolicy'];
    refundPolicy = json['refundPolicy'];
    childPolicy = json['childPolicy'];
    damagePolicy = json['damagePolicy'];
    propertyRestriction = json['propertyRestriction'];
    petsAllowed = json['petsAllowed'];
    coupleFriendly = json['coupleFriendly'];
    suitableForChildren = json['suitableForChildren'];
    bachularsAllowed = json['bachularsAllowed'];
    freeWifi = json['freeWifi'];
    freeCancellation = json['freeCancellation'];
    payAtHotel = json['payAtHotel'];
    payNow = json['payNow'];
    lastUpdatedOn = json['lastUpdatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cancelPolicy'] = this.cancelPolicy;
    data['refundPolicy'] = this.refundPolicy;
    data['childPolicy'] = this.childPolicy;
    data['damagePolicy'] = this.damagePolicy;
    data['propertyRestriction'] = this.propertyRestriction;
    data['petsAllowed'] = this.petsAllowed;
    data['coupleFriendly'] = this.coupleFriendly;
    data['suitableForChildren'] = this.suitableForChildren;
    data['bachularsAllowed'] = this.bachularsAllowed;
    data['freeWifi'] = this.freeWifi;
    data['freeCancellation'] = this.freeCancellation;
    data['payAtHotel'] = this.payAtHotel;
    data['payNow'] = this.payNow;
    data['lastUpdatedOn'] = this.lastUpdatedOn;
    return data;
  }
}

class PropertyAddress {
  String? street;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? mapAddress;
  double? latitude;
  double? longitude;

  PropertyAddress(
      {this.street, this.city, this.state, this.country, this.zipcode, this.mapAddress, this.latitude, this.longitude});

  PropertyAddress.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipcode = json['zipcode'];
    mapAddress = json['mapAddress'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['mapAddress'] = this.mapAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class MarkedPrice {
  double? amount;
  String? displayAmount;
  String? currencyAmount;
  String? currencySymbol;

  MarkedPrice({
    this.amount,
    this.displayAmount,
    this.currencyAmount,
    this.currencySymbol,
  });

  MarkedPrice.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    displayAmount = json['displayAmount'];
    currencyAmount = json['currencyAmount'];
    currencySymbol = json['currencySymbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['displayAmount'] = this.displayAmount;
    data['currencyAmount'] = this.currencyAmount;
    data['currencySymbol'] = this.currencySymbol;
    return data;
  }
}

class PropertyMaxPrice {
  int? amount;
  String? displayAmount;
  String? currencyAmount;
  String? currencySymbol;

  PropertyMaxPrice({this.amount, this.displayAmount, this.currencyAmount, this.currencySymbol});

  PropertyMaxPrice.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    displayAmount = json['displayAmount'];
    currencyAmount = json['currencyAmount'];
    currencySymbol = json['currencySymbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['displayAmount'] = this.displayAmount;
    data['currencyAmount'] = this.currencyAmount;
    data['currencySymbol'] = this.currencySymbol;
    return data;
  }
}

class AvailableDeals {
  String? headerName;
  String? websiteUrl;
  String? dealType;
  PropertyMaxPrice? price;

  AvailableDeals({this.headerName, this.websiteUrl, this.dealType, this.price});

  AvailableDeals.fromJson(Map<String, dynamic> json) {
    headerName = json['headerName'];
    websiteUrl = json['websiteUrl'];
    dealType = json['dealType'];
    price = json['price'] != null ? new PropertyMaxPrice.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headerName'] = this.headerName;
    data['websiteUrl'] = this.websiteUrl;
    data['dealType'] = this.dealType;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class SubscriptionStatus {
  bool? status;

  SubscriptionStatus({this.status});

  SubscriptionStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}

class SimplPriceList {
  MarkedPrice? simplPrice;
  int? originalPrice;

  SimplPriceList({this.simplPrice, this.originalPrice});

  SimplPriceList.fromJson(Map<String, dynamic> json) {
    simplPrice = json['simplPrice'] != null ? new MarkedPrice.fromJson(json['simplPrice']) : null;
    originalPrice = json['originalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.simplPrice != null) {
      data['simplPrice'] = this.simplPrice!.toJson();
    }
    data['originalPrice'] = this.originalPrice;
    return data;
  }
}

class GoogleReview {
  bool? reviewPresent;
  GoogleReviewData? data;

  GoogleReview({this.reviewPresent, this.data});

  GoogleReview.fromJson(Map<String, dynamic> json) {
    reviewPresent = json['reviewPresent'];
    data = json['data'] != null ? new GoogleReviewData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewPresent'] = this.reviewPresent;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GoogleReviewData {
  double? overallRating;
  int? totalUserRating;
  int? withoutDecimal;

  GoogleReviewData({this.overallRating, this.totalUserRating, this.withoutDecimal});

  GoogleReviewData.fromJson(Map<String, dynamic> json) {
    overallRating = json['overallRating'];
    totalUserRating = json['totalUserRating'];
    withoutDecimal = json['withoutDecimal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overallRating'] = this.overallRating;
    data['totalUserRating'] = this.totalUserRating;
    data['withoutDecimal'] = this.withoutDecimal;
    return data;
  }
}
