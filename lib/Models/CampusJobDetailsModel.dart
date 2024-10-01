class CampusJobDetailsModel {
  bool? status;
  String? message;
  CampusJobDetailsData? data;

  CampusJobDetailsModel({this.status, this.message, this.data});

  CampusJobDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CampusJobDetailsData.fromJson(json['data']) : null;
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

class CampusJobDetailsData {
  College? college;
  String? jobId;
  String? jobTitle;
  String? jobDescription;
  String? qualification;
  String? specialization;
  String? currentArrears;
  String? historyOfArrears;
  String? requiredPercentage;
  String? location;
  String? salaryFrom;
  String? salaryTo;
  String? statutoryBenefits;
  String? socialBenefits;
  String? otherBenefits;
  String? rounds;
  String? vacancies;
  String? recruiter;
  String? companyName;
  String? logo;
  String? recruiterId;
  String? createdDate;

  CampusJobDetailsData(
      {this.college,
        this.jobId,
        this.jobTitle,
        this.jobDescription,
        this.qualification,
        this.specialization,
        this.currentArrears,
        this.historyOfArrears,
        this.requiredPercentage,
        this.location,
        this.salaryFrom,
        this.salaryTo,
        this.statutoryBenefits,
        this.socialBenefits,
        this.otherBenefits,
        this.rounds,
        this.vacancies,
        this.recruiter,
        this.companyName,
        this.logo,
        this.recruiterId,
        this.createdDate});

  CampusJobDetailsData.fromJson(Map<String, dynamic> json) {
    college =
    json['college'] != null ? new College.fromJson(json['college']) : null;
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    jobDescription = json['job_description'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    currentArrears = json['current_arrears'];
    historyOfArrears = json['history_of_arrears'];
    requiredPercentage = json['required_percentage'];
    location = json['location'];
    salaryFrom = json['salary_from'];
    salaryTo = json['salary_to'];
    statutoryBenefits = json['statutory_benefits'];
    socialBenefits = json['social_benefits'];
    otherBenefits = json['other_benefits'];
    rounds = json['rounds'];
    vacancies = json['vacancies'];
    recruiter = json['recruiter'];
    companyName = json['company_name'];
    logo = json['logo'];
    recruiterId = json['recruiter_id'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.college != null) {
      data['college'] = this.college!.toJson();
    }
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['job_description'] = this.jobDescription;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['current_arrears'] = this.currentArrears;
    data['history_of_arrears'] = this.historyOfArrears;
    data['required_percentage'] = this.requiredPercentage;
    data['location'] = this.location;
    data['salary_from'] = this.salaryFrom;
    data['salary_to'] = this.salaryTo;
    data['statutory_benefits'] = this.statutoryBenefits;
    data['social_benefits'] = this.socialBenefits;
    data['other_benefits'] = this.otherBenefits;
    data['rounds'] = this.rounds;
    data['vacancies'] = this.vacancies;
    data['recruiter'] = this.recruiter;
    data['company_name'] = this.companyName;
    data['logo'] = this.logo;
    data['recruiter_id'] = this.recruiterId;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class College {
  String? campusId;
  String? name;
  String? location;
  String? logo;
  String? recruitmentDate;

  College(
      {this.campusId,
        this.name,
        this.location,
        this.logo,
        this.recruitmentDate});

  College.fromJson(Map<String, dynamic> json) {
    campusId = json['campus_id'];
    name = json['name'];
    location = json['location'];
    logo = json['logo'];
    recruitmentDate = json['recruitment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campus_id'] = this.campusId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['logo'] = this.logo;
    data['recruitment_date'] = this.recruitmentDate;
    return data;
  }
}
