class DirectJobListModel {
  bool? status;
  String? message;
  DirectJobListData? data;

  DirectJobListModel({this.status, this.message, this.data});

  DirectJobListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new DirectJobListData.fromJson(json['data'])
        : null;
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

class DirectJobListData {
  int? totalItems;
  List<DirectJobItems>? items;

  DirectJobListData({this.totalItems, this.items});

  DirectJobListData.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    if (json['items'] != null) {
      items = <DirectJobItems>[];
      json['items'].forEach((v) {
        items!.add(new DirectJobItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_items'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DirectJobItems {
  String? jobId;
  String? jobTitle;
  String? location;
  String? experience;
  String? salaryFrom;
  String? salaryTo;
  String? recruiterId;
  String? name;
  String? companyName;
  String? logo;
  String? createdDate;
  bool? bookmark;
  bool? already_applied;

  DirectJobItems(
      {this.jobId,
      this.jobTitle,
      this.location,
      this.experience,
      this.salaryFrom,
      this.salaryTo,
      this.recruiterId,
      this.name,
      this.companyName,
      this.logo,
      this.createdDate,
      this.bookmark,
      this.already_applied});

  DirectJobItems.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    location = json['location'];
    experience = json['experience'];
    salaryFrom = json['salary_from'];
    salaryTo = json['salary_to'];
    recruiterId = json['recruiter_id'];
    name = json['name'];
    companyName = json['company_name'];
    logo = json['logo'];
    createdDate = json['created_date'];
    bookmark = json['bookmark'];
    already_applied = json['already_applied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['location'] = this.location;
    data['experience'] = this.experience;
    data['salary_from'] = this.salaryFrom;
    data['salary_to'] = this.salaryTo;
    data['recruiter_id'] = this.recruiterId;
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['logo'] = this.logo;
    data['created_date'] = this.createdDate;
    data['bookmark'] = this.bookmark;
    data['already_applied'] = this.already_applied;
    return data;
  }
}
