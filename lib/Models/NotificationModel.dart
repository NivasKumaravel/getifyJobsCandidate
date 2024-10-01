class NotificationModel {
  bool? status;
  String? message;
  List<NotificationData>? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
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

class NotificationData {
  String? notification;
  String? postedOn;
  String? companyName;
  String? logo;

  NotificationData({this.notification, this.postedOn, this.companyName, this.logo});

  NotificationData.fromJson(Map<String, dynamic> json) {
    notification = json['notification'];
    postedOn = json['posted_on'];
    companyName = json['company_name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification'] = this.notification;
    data['posted_on'] = this.postedOn;
    data['company_name'] = this.companyName;
    data['logo'] = this.logo;
    return data;
  }
}
