class CandidateProfileModel {
  bool? status;
  String? message;
  canidateProfileData? data;

  CandidateProfileModel({this.status, this.message, this.data});

  CandidateProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new canidateProfileData.fromJson(json['data'])
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

class canidateProfileData {
  String? candidateId;
  String? name;
  String? profilePic;
  String? email;
  String? phone;
  String? address;
  String? gender;
  String? maritalStatus;
  String? careerStatus;
  String? designation;
  String? designationId;
  String? experience;
  String? qualification;
  String? qualificationId;
  String? specialization;
  String? specializationId;
  String? preferredLocation;
  String? currentSalary;
  String? expectedSalary;
  String? collegeName;
  String? collegeId;
  String? startYear;
  String? endYear;
  String? currentPercentage;
  String? currentArrears;
  String? historyOfArrears;
  String? resume;
  String? dob;
  String? nationality;
  String? location;
  String? languageKnown;
  int? profilePercentage;
  String? refferalCode;
  int? totalReferral;
  String? refferalUrl;
  String? skill;
  String? skillSet;
  String? differentlyAbled;
  String? passport;
  String? careerBreak;
  List<Employment>? employment;
  List<Education>? education;

  canidateProfileData(
      {this.candidateId,
      this.name,
      this.profilePic,
      this.email,
      this.phone,
      this.address,
      this.gender,
      this.maritalStatus,
      this.careerStatus,
      this.designation,
      this.designationId,
      this.experience,
      this.qualification,
      this.qualificationId,
      this.specialization,
      this.specializationId,
      this.preferredLocation,
      this.currentSalary,
      this.expectedSalary,
      this.collegeName,
      this.collegeId,
      this.startYear,
      this.endYear,
      this.currentPercentage,
      this.currentArrears,
      this.historyOfArrears,
      this.resume,
      this.dob,
      this.nationality,
      this.location,
      this.languageKnown,
      this.profilePercentage,
      this.skill,
      this.skillSet,
      this.differentlyAbled,
      this.passport,
      this.careerBreak,
      this.employment,
      this.education,
      this.refferalCode,
      this.totalReferral,
      this.refferalUrl});

  canidateProfileData.fromJson(Map<String, dynamic> json) {
    candidateId = json['candidate_id'];
    name = json['name'];
    profilePic = json['profile_pic'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    careerStatus = json['career_status'];
    designation = json['designation'];
    designationId = json['designation_id'];
    experience = json['experience'];
    qualification = json['qualification'];
    qualificationId = json['qualification_id'];
    specialization = json['specialization'];
    specializationId = json['specialization_id'];
    preferredLocation = json['preferred_location'];
    currentSalary = json['current_salary'];
    expectedSalary = json['expected_salary'];
    collegeName = json['college_name'];
    collegeId = json['college_id'];
    startYear = json['start_year'];
    endYear = json['end_year'];
    currentPercentage = json['current_percentage'];
    currentArrears = json['current_arrears'];
    historyOfArrears = json['history_of_arrears'];
    resume = json['resume'];
    dob = json['dob'];
    nationality = json['nationality'];
    location = json['location'];
    languageKnown = json['language_known'];
    profilePercentage = json['profile_percentage'];
    skill = json['skill'];
    skillSet = json['skill_set'];
    differentlyAbled = json['differently_abled'];
    passport = json['passport'];
    careerBreak = json['career_break'];
    refferalCode = json['referral_code'];
    totalReferral = json['total_referral'];
    refferalUrl = json['referral_url'];
    if (json['employment'] != null) {
      employment = <Employment>[];
      json['employment'].forEach((v) {
        employment!.add(new Employment.fromJson(v));
      });
    }
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['career_status'] = this.careerStatus;
    data['designation'] = this.designation;
    data['designation_id'] = this.designationId;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['qualification_id'] = this.qualificationId;
    data['specialization'] = this.specialization;
    data['specialization_id'] = this.specializationId;
    data['preferred_location'] = this.preferredLocation;
    data['current_salary'] = this.currentSalary;
    data['expected_salary'] = this.expectedSalary;
    data['college_name'] = this.collegeName;
    data['college_id'] = this.collegeId;
    data['start_year'] = this.startYear;
    data['end_year'] = this.endYear;
    data['current_percentage'] = this.currentPercentage;
    data['current_arrears'] = this.currentArrears;
    data['history_of_arrears'] = this.historyOfArrears;
    data['resume'] = this.resume;
    data['dob'] = this.dob;
    data['nationality'] = this.nationality;
    data['location'] = this.location;
    data['language_known'] = this.languageKnown;
    data['profile_percentage'] = this.profilePercentage;
    data['skill'] = this.skill;
    data['skill_set'] = this.skillSet;
    data['differently_abled'] = this.differentlyAbled;
    data['passport'] = this.passport;
    data['career_break'] = this.careerBreak;
    data['referral_code'] = this.refferalCode;
    data['total_referral'] = this.totalReferral;
    data['referral_url'] = this.refferalUrl;
    if (this.employment != null) {
      data['employment'] = this.employment!.map((v) => v.toJson()).toList();
    }
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employment {
  String? id;
  String? jobRole;
  String? companyName;
  String? jobType;
  String? startDate;
  String? endDate;
  String? noticePeriod;
  String? description;

  Employment(
      {this.id,
      this.jobRole,
      this.companyName,
      this.jobType,
      this.startDate,
      this.endDate,
      this.noticePeriod,
      this.description});

  Employment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobRole = json['job_role'];
    companyName = json['company_name'];
    jobType = json['job_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    noticePeriod = json['notice_period'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_role'] = this.jobRole;
    data['company_name'] = this.companyName;
    data['job_type'] = this.jobType;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['notice_period'] = this.noticePeriod;
    data['description'] = this.description;
    return data;
  }
}

class Education {
  String? id;
  String? institute;
  String? instituteId;
  String? qualificationId;
  String? qualification;
  String? specialization;
  String? specializationId;
  String? educationType;
  String? cgpa;
  String? startDate;
  String? endDate;

  Education(
      {this.id,
      this.institute,
      this.instituteId,
      this.qualificationId,
      this.qualification,
      this.specialization,
      this.specializationId,
      this.educationType,
      this.cgpa,
      this.startDate,
      this.endDate});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    institute = json['institute'];
    instituteId = json['institute_id'];
    qualificationId = json['qualification_id'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    specializationId = json['specialization_id'];
    educationType = json['education_type'];
    cgpa = json['cgpa'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['institute'] = this.institute;
    data['institute_id'] = this.instituteId;
    data['qualification_id'] = this.qualificationId;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['specialization_id'] = this.specializationId;
    data['education_type'] = this.educationType;
    data['cgpa'] = this.cgpa;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
