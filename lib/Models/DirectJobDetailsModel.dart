class Job_details_model {
  bool? status;
  String? message;
  Data? data;

  Job_details_model({this.status, this.message, this.data});

  Job_details_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
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
  String? joburl;
  String? logo;
  String? recruiterId;
  String? createdDate;
  String? expiryDate;
  String? offerLetter;
  bool? showFeeedback;
  bool? resume;
  ScheduleRequested? scheduleRequested;
  ScheduleRequested? candidateReschedule;
  ScheduleRequested? recruiterReschedule;
  ScheduleRequested? scheduleAccepted;
  ScheduleRequested? scheduleRejected;
  ScheduleRequested? interviewReschedule;
  String? jobStatus;
  String? statusMessage;

  Data(
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
        this.joburl,
        this.logo,
        this.recruiterId,
        this.createdDate,
        this.expiryDate,
        this.offerLetter,
        this.showFeeedback,
        this.resume,
        this.scheduleRequested,
        this.candidateReschedule,
        this.recruiterReschedule,
        this.scheduleAccepted,
        this.scheduleRejected,
        this.interviewReschedule,
        this.jobStatus,
        this.statusMessage});

  Data.fromJson(Map<String, dynamic> json) {
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
    joburl = json['job_url'];
    logo = json['logo'];
    recruiterId = json['recruiter_id'];
    createdDate = json['created_date'];
    expiryDate = json['expiry_date'];
    offerLetter = json['offer_letter'];
    showFeeedback = json['show_feeedback'];
    resume = json['resume'];


    dynamic schedule_requested = json['schedule_requested'];

    if (schedule_requested is List) {
      print("List");
    } else {
      scheduleRequested  =
      new ScheduleRequested.fromJson(json['schedule_requested']);
    }


    dynamic candidate_reschedule = json['candidate_reschedule'];

    if (candidate_reschedule is List) {
      print("List");
    } else {
      candidateReschedule  =
      new ScheduleRequested.fromJson(json['candidate_reschedule']);
    }

    dynamic recruiter_reschedule = json['recruiter_reschedule'];

    if (recruiter_reschedule is List) {
      print("List");
    } else {
      recruiterReschedule  =
      new ScheduleRequested.fromJson(json['recruiter_reschedule']);
    }


    dynamic schedule_accepted = json['schedule_accepted'];

    if (schedule_accepted is List) {
      print("List");
    } else {
      scheduleAccepted =
      new ScheduleRequested.fromJson(json['schedule_accepted']);
    }
    dynamic schedule_rejected = json['schedule_rejected'];

    if (schedule_rejected is List) {
      print("List");
    } else {
      scheduleRejected =
      new ScheduleRequested.fromJson(json['schedule_rejected']);
    }
    dynamic interview_reschedule = json['interview_reschedule'];
    if(interview_reschedule is List){
      print('List');
    }else{
      interviewReschedule = new ScheduleRequested.fromJson(json['interview_reschedule']);
    }
    jobStatus = json['job_status'];
    statusMessage = json['status_message'];
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
    data['job_url'] = this.joburl;
    data['logo'] = this.logo;
    data['recruiter_id'] = this.recruiterId;
    data['created_date'] = this.createdDate;
    data['expiry_date'] = this.expiryDate;
    data['offer_letter'] = this.offerLetter;
    data['show_feeedback'] = this.showFeeedback;
    data['resume'] = this.resume;
    if (this.scheduleRequested != null) {
      data['schedule_requested'] = this.scheduleRequested!.toJson();
    }
    if (this.candidateReschedule != null) {
      data['candidate_reschedule'] = this.candidateReschedule!.toJson();
    }
    if (this.recruiterReschedule != null) {
      data['recruiter_reschedule'] = this.recruiterReschedule!.toJson();
    }
    if (this.scheduleAccepted != null) {
      data['schedule_accepted'] =
          this.scheduleAccepted!.toJson();
    }
    if (this.scheduleRejected != null) {
      data['schedule_rejected'] =
          this.scheduleRejected!.toJson();
    }
    if (this.interviewReschedule != null) {
      data['interview_reschedule'] =
          this.interviewReschedule!.toJson();
    }
    data['job_status'] = this.jobStatus;
    data['status_message'] = this.statusMessage;
    return data;
  }
}

class ScheduleRequested {
  String? interviewDate;
  String? interviewTime;
  String? branch;

  ScheduleRequested({this.interviewDate, this.interviewTime, this.branch});

  ScheduleRequested.fromJson(Map<String, dynamic> json) {
    interviewDate = json['interview_date'];
    interviewTime = json['interview_time'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interview_date'] = this.interviewDate;
    data['interview_time'] = this.interviewTime;
    data['branch'] = this.branch;
    return data;
  }
}
