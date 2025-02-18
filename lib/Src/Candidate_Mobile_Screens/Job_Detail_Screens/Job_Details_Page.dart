import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ApplyCampusJobModel.dart';
import 'package:getifyjobs/Models/ApplyDirectJobModel.dart';
import 'package:getifyjobs/Models/CampusEnrolledJobModel.dart';
import 'package:getifyjobs/Models/CandidateUpdateModel.dart';
import 'package:getifyjobs/Models/JobFeedBackModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/ShowModalBottomSheet.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Models/DirectJobDetailsModel.dart';
import '../../Common_Widgets/Text_Form_Field.dart';
import 'Campus_Job_Detail_UI/Campus_Job_Detail_Page.dart';

class Job_Details extends ConsumerStatefulWidget {
  String? jobId;
  String? recruiterId;
  bool? isApplied;
  bool? isInbox;
  bool? isSavedNeeded;
  String? TagActive;

  Job_Details(
      {super.key,
      required this.jobId,
      required this.TagActive,
      required this.recruiterId,
      required this.isApplied,
      required this.isInbox,
      required this.isSavedNeeded});

  @override
  ConsumerState<Job_Details> createState() => _Job_DetailsState();
}

class _Job_DetailsState extends ConsumerState<Job_Details> {
  Data? jobDetailsData; // Define the variable to hold the value
  ApplyDirectJobModel? ApplyJobs;
  bool isStatus = true;
  bool isBookMark = false;

