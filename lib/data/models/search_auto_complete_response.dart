class SearchAutoCompleteResponse {
  bool? status;
  String? message;
  int? responseCode;
  Data? data;

  SearchAutoCompleteResponse({this.status, this.message, this.responseCode, this.data});

  SearchAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  bool? present;
  int? totalNumberOfResult;
  AutoCompleteList? autoCompleteList;

  Data({this.present, this.totalNumberOfResult, this.autoCompleteList});

  Data.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    totalNumberOfResult = json['totalNumberOfResult'];
    autoCompleteList =
        json['autoCompleteList'] != null ? new AutoCompleteList.fromJson(json['autoCompleteList']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    data['totalNumberOfResult'] = this.totalNumberOfResult;
    if (this.autoCompleteList != null) {
      data['autoCompleteList'] = this.autoCompleteList!.toJson();
    }
    return data;
  }
}

class AutoCompleteList {
  ByPropertyName? byPropertyName;
  ByPropertyName? byStreet;
  ByPropertyName? byCity;
  ByState? byState;
  ByPropertyName? byCountry;

  AutoCompleteList({this.byPropertyName, this.byStreet, this.byCity, this.byState, this.byCountry});

  AutoCompleteList.fromJson(Map<String, dynamic> json) {
    byPropertyName = json['byPropertyName'] != null ? new ByPropertyName.fromJson(json['byPropertyName']) : null;
    byStreet = json['byStreet'] != null ? new ByPropertyName.fromJson(json['byStreet']) : null;
    byCity = json['byCity'] != null ? new ByPropertyName.fromJson(json['byCity']) : null;
    byState = json['byState'] != null ? new ByState.fromJson(json['byState']) : null;
    byCountry = json['byCountry'] != null ? new ByPropertyName.fromJson(json['byCountry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.byPropertyName != null) {
      data['byPropertyName'] = this.byPropertyName!.toJson();
    }
    if (this.byStreet != null) {
      data['byStreet'] = this.byStreet!.toJson();
    }
    if (this.byCity != null) {
      data['byCity'] = this.byCity!.toJson();
    }
    if (this.byState != null) {
      data['byState'] = this.byState!.toJson();
    }
    if (this.byCountry != null) {
      data['byCountry'] = this.byCountry!.toJson();
    }
    return data;
  }
}

class ByPropertyName {
  bool? present;
  List<ListOfResult>? listOfResult;
  int? numberOfResult;

  ByPropertyName({this.present, this.listOfResult, this.numberOfResult});

  ByPropertyName.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    if (json['listOfResult'] != null) {
      listOfResult = <ListOfResult>[];
      json['listOfResult'].forEach((v) {
        listOfResult!.add(new ListOfResult.fromJson(v));
      });
    }
    numberOfResult = json['numberOfResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    if (this.listOfResult != null) {
      data['listOfResult'] = this.listOfResult!.map((v) => v.toJson()).toList();
    }
    data['numberOfResult'] = this.numberOfResult;
    return data;
  }
}

class ListOfResult {
  String? valueToDisplay;
  String? propertyName;
  Address? address;
  SearchArray? searchArray;

  ListOfResult({this.valueToDisplay, this.propertyName, this.address, this.searchArray});

  ListOfResult.fromJson(Map<String, dynamic> json) {
    valueToDisplay = json['valueToDisplay'];
    propertyName = json['propertyName'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
    searchArray = json['searchArray'] != null ? new SearchArray.fromJson(json['searchArray']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valueToDisplay'] = this.valueToDisplay;
    data['propertyName'] = this.propertyName;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.searchArray != null) {
      data['searchArray'] = this.searchArray!.toJson();
    }
    return data;
  }
}

class SearchArray {
  String? type;
  List<String>? query;

  SearchArray({this.type, this.query});

  SearchArray.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    query = json['query'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['query'] = this.query;
    return data;
  }
}

class Address {
  String? street;
  String? city;
  String? state;
  String? country;

  Address({this.street, this.city, this.state, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class ByState {
  bool? present;
  List<ListOfResult>? listOfResult;
  int? numberOfResult;

  ByState({this.present, this.listOfResult, this.numberOfResult});

  ByState.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    if (json['listOfResult'] != null) {
      listOfResult = <ListOfResult>[];
      json['listOfResult'].forEach((v) {
        listOfResult!.add(new ListOfResult.fromJson(v));
      });
    }
    numberOfResult = json['numberOfResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    if (this.listOfResult != null) {
      data['listOfResult'] = this.listOfResult!.map((v) => v.toJson()).toList();
    }
    data['numberOfResult'] = this.numberOfResult;
    return data;
  }
}
