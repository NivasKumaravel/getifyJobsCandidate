class ForgotMobileNumber {
  bool? status;
  ForgotMobileNumberData? data;
  String? message;

  ForgotMobileNumber({this.status, this.data, this.message});

  ForgotMobileNumber.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new ForgotMobileNumberData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ForgotMobileNumberData {
  String? phone;
  String? candidateId;

  ForgotMobileNumberData({this.phone, this.candidateId});

  ForgotMobileNumberData.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    candidateId = json['candidate_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['candidate_id'] = this.candidateId;
    return data;
  }
}
