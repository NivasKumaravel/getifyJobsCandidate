import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getifyjobs/Models/ApplyCampusJobModel.dart';
import 'package:getifyjobs/Models/CampusEnrolledJobModel.dart';
import 'package:getifyjobs/Models/CampusJobDetailsModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Campus_JobDetail_Screen extends ConsumerStatefulWidget {
  String JobId;
  String CampusId;
  String ReruiterId;
  bool? isApplied;
  String? TagType;
  String? CampusTagType;
  String? interviewDate;
  String? interviewTime;
  Campus_JobDetail_Screen(
      {super.key,
      required this.JobId,
      required this.CampusId,
      required this.ReruiterId,
      required this.isApplied,
      required this.TagType,
        required this.CampusTagType,
      required this.interviewDate,
      required this.interviewTime});
  @override
  _Campus_JobDetail_ScreenState createState() =>
      _Campus_JobDetail_ScreenState();
}

class _Campus_JobDetail_ScreenState
    extends ConsumerState<Campus_JobDetail_Screen> {
  CampusJobDetailsData? CampusJobDetailsResponseData;
  bool? isScanned;
  bool isBookMark = false;
  
  TextEditingController _EnterCode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CampusJobDetailsResponse();
    });

    // widget.isApplied = true;
    isScanned = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: null,
        isLogoUsed: true,
        isTitleUsed: true,
        title: '',
      ),
      bottomNavigationBar: BottomBar(context,
          ButtonTitle: widget.isApplied == true ? "Apply Job" : "Applied",
          backgroundColor: widget.isApplied == true ? blue1 : green1,
          bookmark: false, onPress:widget.isApplied == true ? () {
            ApplyCampusJobResponse();
      }:(){}, shareBtnPress: () {}, onTap: () {
        
          }, isSavedUsed: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.TagType == "Applied"
                ? Column(
                    children: [
                      isScanned == true ? _ScanDetail(context) : Container(),
                    ],
                  )
                : widget.TagType == "Selected"
                    ? _TagRound(TagType: widget.TagType ?? "")
                    : widget.TagType == "Call For Interview"
                        ? _TagRound(TagType: widget.TagType ?? "")
                        : widget.TagType == "Rejected"
                            ? _TagRound(TagType: widget.TagType ?? "")
                            :widget.TagType == "Enrolled"?
                                _TagRound(TagType: widget.TagType ?? ""):
                                widget.TagType == ""
                                ? Container()
                                : _TagRound(TagType: widget.TagType ?? ""),
            //COLLEGE CARD
            CampusList(
              context,
              isTag: "",
              iscampTag: widget.CampusTagType ?? "",
              isUsed: false,
              onTap: () {},
              jobName: '',
              companyLogo: '',
              companyName: '',
              collegeName: CampusJobDetailsResponseData?.college?.name ?? "",
              collegeLogo: CampusJobDetailsResponseData?.college?.logo ?? "",
              companyLocation: '',
              collegeLocation:
                  CampusJobDetailsResponseData?.college?.location ?? "", applyCount: '', isCountNeeded: false,
            ),

            //DATE AND TIME
            dateTime(
                time:
                    'Date: 09:00AM, ${CampusJobDetailsResponseData?.college?.recruitmentDate ?? ""}'),

            //JOB DETAILS
            _Common_job_Deatil_Section(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _ScanDetail(context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 90, right: 90, top: 10),
            child: AppliedButton(context, "Click to Scan", onPress: () {
              setState(() {
                isScanned = false;
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRCodeScannerApp(JobId: widget.JobId, CampusId: widget.CampusId, ReruiterId: widget.ReruiterId,)));

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
          "When You Reached Campus ",
          style: companyT,
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white1,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Interview Location",
                      style: interviewLocationT,
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: buildCompanyInfoRow(
                      "map-pin (1).png",
                      CampusJobDetailsResponseData?.location ?? "",
                      Homegrey2,
                      20,
                      20,
                      isMapLogo: true),
                )
              ],
            ),
          ),
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
          EnrolledResponse();
        },
      ),
    );
  }

  Widget _TagRound({required String TagType}) {
    return Column(
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          color: TagType == "Applied"
              ? blue2
              : TagType == "Rejected"
                  ? red4
                  : TagType == "Selected"
                      ? green3
                      : TagType == "Final Round"
                          ? green3
                          : TagType == "Call For Interview"
                              ? yellow2
                              : TagType == "Enrolled"
                                  ? yellow2
                                  : green3,
          child: Center(
              child: Text(
            TagType == "Applied"
                ? "Applied"
                : TagType == "Rejected"
                    ? "Rejected"
                    : TagType == "Final Round"
                        ? "Shortlisted for Final Round"
                        : TagType == "Selected"
                            ? "Selected"
                            : TagType == "Enrolled"
                                ? "Enrolled"
                                : TagType == "Call For Interview"
                                    ? "Call For Interview"
                                    : "Shortlisted for Round ${TagType}",
            style: TextStyle(
                fontFamily: "Inter",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: TagType == "Selected"
                    ? green1
                    : TagType == "Final Round"
                        ? green1
                        : TagType == "Call For Interview"
                            ? yellow1
                            : TagType == "Enrolled"
                                ? yellow1
                                : TagType == "Rejected"
                                    ? red1
                                    : TagType == "Applied"
                                        ? blue1
                                        : green1),
          )),
        ),
        TagType == "Call For Interview"
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Are you okay with the date & time?",
                      style: attachT1,
                    ),
                    Text(
                      "${widget.interviewTime}, ${widget.interviewDate}",
                      style: TBlack,
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  CampusJobDetailsResponse() async {
    final campusJobDetailsApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({"job_id": widget.JobId});
    final campusResponseJobDetails =
        await campusJobDetailsApiService.post<CampusJobDetailsModel>(
            context, ConstantApi.campusJobDetailsUrl, formData);
    if (campusResponseJobDetails.status == true) {
      setState(() {
        CampusJobDetailsResponseData = campusResponseJobDetails?.data;
        print("RESPONSE : ${campusResponseJobDetails?.data}");
      });
    } else {
      ShowToastMessage(campusResponseJobDetails?.message ?? "");
      print('ERROR');
    }
  }

  ApplyCampusJobResponse() async {
    final ApplyCampusJobApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.JobId,
      "candidate_id": await getcandidateId(),
      "recruiter_id": widget.ReruiterId,
      "campus_id": widget.CampusId
    });
    final applyCampusJob =
        await ApplyCampusJobApiService.post<ApplyCampusJobModel>(
            context, ConstantApi.applyCampusJobUrl, formData);
    if (applyCampusJob.status == true) {
      ShowToastMessage(applyCampusJob?.message ?? "");
      setState(() {
        widget.isApplied == false;
      });
      print('SUCESS');
    } else {
      ShowToastMessage(applyCampusJob?.message ?? "");
      print('ERROR');
    }
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
                CampusJobDetailsResponseData?.jobTitle ?? "",
                style: TitleT,
              ),
              //COMPANY LOGO AND NAME
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildCompanyInfoRow(
                    CampusJobDetailsResponseData?.logo ?? "",
                    CampusJobDetailsResponseData?.companyName ?? "",
                    TBlack,
                    50,
                    50,
                    isMapLogo: false),
              ),
              //POSTED DATE
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Text(
                  "Posted on:" +
                      "${CampusJobDetailsResponseData?.createdDate ?? ""}",
                  style: posttxt,
                ),
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
              style: TitleT,
            ),
            Text(
              CampusJobDetailsResponseData?.jobDescription ?? "",
              style: desctxt,
            ),
            SizedBox(
              height: 20,
            ),
            textWithheader(
                headertxt: "No Of Vacancies",
                subtxt: CampusJobDetailsResponseData?.vacancies ?? ""),
            textWithheader(
                headertxt: "Qualification",
                subtxt: CampusJobDetailsResponseData?.qualification ?? ""),
            textWithheader(
                headertxt: "Specialization",
                subtxt: CampusJobDetailsResponseData?.specialization ?? ""),
            CampusJobDetailsResponseData?.currentArrears == ''
                ? Container()
                : textWithheader(
                    headertxt: "Current Arrears",
                    subtxt: CampusJobDetailsResponseData?.currentArrears ?? ""),
            CampusJobDetailsResponseData?.historyOfArrears == ''
                ? Container()
                : textWithheader(
                    headertxt: "History Of Arrears",
                    subtxt:
                        CampusJobDetailsResponseData?.historyOfArrears ?? ""),
            CampusJobDetailsResponseData?.requiredPercentage == ''
                ? Container()
                : textWithheader(
                    headertxt: "Required Percentage/CGPA",
                    subtxt:
                        CampusJobDetailsResponseData?.requiredPercentage ?? ""),
            textWithheader(
                headertxt: "Number Of Rounds",
                subtxt: CampusJobDetailsResponseData?.rounds ?? ""),
            CampusJobDetailsResponseData?.statutoryBenefits == ''
                ? Container()
                : textWithheader(
                    headertxt: "Statutory Benefit",
                    subtxt:
                        CampusJobDetailsResponseData?.statutoryBenefits ?? ""),
            CampusJobDetailsResponseData?.socialBenefits == ''
                ? Container()
                : textWithheader(
                    headertxt: "Social Benefits",
                    subtxt: CampusJobDetailsResponseData?.socialBenefits ?? ""),
            CampusJobDetailsResponseData?.otherBenefits == ''
                ? Container()
                : textWithheader(
                    headertxt: "Other Benefits",
                    subtxt: CampusJobDetailsResponseData?.otherBenefits ?? ""),
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
        //LOCATION
        _IconWithText(
            iconimg: "map-pin.svg",
            icontext: CampusJobDetailsResponseData?.location ?? ""),
        //SALARY
        CampusJobDetailsResponseData?.salaryFrom == null
            ? Container()
            : _IconWithText(
                iconimg: "wallet.svg",
                icontext:
                    "₹ ${CampusJobDetailsResponseData?.salaryFrom ?? ""} - ${CampusJobDetailsResponseData?.salaryTo ?? ""} LPA")
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
      height: 95,
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
            Text(
              CampusJobDetailsResponseData?.recruiter ?? "",
              style: stxt,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  //ENROLLED RESPONSE
  EnrolledResponse() async {
    final enrolledApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.JobId,
      "candidate_id": await getcandidateId(),
      "recruiter_id": widget.ReruiterId,
      "campus_id": widget.CampusId,
      "qr_code": _EnterCode.text
    });
    final enrolledApiResponse =
        await enrolledApiService.post<CampusEnrolledJobModel>(
            context, ConstantApi.campusEnrolledJobUrl, formData);
    if (enrolledApiResponse?.status == true) {
      print("ENROLLED SUCCESS");
      setState(() {
        widget.TagType = "Enrolled";
      });
      ShowToastMessage(enrolledApiResponse?.message ?? "");
    } else {
      print("ENROLLED ERROR");
      ShowToastMessage(enrolledApiResponse?.message ?? "");
    }
  }
}

