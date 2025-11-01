class RegisterDeviceResponse {
  bool? status;
  String? message;
  int? responseCode;
  RegisterDevice? data;

  RegisterDeviceResponse({
    this.status,
    this.message,
    this.responseCode,
    this.data,
  });

  RegisterDeviceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? new RegisterDevice.fromJson(json['data']) : null;
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

class RegisterDevice {
  String? visitorToken;

  RegisterDevice({this.visitorToken});

  RegisterDevice.fromJson(Map<String, dynamic> json) {
    visitorToken = json['visitorToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visitorToken'] = this.visitorToken;
    return data;
  }
}
