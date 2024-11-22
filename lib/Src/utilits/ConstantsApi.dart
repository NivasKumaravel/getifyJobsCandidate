enum Environment { DEV, STAGING, PROD }

class ConstantApi {
  static Map<String, dynamic> _config = _Config.debugConstants;

  static String candidateLogin = SERVER_ONE + "candidate/login";
  static String candidateRegister = SERVER_ONE + "candidate/register";
  static String editRegisterUrl = SERVER_ONE + "candidate/edit_basic_profile";
  static String candidateAddProfile = SERVER_ONE + "candidate/add_profile";
  static String otpVerification = SERVER_ONE + "candidate/otp_verification";
  static String ProfileScreen = SERVER_ONE + "settings/college";
  static String ProfileScreenQualifaction =
      SERVER_ONE + "settings/qualification";
  static String ProfileScreenspecialization =
      SERVER_ONE + "settings/all_specialization";

  static String ProfileScreenspecial = SERVER_ONE + "settings/specialization";

  static String ProfileScreenindustry = SERVER_ONE + "settings/industry";
  static String ProfileScreenskills = SERVER_ONE + "settings/skills";
  static String ProfileScreensdesignation = SERVER_ONE + "settings/designation";
  static String OtpResent = SERVER_ONE + "candidate/resend_otp";
  static String campuslistUrl = SERVER_ONE + "campus/candidate_campus_list";
  static String campusjoblistUrl = SERVER_ONE + "campus/candidate_jobs";
  static String directjoblistUrl = SERVER_ONE + "jobs/candidate_jobs_list";
  static String JobDetailsUrl = SERVER_ONE + "candidate/job_details";
  static String campusCompanyListUrl = SERVER_ONE + "campus/recruiters";
  static String campusJobDetailsUrl = SERVER_ONE + "campus/job_details";
  static String applyDirectJobUrl = SERVER_ONE + "jobs/apply_job";
  static String applyCampusJobUrl = SERVER_ONE + "campus/apply_campus_job";
  static String directMyAppliesListUrl = SERVER_ONE + "candidate/my_jobs";
  static String campusMyAppliesListUrl =
      SERVER_ONE + "candidate/my_campus_jobs";
  static String candidateProfileUrl = SERVER_ONE + "candidate/profile";
  static String candidateEditProfileUrl = SERVER_ONE + "candidate/edit_profile";

  static String bookmarkJobUrl = SERVER_ONE + "candidate/bookmark_job";
  static String inboxUrl = SERVER_ONE + "candidate/inbox";
  static String candidateUpdateInterviewUrl =
      SERVER_ONE + "candidate/update_interview_status";
  static String rescheduleInterview = SERVER_ONE + "jobs/reschedule_interview";
  static String jobFeedBackUrl = SERVER_ONE + "candidate/job_feedback";
  static String campusEnrolledJobUrl = SERVER_ONE + "candidate/enrolled_job";
  static String directEnrolledJobUrl =
      SERVER_ONE + "candidate/direct_enrolled_job";
  static String forgotMobileUrl = SERVER_ONE + "candidate/forgot_password";
  static String changeMobileNoUrl = SERVER_ONE + "candidate/change_mobile";
  static String updateMobileUrl = SERVER_ONE + "candidate/update_mobile";
  static String forgotOtpUrl = SERVER_ONE + "candidate/forgot_otp_verification";
  static String resetPassowrdUrl = SERVER_ONE + "candidate/reset_password";
  static String bookMarkListUrl = SERVER_ONE + "candidate/bookmark_job_list";
  static String changePasswordUrl = SERVER_ONE + "candidate/change_password";
  static String getPaymentUrl = SERVER_ONE + "settings/payments_keys";
  static String paymentSuccessUrl = SERVER_ONE + "candidate/payment";
  static String notificationUrl = SERVER_ONE + "candidate/notification";

  static String SOMETHING_WRONG = "Some thing wrong";
  static String NO_INTERNET = "No internet Connection";
  static String BAD_RESPONSE = "Bad Response";
  static String UNAUTHORIZED = "Un Athurized";
  static String Candidatedirectjobs = SERVER_ONE + "jobs/candidate_direct_jobs";
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.stagingConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get SERVER_ONE {
    return _config[_Config.SERVER_ONE];
  }

  static get BUILD_VARIANTS {
    return _config[_Config.BUILD_VARIANTS];
  }
}

class _Config {
  static const SERVER_ONE = "";
  static const BUILD_VARIANTS = "GetifyJobs-dev";

  static Map<String, dynamic> debugConstants = {
    SERVER_ONE: "https://qa.getifyjobs.com/api/",
    BUILD_VARIANTS: "GetifyJobs-dev",
  };

  static Map<String, dynamic> stagingConstants = {
    SERVER_ONE: "https://qa.getifyjobs.com/api/",
    BUILD_VARIANTS: "GetifyJobs-dev",
  };

  static Map<String, dynamic> prodConstants = {
    SERVER_ONE: "https://qa.getifyjobs.com/api/",
    BUILD_VARIANTS: "GetifyJobs-dev",
  };
}