class QRCodeScannerApp extends ConsumerStatefulWidget {
  String JobId;
  String CampusId;
  String ReruiterId;

  QRCodeScannerApp(
      {super.key,
        required this.JobId,
        required this.CampusId,
        required this.ReruiterId,
      });
  @override
  _QRCodeScannerAppState createState() => _QRCodeScannerAppState();
}

class _QRCodeScannerAppState extends ConsumerState<QRCodeScannerApp> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: null,
        isLogoUsed: true,
        isTitleUsed: true,
        title: 'QR Code Scanner',
      ),
      body: Center(
        child: _buildScannerView(),
      ),
    );
  }

  Widget _buildScannerView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: blue1, // Customize the overlay color
                borderRadius: 10, // Customize the border radius
                borderLength: 20, // Customize the border length
                borderWidth: 5, // Customize the border width
                cutOutSize: 200,
              ),
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),

            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Scan the QR Code',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
      ],
    );
  }


  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {

      EnrolledResponse(ScanCode:  scanData.code ?? "");

      // Handle the scanned data here (scanData).
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  //ENROLLED RESPONSE
  EnrolledResponse({required String ScanCode}) async {
    final enrolledApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.JobId,
      "candidate_id": await getcandidateId(),
      "recruiter_id": widget.ReruiterId,
      "campus_id": widget.CampusId,
      "qr_code": ScanCode,
    });
    final enrolledApiResponse =
    await enrolledApiService.post<CampusEnrolledJobModel>(
        context, ConstantApi.campusEnrolledJobUrl, formData);
    if (enrolledApiResponse?.status == true) {
      print("ENROLLED SUCCESS");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Bottom_Navigation(select: 1)), (route) => false);
      ShowToastMessage(enrolledApiResponse?.message ?? "");
    } else {
      print("ENROLLED ERROR");
      ShowToastMessage(enrolledApiResponse?.message ?? "");
    }
  }
}
