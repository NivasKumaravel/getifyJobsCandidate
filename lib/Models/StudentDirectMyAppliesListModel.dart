class StudentDirectMyAppliesListModel {
  bool? status;
  String? message;
  List<StudentDirectMyAppliesListData>? data;

  StudentDirectMyAppliesListModel({this.status, this.message, this.data});

  StudentDirectMyAppliesListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentDirectMyAppliesListData>[];
      json['data'].forEach((v) {
        data!.add(new StudentDirectMyAppliesListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentDirectMyAppliesListData {
  String? jobId;
  String? jobTitle;
  String? location;
  String? experience;
  String? salaryFrom;
  String? salaryTo;
  String? name;
  String? recruiterId;
  String? companyName;
  String? logo;
  String? appliedDate;
  String? jobStatus;

  StudentDirectMyAppliesListData(
      {this.jobId,
      this.jobTitle,
      this.location,
      this.experience,
      this.salaryFrom,
      this.salaryTo,
      this.name,
      this.recruiterId,
      this.companyName,
      this.logo,
      this.appliedDate,
      this.jobStatus});

  StudentDirectMyAppliesListData.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    location = json['location'];
    experience = json['experience'];
    salaryFrom = json['salary_from'];
    salaryTo = json['salary_to'];
    name = json['name'];
    recruiterId = json['recruiter_id'];
    companyName = json['company_name'];
    logo = json['logo'];
    appliedDate = json['applied_date'];
    jobStatus = json['job_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['location'] = this.location;
    data['experience'] = this.experience;
    data['salary_from'] = this.salaryFrom;
    data['salary_to'] = this.salaryTo;
    data['name'] = this.name;
    data['recruiter_id'] = this.recruiterId;
    data['company_name'] = this.companyName;
    data['logo'] = this.logo;
    data['applied_date'] = this.appliedDate;
    data['job_status'] = this.jobStatus;
    return data;
  }
}
