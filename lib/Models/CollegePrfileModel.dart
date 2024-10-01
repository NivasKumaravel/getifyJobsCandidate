class Collage_Profile {
  bool? status;
  String? message;
  List<DropDownData>? data;

  Collage_Profile({this.status, this.message, this.data});

  Collage_Profile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DropDownData>[];
      json['data'].forEach((v) {
        data!.add(new DropDownData.fromJson(v));
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

class DropDownData {
  String? id;
  String? token;
  String? collegeName;
  String? designation;
  String? industry;
  String? qualification;
  String? qualificationId;
  String? specialization;
  String? skills;
  String? status;
  String? createdAt;
  String? updatedAt;

  DropDownData(
      {this.id,
      this.token,
      this.collegeName,
      this.designation,
      this.industry,
      this.qualification,
      this.qualificationId,
      this.specialization,
      this.skills,
      this.status,
      this.createdAt,
      this.updatedAt});

  DropDownData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    collegeName = json['college_name'];
    designation = json['designation'];
    industry = json['industry'];
    qualification = json['qualification'] != null
        ? json['qualification']
        : json['college_name'] != null
            ? json['college_name']
            : json['designation'] != null
                ? json['designation']
                : json['specialization'] != null
                    ? json['specialization']
                    : json['skills'] != null
                        ? json['skills']
                        : json['industry'] != null
                            ? json['industry']
                            : "";
    qualificationId = json['qualification_id'];
    specialization = json['specialization'];
    skills = json['skills'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['college_name'] = this.collegeName;
    data['designation'] = this.designation;
    data['industry'] = this.industry;
    data['qualification'] = this.qualification;
    data['qualification_id'] = this.qualificationId;
    data['specialization'] = this.specialization;
    data['skills'] = this.skills;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
