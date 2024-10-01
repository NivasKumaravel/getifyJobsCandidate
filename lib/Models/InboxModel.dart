class InboxModel {
  bool? status;
  String? message;
  InboxData? data;

  InboxModel({this.status, this.message, this.data});

  InboxModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new InboxData.fromJson(json['data']) : null;
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

class InboxData {
  Count? count;
  int? totalItems;
  List<Items>? items;

  InboxData({this.count, this.totalItems, this.items});

  InboxData.fromJson(Map<String, dynamic> json) {
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    totalItems = json['total_items'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    data['total_items'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Count {
  int? accepted;
  int? selected;

  Count({this.accepted, this.selected});

  Count.fromJson(Map<String, dynamic> json) {
    accepted = json['accepted'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accepted'] = this.accepted;
    data['selected'] = this.selected;
    return data;
  }
}

class Items {
  String? companyName;
  String? logo;
  String? jobTitle;
  String? jobId;
  String? jobStatus;
  String? location;
  String? salaryFrom;
  String? salaryTo;
  String? appliedDate;

  Items(
      {this.companyName,
      this.logo,
      this.jobTitle,
      this.jobId,
      this.jobStatus,
      this.location,
      this.salaryFrom,
      this.salaryTo,
      this.appliedDate});

  Items.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    logo = json['logo'];
    jobTitle = json['job_title'];
    jobId = json['job_id'];
    jobStatus = json['job_status'];
    location = json['location'];
    salaryFrom = json['salary_from'];
    salaryTo = json['salary_to'];
    appliedDate = json['applied_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['logo'] = this.logo;
    data['job_title'] = this.jobTitle;
    data['job_id'] = this.jobId;
    data['job_status'] = this.jobStatus;
    data['location'] = this.location;
    data['salary_from'] = this.salaryFrom;
    data['salary_to'] = this.salaryTo;
    data['applied_date'] = this.appliedDate;
    return data;
  }
}
