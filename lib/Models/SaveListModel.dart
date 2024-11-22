class Saved_Job_List {
  bool? status;
  String? message;
  Saved_Job_Data? data;

  Saved_Job_List({this.status, this.message, this.data});

  Saved_Job_List.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Saved_Job_Data.fromJson(json['data']) : null;
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

class Saved_Job_Data {
  int? totalItems;
  SavedItems? items;

  Saved_Job_Data({this.totalItems, this.items});

  Saved_Job_Data.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    items = json['items'] != null ? new SavedItems.fromJson(json['items']) : null;
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

class SavedItems {
  String? jobId;
  String? jobTitle;
  String? jobDescription;
  String? skills;
  String? qualification;
  String? specialization;
  String? currentArrears;
  String? historyOfArrears;
  String? requiredPercentage;
  String? location;
  String? experience;
  String? yearsOfExperience;
  String? workType;
  String? workMode;
  String? shiftDetails;
  String? salaryFrom;
  String? salaryTo;
  String? statutoryBenefits;
  String? socialBenefits;
  String? otherBenefits;
  String? recruiter;
  String? companyName;
  String? logo;
  String? jobUrl;
  String? recruiterId;
  String? createdDate;
  String? expiryDate;
  String? offerLetter;
  bool? showFeeedback;
  bool? resume;

  SavedItems(
      {this.jobId,
        this.jobTitle,
        this.jobDescription,
        this.skills,
        this.qualification,
        this.specialization,
        this.currentArrears,
        this.historyOfArrears,
        this.requiredPercentage,
        this.location,
        this.experience,
        this.yearsOfExperience,
        this.workType,
        this.workMode,
        this.shiftDetails,
        this.salaryFrom,
        this.salaryTo,
        this.statutoryBenefits,
        this.socialBenefits,
        this.otherBenefits,
        this.recruiter,
        this.companyName,
        this.logo,
        this.jobUrl,
        this.recruiterId,
        this.createdDate,
        this.expiryDate,
        this.offerLetter,
        this.showFeeedback,
        this.resume});

  SavedItems.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    jobDescription = json['job_description'];
    skills = json['skills'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    currentArrears = json['current_arrears'];
    historyOfArrears = json['history_of_arrears'];
    requiredPercentage = json['required_percentage'];
    location = json['location'];
    experience = json['experience'];
    yearsOfExperience = json['years_of_experience'];
    workType = json['work_type'];
    workMode = json['work_mode'];
    shiftDetails = json['shift_details'];
    salaryFrom = json['salary_from'];
    salaryTo = json['salary_to'];
    statutoryBenefits = json['statutory_benefits'];
    socialBenefits = json['social_benefits'];
    otherBenefits = json['other_benefits'];
    recruiter = json['recruiter'];
    companyName = json['company_name'];
    logo = json['logo'];
    jobUrl = json['job_url'];
    recruiterId = json['recruiter_id'];
    createdDate = json['created_date'];
    expiryDate = json['expiry_date'];
    offerLetter = json['offer_letter'];
    showFeeedback = json['show_feeedback'];
    resume = json['resume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['job_description'] = this.jobDescription;
    data['skills'] = this.skills;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['current_arrears'] = this.currentArrears;
    data['history_of_arrears'] = this.historyOfArrears;
    data['required_percentage'] = this.requiredPercentage;
    data['location'] = this.location;
    data['experience'] = this.experience;
    data['years_of_experience'] = this.yearsOfExperience;
    data['work_type'] = this.workType;
    data['work_mode'] = this.workMode;
    data['shift_details'] = this.shiftDetails;
    data['salary_from'] = this.salaryFrom;
    data['salary_to'] = this.salaryTo;
    data['statutory_benefits'] = this.statutoryBenefits;
    data['social_benefits'] = this.socialBenefits;
    data['other_benefits'] = this.otherBenefits;
    data['recruiter'] = this.recruiter;
    data['company_name'] = this.companyName;
    data['logo'] = this.logo;
    data['job_url'] = this.jobUrl;
    data['recruiter_id'] = this.recruiterId;
    data['created_date'] = this.createdDate;
    data['expiry_date'] = this.expiryDate;
    data['offer_letter'] = this.offerLetter;
    data['show_feeedback'] = this.showFeeedback;
    data['resume'] = this.resume;
    return data;
  }
}