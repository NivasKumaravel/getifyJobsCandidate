class PaymentSuccessModel {
  bool? status;
  String? message;
  PaymentSuccessData? data;

  PaymentSuccessModel({this.status, this.message, this.data});

  PaymentSuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PaymentSuccessData.fromJson(json['data']) : null;
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

class PaymentSuccessData {
  String? candidateId;
  String? campusId;

  PaymentSuccessData({this.candidateId, this.campusId});

  PaymentSuccessData.fromJson(Map<String, dynamic> json) {
    candidateId = json['candidate_id'];
    campusId = json['campus_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    data['campus_id'] = this.campusId;
    return data;
  }
}
