class LoginModel {
  bool? status;
  bool? otp_verify_status;
  bool? profile_status;
  String? message;
  Data? data;

  LoginModel(
      {this.status,
      this.otp_verify_status,
      this.profile_status,
      this.message,
      this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    otp_verify_status = json['otp_verify_status'];
    profile_status = json['profile_status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['otp_verify_status'] = this.otp_verify_status;
    data['profile_status'] = this.profile_status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? candidateId;
  String? name;
  String? profilePic;
  String? email;
  String? phone;
  String? candidateType;

  Data(
      {this.candidateId,
      this.name,
      this.profilePic,
      this.email,
      this.phone,
      this.candidateType});

  Data.fromJson(Map<String, dynamic> json) {
    candidateId = json['candidate_id'];
    name = json['name'];
    profilePic = json['profile_pic'];
    email = json['email'];
    phone = json['phone'];
    candidateType = json['candidate_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['candidate_type'] = this.candidateType;
    return data;
  }
}
