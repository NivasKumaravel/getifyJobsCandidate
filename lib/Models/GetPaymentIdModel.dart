class GetPaymentIdModel {
  bool? status;
  String? message;
  GetPaymentData? data;

  GetPaymentIdModel({this.status, this.message, this.data});

  GetPaymentIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GetPaymentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetPaymentData {
  String? keySecret;
  String? keyId;

  GetPaymentData({this.keySecret, this.keyId});

  GetPaymentData.fromJson(Map<String, dynamic> json) {
    keySecret = json['key_secret'];
    keyId = json['key_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key_secret'] = this.keySecret;
    data['key_id'] = this.keyId;
    return data;
  }
}
