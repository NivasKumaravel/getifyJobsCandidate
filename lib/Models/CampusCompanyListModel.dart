class CampusCompanyListModel {
  bool? status;
  String? message;
  CampusCompanyListData? data;

  CampusCompanyListModel({this.status, this.message, this.data});

  CampusCompanyListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CampusCompanyListData.fromJson(json['data']) : null;
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

class CampusCompanyListData {
  int? totalItems;
  Items? items;

  CampusCompanyListData({this.totalItems, this.items});

  CampusCompanyListData.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_items'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.toJson();
    }
    return data;
  }
}

class Items {
  String? campusId;
  String? name;
  String? location;
  String? totalCompanies;
  String? logo;
  String? recruitmentDate;
  int? appliedCount;
  int? fees;
  String? type;
  bool? payment;
  List<Recruiters>? recruiters;

  Items(
      {this.campusId,
        this.name,
        this.location,
        this.totalCompanies,
        this.logo,
        this.recruitmentDate,
        this.appliedCount,
        this.fees,
        this.type,
        this.payment,
        this.recruiters});

  Items.fromJson(Map<String, dynamic> json) {
    campusId = json['campus_id'];
    name = json['name'];
    location = json['location'];
    totalCompanies = json['total_companies'];
    logo = json['logo'];
    recruitmentDate = json['recruitment_date'];
    appliedCount = json['applied_count'];
    fees = json['fees'];
    type = json['type'];
    payment = json['payment'];
    if (json['recruiters'] != null) {
      recruiters = <Recruiters>[];
      json['recruiters'].forEach((v) {
        recruiters!.add(new Recruiters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campus_id'] = this.campusId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['total_companies'] = this.totalCompanies;
    data['logo'] = this.logo;
    data['recruitment_date'] = this.recruitmentDate;
    data['applied_count'] = this.appliedCount;
    data['fees'] = this.fees;
    data['type'] = this.type;
    data['payment'] = this.payment;
    if (this.recruiters != null) {
      data['recruiters'] = this.recruiters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recruiters {
  String? recruiterId;
  String? name;
  String? companyName;
  String? location;
  int? appliedCandidate;
  String? logo;

  Recruiters(
      {this.recruiterId,
        this.name,
        this.companyName,
        this.location,
        this.appliedCandidate,
        this.logo});

  Recruiters.fromJson(Map<String, dynamic> json) {
    recruiterId = json['recruiter_id'];
    name = json['name'];
    companyName = json['company_name'];
    location = json['location'];
    appliedCandidate = json['applied_candidate'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recruiter_id'] = this.recruiterId;
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['location'] = this.location;
    data['applied_candidate'] = this.appliedCandidate;
    data['logo'] = this.logo;
    return data;
  }
}
