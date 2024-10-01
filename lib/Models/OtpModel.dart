class OtpModel {
  bool? status;
  String? message;
  Data? data;

  OtpModel({this.status, this.message, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? candidateId;

  Data({this.candidateId});

  Data.fromJson(Map<String, dynamic> json) {
    candidateId = json['candidate_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    return data;
  }
}
