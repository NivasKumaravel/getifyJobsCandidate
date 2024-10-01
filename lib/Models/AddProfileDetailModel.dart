class AddProfileDetailModel {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? gender;
  String? maritalStatus;
  String? specialization;
  String? qualification;
  String? preferredLocation;
  String? expectedSalary;
  String? currentSalary;
  String? dob;
  String? nationality;
  String? location;
  String? skillSet;
  String? differentlyAbled;
  String? passport;
  String? careerBreak;
  String? candidateId;
  Education? education;
  Employment? employment;

  AddProfileDetailModel(
      {this.name,
        this.email,
        this.phone,
        this.address,
        this.gender,
        this.maritalStatus,
        this.specialization,
        this.qualification,
        this.preferredLocation,
        this.expectedSalary,
        this.currentSalary,
        this.dob,
        this.nationality,
        this.location,
        this.skillSet,
        this.differentlyAbled,
        this.passport,
        this.careerBreak,
        this.candidateId,
        this.education,
        this.employment});

  AddProfileDetailModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    specialization = json['specialization'];
    qualification = json['qualification'];
    preferredLocation = json['preferred_location'];
    expectedSalary = json['expected_salary'];
    currentSalary = json['current_salary'];
    dob = json['dob'];
    nationality = json['nationality'];
    location = json['location'];
    skillSet = json['skill_set'];
    differentlyAbled = json['differently_abled'];
    passport = json['passport'];
    careerBreak = json['career_break'];
    candidateId = json['candidate_id'];
    education = json['education'] != null
        ? new Education.fromJson(json['education'])
        : null;
    employment = json['employment'] != null
        ? new Employment.fromJson(json['employment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['specialization'] = this.specialization;
    data['qualification'] = this.qualification;
    data['preferred_location'] = this.preferredLocation;
    data['expected_salary'] = this.expectedSalary;
    data['current_salary'] = this.currentSalary;
    data['dob'] = this.dob;
    data['nationality'] = this.nationality;
    data['location'] = this.location;
    data['skill_set'] = this.skillSet;
    data['differently_abled'] = this.differentlyAbled;
    data['passport'] = this.passport;
    data['career_break'] = this.careerBreak;
    data['candidate_id'] = this.candidateId;
    if (this.education != null) {
      data['education'] = this.education!.toJson();
    }
    if (this.employment != null) {
      data['employment'] = this.employment!.toJson();
    }
    return data;
  }
}

class Education {
  String? institute;
  String? qualification;
  String? specialization;
  String? educationType;
  String? cgpa;
  String? startDate;
  String? endDate;

  Education(
      {this.institute,
        this.qualification,
        this.specialization,
        this.educationType,
        this.cgpa,
        this.startDate,
        this.endDate});

  Education.fromJson(Map<String, dynamic> json) {
    institute = json['institute'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    educationType = json['education_type'];
    cgpa = json['cgpa'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['institute'] = this.institute;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['education_type'] = this.educationType;
    data['cgpa'] = this.cgpa;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}

class Employment {
  String? jobRole;
  String? companyName;
  String? jobType;
  String? startDate;
  String? endDate;
  String? noticePeriod;
  String? description;

  Employment(
      {this.jobRole,
        this.companyName,
        this.jobType,
        this.startDate,
        this.endDate,
        this.noticePeriod,
        this.description});

  Employment.fromJson(Map<String, dynamic> json) {
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