  @override
  void initState() {
    super.initState();
    // setApplyJob();
    // Call the method when the widget initializes
    print("TAG ACTIVE  ::  ${widget.TagActive}");
    print("RECRUITER ID  ::  ${widget.recruiterId}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Setjobdetails();
    });
    isStatus = true;
    print("BOOK MARK STATUS ${widget.isInbox}");
    isBookMark = widget.isInbox ?? false;
  }

  void bookMarkSave() {
    setState(() {
      isBookMark = !isBookMark;
    });
  }

  DateTime selectedDate = DateTime.now();
  String? _selectedTime;
  TextEditingController dateController = TextEditingController();
  TextEditingController _FeedBack = TextEditingController();
  TextEditingController _EnterCode = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isTimeSelected = false;
  void _validateTime() {
    if (_isTimeSelected) {
      _formKey.currentState?.validate();
      // Add your logic to proceed with the button action
    }
  }

  final String qrData = "https://example.com";

  //APPLY BUTTON FUNCTIONS
  bool? isDocumentUploaded;

  Color buttonColor = blue1;
  String buttonText = "Apply job";

  void applyButtonPressed() {
    setState(() {
      setApplyJob();
      _ScheduleSection(TagActive: '');
    });
  }

  //SCHEDULING BUTTON FUNCTIONS
  bool? isYes;
  bool? isClicked;
  bool? isRescheduled;
  bool? isFeedBack;

  Future<void> setApplyJob() async {
    try {
      final apiService = ApiService(ref.read(dioProvider));

      var formData = FormData.fromMap({
        "job_id": widget.jobId,
        "candidate_id": await getcandidateId(),
        "recruiter_id": widget.recruiterId
      });
      if (SingleTon().setPdf != null) {
        formData.files.addAll([
          MapEntry(
              'resume', await MultipartFile.fromFile(SingleTon().setPdf!.path)),
        ]);
      }

      final response = await apiService.post<ApplyDirectJobModel>(
          context, ConstantApi.applyDirectJobUrl, formData);

      // Check the response status and handle it accordingly
      if (response.status == true) {
        // Update your UI or variables based on the successful response
        setState(() {
          ApplyJobs = response;
          buttonColor = green1;
          buttonText = "Applied";
          widget.isApplied = true;
          // Assign response directly to ApplyJobs
        });
        Navigator.pop(context);
      } else {
        ShowToastMessage(response.message ?? "");
        // Handle unsuccessful response or show an error message
        print('API Error: ${response.message}');
      }
    } catch (e) {
      print('Error fetching data from API: $e');
    }
  }

  Future<void> Setjobdetails() async {
    try {
      final apiService = ApiService(ref.read(dioProvider));

      var formData = FormData.fromMap({
        "candidate_id": await getcandidateId(),
        "job_id": widget.jobId,
      } // Pass appropriate FormData if needed
          );

      final response = await apiService.post<Job_details_model>(
          context, ConstantApi.JobDetailsUrl, formData);

      setState(() {
        // Assuming response.data is a Job_details_model object
        jobDetailsData = response.data; // Assigning job details data
      });
    } catch (e) {
      print('Error fetching data from API: $e');
    }
  }

  bookMarkApiResponse() async {
    final directJobListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "job_id": widget.jobId,
      "recruiter_id": widget.recruiterId
    });
    final bookMarkJobResponse =
        await directJobListApiService.post<ApplyCampusJobModel>(
            context, ConstantApi.bookmarkJobUrl, formData);

    if (bookMarkJobResponse.status == true) {
      print("SUCESS");
      bookMarkSave();
      ShowToastMessage(bookMarkJobResponse.message ?? "");
    } else {
      print("ERROR");
      ShowToastMessage(bookMarkJobResponse.message ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        title: "",
        isUsed: true,
        actions: null,
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      bottomNavigationBar: BottomBar(
        context,
        ButtonTitle: widget.isApplied == true ? "Applied" : "Apply Job",
        backgroundColor: widget.isApplied == true ? green1 : blue1,
        bookmark: isBookMark,
        onPress: () {
          setState(() {
            jobDetailsData?.resume == true
                ? applyButtonPressed()
                : showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ShowModalBottomSheet(
                        context,
                        onPress: () {
                          applyButtonPressed();
                        },
                      );
                    },
                  );
          });
        },
        shareBtnPress: () {
          _onShare(context);
        },
        onTap: () {
          bookMarkApiResponse();
        },
        isSavedUsed: widget.isSavedNeeded ?? false,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.isApplied == true)
                _ScheduleSection(
                    TagActive:
                        widget.TagActive == "Applied" ? "" : widget.TagActive),
              if (isClicked == true) _AcceptedRejectedByCandidate(),
              if (isRescheduled == true) RescheduleRequestedTag(),
              _Common_job_Deatil_Section()
            ],
          ),
        ),
      ),
    );
  }

  void _onShare(BuildContext context) async {
    Share.share(jobDetailsData?.joburl ?? "");
    // if (result.status == ShareResultStatus.success) {
    //   print('Thank you for sharing my website!');
    // }
  }

  Widget _Common_job_Deatil_Section() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //JOB TITLE
              Text(
                jobDetailsData?.jobTitle ?? "",
                style: TitleT,
              ),
              //COMPANY LOGO AND NAME
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildCompanyInfoRow(jobDetailsData?.logo ?? "",
                    jobDetailsData?.companyName ?? "", TBlack, 50, 50,
                    isMapLogo: false),
              ),
              //POSTED DATE
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Text(
                  "Posted on : " + "${jobDetailsData?.createdDate ?? ""}",
                  style: posttxt,
                ),
              ),
              //POSTED DATE
              Text(
                "Deadline   : " + "${jobDetailsData?.expiryDate ?? ""}",
                style: deadtxt,
              ),
              SizedBox(
                height: 5,
              ),
              //JOB DESCRIPTIONS
              _JobDescriptionContainer()
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        //POSTED BY SECTION
        _PostedByContainer()
      ],
    );
  }

  Widget _JobDescriptionContainer() {
    return Container(
      color: white1,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _JobDescriptionSection1(),
            //JOB DESCRIPTION CONTENT
            Text(
              "Job Description",
              style: TitleT2,
            ),
            Text(
              jobDetailsData?.jobDescription ?? "",
              style: desctxt,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),

            jobDetailsData?.skills == null
                ? Container()
                : textWithheader(
                    headertxt: "Skill Sets",
                    subtxt: jobDetailsData?.skills ?? ""),
            textWithheader(
                headertxt: "Qualification",
                subtxt: jobDetailsData?.qualification ?? ""),
            jobDetailsData?.skills == ''
                ? Container() :
            textWithheader(
                headertxt: "Specialization",
                subtxt: jobDetailsData?.specialization ?? ""),

            jobDetailsData?.yearsofexperience == null
                ? Container()
                : textWithheader(
                    headertxt: "Years of Experience",
                    subtxt: jobDetailsData?.yearsofexperience ?? ""),

            jobDetailsData?.currentArrears == ''
                ? Container()
                : jobDetailsData?.currentArrears == ''
                    ? Container()
                    : textWithheader(
                        headertxt: "Current Arrears",
                        subtxt: jobDetailsData?.currentArrears ?? ""),

            jobDetailsData?.historyOfArrears == ''
                ? Container()
                : jobDetailsData?.historyOfArrears == ''
                    ? Container()
                    : textWithheader(
                        headertxt: "History of Arrears",
                        subtxt: jobDetailsData?.historyOfArrears ?? ""),

            jobDetailsData?.requiredPercentage == ""
                ? Container()
                : textWithheader(
                    headertxt: "Required Percentage/CGPA",
                    subtxt: jobDetailsData?.requiredPercentage ?? ""),

            textWithheader(
                headertxt: "Work Type", subtxt: jobDetailsData?.workType ?? ""),

            jobDetailsData?.workMode == "Please Select" ||
                    jobDetailsData?.workMode == ""
                ? Container()
                : textWithheader(
                    headertxt: "Work Mode",
                    subtxt: jobDetailsData?.workMode ?? ""),

            textWithheader(
                headertxt: "Shift Details",
                subtxt: jobDetailsData?.shiftDetails ?? ""),
            jobDetailsData?.statutoryBenefits == null
                ? Container()
                : jobDetailsData?.statutoryBenefits == ""
                    ? Container()
                    : textWithheader(
                        headertxt: "Statutory Benefits",
                        subtxt: jobDetailsData?.statutoryBenefits ?? ""),
            jobDetailsData?.socialBenefits == null
                ? Container()
                : jobDetailsData?.socialBenefits == ""
                    ? Container()
                    : textWithheader(
                        headertxt: "Social Benefits",
                        subtxt: jobDetailsData?.socialBenefits ?? ""),
            jobDetailsData?.otherBenefits == null
                ? Container()
                : jobDetailsData?.otherBenefits == ""
                    ? Container()
                    : textWithheader(
                        headertxt: "Other Benefits",
                        subtxt: jobDetailsData?.otherBenefits ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _JobDescriptionSection1() {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        _IconWithText(
            iconimg: "bag.svg", icontext: jobDetailsData?.experience ?? ""),
        //LOCATION
        _IconWithText(
            iconimg: "map-pin.svg", icontext: jobDetailsData?.location ?? ""),
        //SALARY
        _IconWithText(
            iconimg: "wallet.svg",
            icontext:
                "₹${jobDetailsData?.salaryFrom ?? ""} - ${jobDetailsData?.salaryTo ?? ""} Per Annum")
      ],
    );
  }

  Widget _IconWithText({required String iconimg, required String icontext}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          ImgPathSvg(iconimg),
          SizedBox(
            width: 5,
          ),
          Expanded(child: Text(icontext, style: posttxt))
        ],
      ),
    );
  }

  Widget _PostedByContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: white1,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Posted by",
              style: bluetxt,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width / 1.2,
              child: Text(
                jobDetailsData?.recruiter ?? "",
                style: stxt,
                maxLines: 2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  //SCHEDULE REQUEST SECTION
  Widget _ScheduleSection({required String? TagActive}) {
    return TagActive == ""
        ? Container()
        : Container(
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: TagActive == "Schedule Accepted"
                      ? green2
                      : TagActive == "Schedule Requested"
                          ? yellow2
                          : TagActive == "Schedule Rejected"
                              ? white1
                              : TagActive == "Rejected"
                                  ? white1
                                  : TagActive == "Candidate Rescheduled"
                                      ? yellow2
                                      : TagActive == 'Recruiter Rescheduled'
                                          ? yellow2
                                          : TagActive == 'Interview Rescheduled'
                                              ? yellow2
                                              : TagActive == 'Selected'
                                                  ? green2
                                                  : TagActive == 'Wait List'
                                                      ? yellow2
                                                      : white1,
                  child: Center(
                    child: Text(
                      TagActive == "Schedule Requested"
                          ? "Schedule Requested"
                          : TagActive == "Schedule Accepted"
                              ? "Schedule Accepted"
                              : TagActive == "Schedule Rejected"
                                  ? "Schedule Rejected"
                                  : TagActive == "Candidate Rescheduled"
                                      ? "Reschedule Requested"
                                      : TagActive == 'Recruiter Rescheduled'
                                          ? "Recruiter Rescheduled"
                                          : TagActive == 'Interview Rescheduled'
                                              ? "Recruiter Rescheduled"
                                              : TagActive == 'Not Shortlisted'
                                                  ? "Not Shortlisted"
                                                  : TagActive == "Wait List"
                                                      ? 'Waiting For Result'
                                                      : TagActive == "Selected"
                                                          ? 'You were Selected'
                                                          : TagActive ==
                                                                  "Rejected"
                                                              ? 'You were Rejected'
                                                              : TagActive ==
                                                                      "You were not Shortlisted"
                                                                  ? 'You were not Shortlisted'
                                                                  : '',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: TagActive == "Schedule Accepted"
                              ? green1
                              : TagActive == "Schedule Rejected"
                                  ? grey4
                                  : TagActive == "Rejected"
                                      ? grey4
                                      : TagActive == "Schedule Requested"
                                          ? yellow1
                                          : TagActive == "Candidate Rescheduled"
                                              ? yellow1
                                              : TagActive ==
                                                      'Recruiter Rescheduled'
                                                  ? yellow1
                                                  : TagActive ==
                                                          'Interview Rescheduled'
                                                      ? yellow1
                                                      : TagActive ==
                                                              'Not Shortlisted'
                                                          ? grey4
                                                          : TagActive ==
                                                                  'Wait List'
                                                              ? yellow1
                                                              : TagActive ==
                                                                      'Selected'
                                                                  ? green1
                                                                  : TagActive ==
                                                                          'You were not Shortlisted'
                                                                      ? grey4
                                                                      : white1),
                    ),
                  ),
                ),
                // TagActive=="Schedule Request"?
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 25,
                        left: 25,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              TagActive == "Schedule Accepted"
                                  ? "You Accepted the Interview on"
                                  : TagActive == "Schedule Requested"
                                      ? "Are you okay with the date & time?"
                                      : TagActive == "Schedule Rejected"
                                          ? "The schedule has been Rejected"
                                          : TagActive == "Candidate Rescheduled"
                                              ? "You were Shortlisted for the Interview on"
                                              : TagActive ==
                                                      "Recruiter Rescheduled"
                                                  ? "You were Shortlisted for the Interview on"
                                                  : TagActive ==
                                                          "Interview Rescheduled"
                                                      ? "Recruiter Reschedule Interview on"
                                                      : "",
                              style: TagActive == "Schedule Accepted"
                                  ? attachT1
                                  : TagActive == "Schedule Requested"
                                      ? attachT1
                                      : TagActive == "Schedule Rejected"
                                          ? attachT1
                                          : attacht1,
                              // TagActive=="Reschedule"?attacht1:
                            ),
                            Text(
                              TagActive == "Schedule Accepted"
                                  ? "${jobDetailsData?.scheduleAccepted?.interviewTime == [] ? jobDetailsData?.scheduleRequested?.interviewTime ?? "" : jobDetailsData?.scheduleAccepted?.interviewTime ?? ""}, "
                                      "${jobDetailsData?.scheduleAccepted?.interviewDate == [] ? jobDetailsData?.scheduleRequested?.interviewDate ?? "" : jobDetailsData?.scheduleAccepted?.interviewDate ?? ""}"
                                  : TagActive == "Schedule Requested"
                                      ? "${jobDetailsData?.scheduleRequested?.interviewDate ?? ""}, ${jobDetailsData?.scheduleRequested?.interviewTime ?? ""}"
                                      : TagActive == "You Rejected"
                                          ? "9.00 AM, 02 Oct 2023"
                                          : TagActive == "Candidate Rescheduled"
                                              ? "${jobDetailsData?.scheduleRequested?.interviewTime ?? ""}, ${jobDetailsData?.scheduleRequested?.interviewDate ?? ""}"
                                              : TagActive ==
                                                      "Recruiter Rescheduled"
                                                  ? "${jobDetailsData?.scheduleRequested?.interviewTime ?? ""}, ${jobDetailsData?.scheduleRequested?.interviewDate ?? ""}"
                                                  : TagActive ==
                                                          "Interview Rescheduled"
                                                      ? "${jobDetailsData?.interviewReschedule?.interviewTime ?? ""}, ${jobDetailsData?.interviewReschedule?.interviewDate ?? ""}"
                                                      : "",
                              style: TagActive == "Schedule Accepted"
                                  ? TBlack
                                  : TagActive == "Schedule Requested"
                                      ? TBlack
                                      : TagActive == "Schedule Rejected"
                                          ? TBlack
                                          : Homewhite,
                            ),
                            TagActive == "Schedule Accepted"
                                ? _ScanDetail(context)
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    TagActive == "Schedule Requested"
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 25, left: 20, right: 20),
                            child: isRescheduled == true
                                ? Container()
                                : isStatus == true
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: MediaQuery.sizeOf(context)
                                                      .width /
                                                  4.5,
                                              child: CommonElevatedButton2(
                                                  context, "Yes", () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      RescheduleConfirmationPop(
                                                          context,
                                                          typeT: 'accept',
                                                          onPress: () {
                                                    ScheduleAcceptedResponse();
                                                  },
                                                          scheduleT: TagActive ==
                                                                  "Schedule Requested"
                                                              ? 'Scheduled'
                                                              : 'Rescheduled'),
                                                );
                                              })),
                                          Container(
                                              height: 55,
                                              width: MediaQuery.sizeOf(context)
                                                      .width /
                                                  2.7,
                                              child: CommonElevatedButton2(
                                                  context,
                                                  "Reschedule Request", () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          RescheduleDatePop(
                                                              context),
                                                );
                                              })),
                                          Container(
                                              height: 50,
                                              width: MediaQuery.sizeOf(context)
                                                      .width /
                                                  4.5,
                                              child: CommonElevatedButton2(
                                                  context, "No", () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      RescheduleConfirmationPop(
                                                          context,
                                                          typeT: 'reject',
                                                          onPress: () {
                                                    ScheduleRejectedResponse();
                                                  },
                                                          scheduleT: TagActive ==
                                                                  "Schedule Requested"
                                                              ? 'Scheduled'
                                                              : 'Rescheduled'),
                                                );
                                              })),
                                        ],
                                      )
                                    : Container(),
                          )
                        : Container(),
                    TagActive == "Candidate Rescheduled"
                        ? Column(
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                "Reschedule Pending for Approval",
                                style: attachT1,
                              ),
                              Text(
                                "${jobDetailsData?.candidateReschedule?.interviewTime == [] ? SingleTon().setTime : jobDetailsData?.candidateReschedule?.interviewTime ?? ""}, "
                                "${jobDetailsData?.candidateReschedule?.interviewDate == [] ? dateController.text : jobDetailsData?.candidateReschedule?.interviewDate ?? ""}",
                                style: TBlack,
                              ),
                            ],
                          )
                        : TagActive == "Recruiter Rescheduled"
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                      TagActive == "Candidate Rescheduled"
                                          ? "Reschedule Pending for Approval"
                                          : "Recruiter not okay with",
                                      style: TagActive == "Candidate Reschedule"
                                          ? attachT1
                                          : attacht1),
                                  Text(
                                      TagActive == "Candidate Rescheduled"
                                          ? " 9.00 AM, 12 Oct 2023"
                                          : "${jobDetailsData?.candidateReschedule?.interviewTime ?? ""}, ${jobDetailsData?.candidateReschedule?.interviewDate ?? ""}",
                                      style:
                                          TagActive == "Candidate Rescheduled"
                                              ? TBlack
                                              : Homewhite),


                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 10, bottom: 15),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  //     children: [
                                  //       Container(
                                  //           height: 50,
                                  //           width: 105,
                                  //           child: CommonElevatedButton2(context, "Yes", () {
                                  //             showDialog(
                                  //               context: context,
                                  //               builder: (BuildContext context) =>
                                  //                   RescheduleConfirmationPop(context,
                                  //                       typeT: 'accept', onPress: () {
                                  //                         ScheduleAcceptedResponse();
                                  //                       },
                                  //                       scheduleT: 'Rescheduled'),
                                  //             );
                                  //           })),
                                  //       SizedBox(
                                  //         width: 20,
                                  //       ),
                                  //       Container(
                                  //           height: 50,
                                  //           width: 105,
                                  //           child: CommonElevatedButton2(context, "No", () {
                                  //             showDialog(
                                  //               context: context,
                                  //               builder: (BuildContext context) =>
                                  //                   RescheduleConfirmationPop(context,
                                  //                       typeT: 'reject', onPress: () {
                                  //                         ScheduleRejectedResponse();
                                  //                       },
                                  //                       scheduleT: 'Rescheduled'),
                                  //             );
                                  //           })),
                                  //     ],
                                  //   ),
                                  // ),

                                ],
                              )
                            : Container(),
                    TagActive == "Recruiter Rescheduled"
                        ? _Recruiter_Reschedule_Buttons("Recruiter Rescheduled")
                        : TagActive == "Interview Rescheduled"
                            ? _Recruiter_Reschedule_Buttons(
                                "Interview Rescheduled")
                            : Container(),
                    TagActive == "Selected"
                        ? _OfferLetterSection()
                        : Container(),
                  ],
                )
                // :Container()
              ],
            ),
          );
  }

  //RECRUITER RESCHEDULE BUTTON ROWS
  Widget _Recruiter_Reschedule_Buttons(String? tagActive) {
    return Column(
      children: [
        tagActive == "Interview Rescheduled"
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Recruiter Rescheduled to",
                  style: attachT1,
                ),
              ),
        tagActive == "Interview Rescheduled"
            ? Container()
            : Text(
                "${jobDetailsData?.recruiterReschedule?.interviewTime ?? ""}, ${jobDetailsData?.recruiterReschedule?.interviewDate ?? ""}",
                style: TBlack,
              ),
        isClicked == true
            ? Container(
                margin: EdgeInsets.only(bottom: 10),
              )
            :
        Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 50,
                        width: 105,
                        child: CommonElevatedButton2(context, "Yes", () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                RescheduleConfirmationPop(context,
                                    typeT: 'accept', onPress: () {
                              ScheduleAcceptedResponse();
                            },
                                    scheduleT: tagActive == "Schedule Requested"
                                        ? 'Scheduled'
                                        : 'Rescheduled'),
                          );
                        })),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        height: 50,
                        width: 105,
                        child: CommonElevatedButton2(context, "No", () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                RescheduleConfirmationPop(context,
                                    typeT: 'reject', onPress: () {
                              ScheduleRejectedResponse();
                            },
                                    scheduleT: tagActive == "Schedule Requested"
                                        ? 'Scheduled'
                                        : 'Rescheduled'),
                          );
                        })),
                  ],
                ),
              ),
      ],
    );
  }

  //ACCEPTED BY CANDIDATE
  Widget _AcceptedRejectedByCandidate() {
    return isClicked == true
        ? Column(
            children: [
              Container(
                height: 50,
                color: isYes == true ? green2 : white1,
                child: Center(
                  child: Text(
                    isYes == true ? "Scheduled" : "You Rejected",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isYes == true ? green1 : grey4,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 25,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        isYes == true
                            ? "You Accepted the interview on"
                            : "You Rejected the Interview on",
                        style: attachT1,
                      ),
                      Text(
                        "${jobDetailsData?.recruiterReschedule?.interviewTime == null ? jobDetailsData?.scheduleRequested?.interviewTime ?? "" : jobDetailsData?.recruiterReschedule?.interviewTime ?? ""}, "
                        "${jobDetailsData?.recruiterReschedule?.interviewDate == null ? jobDetailsData?.scheduleRequested?.interviewDate ?? "" : jobDetailsData?.recruiterReschedule?.interviewDate ?? ""}",
                        style: TBlack,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  //RESCHEDULE REQUESTED TAG
  Widget RescheduleRequestedTag() {
    return isRescheduled == true
        ? Column(
            children: [
              Container(
                height: 50,
                color: orange3,
                child: Center(
                  child: Text(
                    "Reschedule Requested",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: orange2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 25,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        "You requested to reschedule the interview on",
                        style: attachT1,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${SingleTon().setTime}, ${dateController.text}",
                        style: TBlack,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget _ScanDetail(context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: AppliedButton(context, "Click to Scan", onPress: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QRCodeScannerApp(
                              JobId: widget.jobId ?? "",
                              CampusId: '',
                              ReruiterId: jobDetailsData?.recruiterId ?? "",
                              screenType: 'direct',
                            ))).then((onValue) {
                  if (onValue == true) {
                    setApplyJob();
                  }
                });
              });
            }, backgroundColor: blue1)),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Text(
            "OR",
            style: dateT,
          ),
        ),
        _writeMessage(),
        Text(
          "When You Reach Interview Location",
          style: companyT,
        ),
      ],
    );
  }

  Widget _writeMessage() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Chat_Field(
        context,
        hintText: 'Enter Code',
        keyboardtype: TextInputType.text,
        inputFormatters: null,
        Controller: _EnterCode,
        validating: null,
        onChanged: null,
        onTap: () {
          DirectEnrolledResponse();
        },
      ),
    );
  }

  //OFFER LETTER SECTION
  Widget _OfferLetterSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: white1),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 15),
                  child: ImgPathSvg("pdf.svg"),
                ),
                Text(
                  "Offer Letter.pdf",
                  style: TBlack,
                ),
              ],
            ),
          ),
          isFeedBack == true
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Text("Feedback about company", style: TBlack),
                ),
          isFeedBack == true
              ? Container()
              : textfieldDescription3(
                  Controller: _FeedBack,
                  validating: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Feedback";
                    }
                    if (value == null) {
                      return "Please Enter Feedback";
                    }
                    return null;
                  },
                ),
          isFeedBack == true
              ? Container()
              : Center(
                  child: Padding(
                  padding: const EdgeInsets.only(top: 23, bottom: 23),
                  child: Container(
                      width: 200,
                      height: 44,
                      child: CommonElevatedButton(context, "Submit", () {
                        OfferFeedBackResponse();
                      })),
                )),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  //DOWNLOAD POPUP
  Widget _DownloadPopUp(BuildContext context) {
    return AlertDialog(
      backgroundColor: white1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      titlePadding: EdgeInsets.all(0),
      title: Container(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: ImgPathSvg("xcancel.svg"))),
      contentPadding: EdgeInsets.only(right: 20, left: 20, bottom: 0),
      content: Container(
        height: 150,
        width: 350,
        child: Column(
          children: [
            Text(
              "Click to download the ",
              style: walletT,
            ),
            Text(
              "Job Summary",
              style: profileTitle,
            ),
            const SizedBox(
              height: 15,
            ),
            CommonElevatedButton(context, "Download", () {})
          ],
        ),
      ),
    );
  }

  // RESCHEDULE DATE POPUP
  Widget RescheduleDatePop(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content: Container(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //DATE PICKER
            Text(
              "Please select the reschedule date & time for the Interview",
              style: Wbalck6,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              readOnly: true,
              keyboardType: TextInputType.number,
              maxLength: 15,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: white2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: white2),
                ),
                counterText: "",
                hintText: 'DD / MM / YYYY',
                helperStyle: phoneHT,
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                  size: 35,
                ),
                prefixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: grey4,
                  size: 24,
                ),
                hintStyle: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
                errorMaxLines: 1,
                contentPadding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                fillColor: white2,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: Colors.black,
              ),
              controller: dateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Date Entered";
                }
                return null;
              },
              onTap: () => _selectDate(context),
            ),
            //TIME PICKER
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TimePickerFormField(onValidate: (value) {
                _selectedTime = value;
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Cancel", () {
                        Navigator.pop(context);
                      })),
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Okay", () {
                        print("TIME ${_selectedTime}");
                        print("DATE CONTROLLER ${dateController.text}");
                        if (_selectedTime == null ||
                            dateController.text.isEmpty) {
                          ShowToastMessage(
                              "Please Enter Interview Date & Time");
                        } else {
                          print('Please Enter Interview Date');
                          _validateTime();
                          RescheduleRequestedResponse();
                        }
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //SCHEDULE ACCEPTED
  ScheduleAcceptedResponse() async {
    final scheduleAcceptedApiService = ApiService(ref.refresh(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.jobId,
      "candidate_id": await getcandidateId(),
      "recruiter_id": jobDetailsData?.recruiterId ?? "",
      "status": 5
    });
    final scheduleAcceptedApiResponse =
        await scheduleAcceptedApiService.post<CandidateUpdateModel>(
            context, ConstantApi.candidateUpdateInterviewUrl, formData);
    if (scheduleAcceptedApiResponse?.status == true) {
      print("SCHEDULE ACCEPTED SUCESS");
      setState(() {
        isStatus = false;
        isYes = true;
        isClicked = true;
        _AcceptedRejectedByCandidate();
      });
      Navigator.pop(context);
    } else {
      print("SCHEDULE ACCEPTED ERROR");
    }
  }

  //SCHEDULE REJECTED
  ScheduleRejectedResponse() async {
    final scheduleAcceptedApiService = ApiService(ref.refresh(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.jobId,
      "candidate_id": await getcandidateId(),
      "recruiter_id": jobDetailsData?.recruiterId ?? "",
      "status": 7
    });
    final scheduleAcceptedApiResponse =
        await scheduleAcceptedApiService.post<CandidateUpdateModel>(
            context, ConstantApi.candidateUpdateInterviewUrl, formData);
    if (scheduleAcceptedApiResponse?.status == true) {
      print("SCHEDULE REJECTED SUCCESS");
      setState(() {
        isStatus = false;
        isYes = false;
        isClicked = true;
        _AcceptedRejectedByCandidate();
      });
      Navigator.pop(context);
    } else {
      print("SCHEDULE REJECTED ERROR");
    }
  }

  //RESCHEDULE REQUESTED
  RescheduleRequestedResponse() async {
    final scheduleAcceptedApiService = ApiService(ref.refresh(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.jobId,
      "candidate_id": await getcandidateId(),
      "recruiter_id": jobDetailsData?.recruiterId ?? "",
      "interview_date": dateController.text,
      "interview_time": SingleTon().setTime,
      "status": 6,
      "reschedule_by": "candidate",
    });
    final scheduleAcceptedApiResponse =
        await scheduleAcceptedApiService.post<CandidateUpdateModel>(
            context, ConstantApi.rescheduleInterview, formData);
    if (scheduleAcceptedApiResponse?.status == true) {
      ShowToastMessage(scheduleAcceptedApiResponse?.message ?? "");
      print("RESCHEDULE SUCCESS");
      setState(() {
        isRescheduled = true;
      });
      Navigator.pop(context);
    } else {
      print("RESCHEDULE ERROR");
      ShowToastMessage(scheduleAcceptedApiResponse?.message ?? "");
    }
  }

  //OFFERFEEDBACK
  OfferFeedBackResponse() async {
    final offerFeedBackApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "job_id": widget.jobId,
      "feedback": _FeedBack.text,
    });
    final offerFeedBackApiResponse = await offerFeedBackApiService
        .post<JobFeedBackModel>(context, ConstantApi.jobFeedBackUrl, formData);
    if (offerFeedBackApiResponse?.status == true) {
      print("FEED BACK SUCCESS");
      setState(() {
        isFeedBack = true;
      });
      ShowToastMessage(offerFeedBackApiResponse?.message ?? "");
    } else {
      print("FEED BACK ERROR");
      ShowToastMessage(offerFeedBackApiResponse?.message ?? "");
    }
  }

  //DIRECT ENROLLED RESPONSE
  DirectEnrolledResponse() async {
    final directEnrolledApiService = ApiService(ref.read(dioProvider));

    var formData = FormData.fromMap({
      "job_id": widget.jobId,
      "candidate_id": await getcandidateId(),
      "recruiter_id": jobDetailsData?.recruiterId ?? "",
      "qr_code": _EnterCode.text
    });
    final directEnrolledResponse =
        await directEnrolledApiService.post<CampusEnrolledJobModel>(
            context, ConstantApi.directEnrolledJobUrl, formData);
    if (directEnrolledResponse?.status == true) {
      print("ENROLLED SUCCESS");
      setState(() {
        widget.TagActive == "Wait List";
      });
      ShowToastMessage(directEnrolledResponse?.message ?? "");
    } else {
      print("ENROLLED ERROR");
      ShowToastMessage(directEnrolledResponse?.message ?? "");
    }
  }
}

//RESCHEDULE CONFIRMATION POP UP
Widget RescheduleConfirmationPop(BuildContext context,
    {required String typeT,
    required String scheduleT,
    required void Function()? onPress}) {
  return AlertDialog(
    surfaceTintColor: white1,
    content: Container(
      //color: white1,
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Are you sure want to ${typeT} the ${scheduleT} date and time',
            style: Wbalck2,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 3.8,
                  child: PopButton(context, "Cancel", () {
                    Navigator.pop(context);
                  })),
              Container(
                  width: MediaQuery.of(context).size.width / 3.6,
                  child: PopButton(context, "Confirm", onPress)),
            ],
          ),
        ],
      ),
    ),
  );
}
