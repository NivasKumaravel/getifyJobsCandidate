class StudentCampusMyAppliesListModel {
  bool? status;
  String? message;
  List<StudentCampusMyAppliesListData>? data;

  StudentCampusMyAppliesListModel({this.status, this.message, this.data});

  StudentCampusMyAppliesListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentCampusMyAppliesListData>[];
      json['data'].forEach((v) {
        data!.add(new StudentCampusMyAppliesListData.fromJson(v));
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

class StudentCampusMyAppliesListData {
  String? jobId;
  String? jobTitle;
  String? location;
  String? salaryFrom;
  String? salaryTo;
  String? name;
  String? recruiterId;
  String? companyName;
  String? logo;
  String? appliedDate;
  String? jobStatus;
  String? interviewdate;
  String? interviewtime;
  String? branch;
  College? college;

  StudentCampusMyAppliesListData(
      {this.jobId,
        this.jobTitle,
        this.location,
        this.salaryFrom,
        this.salaryTo,
        this.name,
        this.recruiterId,
        this.companyName,
        this.logo,
        this.appliedDate,
        this.jobStatus,
        this.interviewdate,
        this.interviewtime,
        this.branch,
        this.college});

  StudentCampusMyAppliesListData.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    location = json['location'];
    salaryFrom = json['salary_from'];
    salaryTo = json['salary_to'];
    name = json['name'];
    recruiterId = json['recruiter_id'];
    companyName = json['company_name'];
    logo = json['logo'];
    appliedDate = json['applied_date'];
    jobStatus = json['job_status'];
    interviewdate = json['interview_date'];
    interviewtime = json['interview_time'];
    branch = json['branch'];
    college =
    json['college'] != null ? new College.fromJson(json['college']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['location'] = this.location;
    data['salary_from'] = this.salaryFrom;
    data['salary_to'] = this.salaryTo;
    data['name'] = this.name;
    data['recruiter_id'] = this.recruiterId;
    data['company_name'] = this.companyName;
    data['logo'] = this.logo;
    data['applied_date'] = this.appliedDate;
    data['job_status'] = this.jobStatus;
    data['interview_date'] = this.interviewdate;
    data['interview_time'] = this.interviewtime;
    data['branch'] = this.branch;
    if (this.college != null) {
      data['college'] = this.college!.toJson();
    }
    return data;
  }
}

class College {
  String? campusId;
  String? name;
  String? location;
  String? logo;
  String? type;

  College({this.campusId, this.name, this.location, this.logo, this.type});

  College.fromJson(Map<String, dynamic> json) {
    campusId = json['campus_id'];
    name = json['name'];
    location = json['location'];
    logo = json['logo'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campus_id'] = this.campusId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['logo'] = this.logo;
    data['type'] = this.type;
    return data;
  }
}
