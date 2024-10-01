class CampusListModel {
  bool? status;
  String? message;
  CampusListData? data;

  CampusListModel({this.status, this.message, this.data});

  CampusListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CampusListData.fromJson(json['data']) : null;
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

class CampusListData {
  int? totalItems;
  List<CampusListItems>? items;

  CampusListData({this.totalItems, this.items});

  CampusListData.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    if (json['items'] != null) {
      items = <CampusListItems>[];
      json['items'].forEach((v) {
        items!.add(new CampusListItems.fromJson(v));
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

class CampusListItems {
  String? campusId;
  String? name;
  String? location;
  String? logo;
  String? recruitmentDate;
  String? type;

  CampusListItems(
      {this.campusId,
        this.name,
        this.location,
        this.logo,
        this.recruitmentDate,
        this.type});

  CampusListItems.fromJson(Map<String, dynamic> json) {
    campusId = json['campus_id'];
    name = json['name'];
    location = json['location'];
    logo = json['logo'];
    recruitmentDate = json['recruitment_date'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campus_id'] = this.campusId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['logo'] = this.logo;
    data['recruitment_date'] = this.recruitmentDate;
    data['type'] = this.type;
    return data;
  }
}
