import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CandidateProfileModel.dart';
import 'package:getifyjobs/Models/OtpModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_PopUp_Widgets.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

import '../../../Common_Widgets/Text_Form_Field.dart';
import '../../../utilits/ApiService.dart';
import 'Employeement_History_Screen.dart';

class Profile_Detail_Screen extends ConsumerStatefulWidget {
  canidateProfileData? CandidateProfileResponseData;
  final String? careerStatus;

  Profile_Detail_Screen(
      {super.key, required this.CandidateProfileResponseData,required this.careerStatus,});

  @override
  _Profile_Detail_ScreenState createState() => _Profile_Detail_ScreenState();
}

class _Profile_Detail_ScreenState extends ConsumerState<Profile_Detail_Screen> {
  canidateProfileData? CandidateProfileResponseData;
  List<EmpDetail> experienceDetails = [];
  List<EducationDetail> eduHistory = [];

  List<TextEditingController> textFormFields = [];
  bool isClicked = true;
  int? martialVal;
  int? DifferentlyAbledVal;
  int? passportVal;
  int? careerBreakVal;
  int? typeVal;

  TextEditingController _Dob = TextEditingController();
  TextEditingController _Nationality = TextEditingController();

  RegExp onlyText = RegExp(r'^[a-zA-Z ]+$');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('CAREER STATUS ${widget.careerStatus}');
    CandidateProfileResponseData = widget.CandidateProfileResponseData;

    _Dob.text = CandidateProfileResponseData?.dob ?? "";
    _Nationality.text = CandidateProfileResponseData?.nationality ?? "";
    martialVal =
        (CandidateProfileResponseData?.maritalStatus ?? "") == "Single" ? 0 : 1;
    passportVal = (CandidateProfileResponseData?.passport ?? "") == "Yes"
        ? 0
        : (CandidateProfileResponseData?.passport ?? "") == "No"
            ? 1
            : null;
    DifferentlyAbledVal =
        (CandidateProfileResponseData?.differentlyAbled ?? "") == "Yes"
            ? 0
            : (CandidateProfileResponseData?.differentlyAbled ?? "") == "No"
                ? 1
                : null;
    careerBreakVal = (CandidateProfileResponseData?.careerBreak ?? "") == "Yes"
        ? 0
        : (CandidateProfileResponseData?.careerBreak ?? "") == "No"
            ? 1
            : null;
    var languageArr = (CandidateProfileResponseData?.languageKnown ?? "")
        .split(', ')
        .map((e) => e)
        .toList();

    for (Employment obj in CandidateProfileResponseData?.employment ?? []) {
      var empValue = EmpDetail(
          obj.jobRole ?? "",
          obj.companyName ?? "",
          obj.startDate ?? "",
          obj.endDate ?? "",
          obj.noticePeriod ?? "",
          obj.jobType ?? "",
          obj.description ?? "",
          2);

      experienceDetails.add(empValue);
    }

    for (Education obj in CandidateProfileResponseData?.education ?? []) {
      var eduValue = EducationDetail(
          obj.institute ?? "",
          '',
          '',
          '',
          [],
          '',
          obj.educationType ?? "",
          obj.cgpa ?? "",
          obj.startDate ?? "",
          obj.endDate ?? "");

      eduHistory.add(eduValue);
    }

    for (var value in languageArr) {
      textFormFields.add(TextEditingController(text: value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: AppBar(
          automaticallyImplyLeading: false,
        backgroundColor: white2,
        // leading: IconButton(
        //   icon:  ImgPathSvg("arrowback.svg"),
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext context) => Profile_Back_Pop_Up(context,
        //           BackonPress: () {
        //         widget.careerStatus == "Student"?
        //           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Bottom_Navigation(select: 3)), (route) => false):
        //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Candidate_Bottom_Navigation(select: 3)), (route) => false);
        //           },
        //           SaveonPress: () {
        //             Add_Profile_Detail_Api();
        //           }),
        //     );
        //     },
        // ),
        title: Text("Profile Detail",style: LoginT,),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Profile_Save_Pop_Up(context,
                      SaveonPress: () {
                        Add_Profile_Detail_Api();
                      }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  "Save",
                  style: saveT,
                ),
              )),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            _PersonalDetails(),
            widget.careerStatus == "Student"
                ? Container()
                : _EmployeementHistory(),
            widget.careerStatus== "Student"
                ? Container()
                : InkWell(
                    onTap: () async {
                      final newDetail = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Employeement_History_Page(
                                  initialDetail:
                                      EmpDetail('', '', '', '', '', '', '', 2),
                                  isType: true,
                                  educationHistory: EducationDetail(
                                      '', '', '', '', [], '', '', '', '', ''),
                                  isEdit: false,
                                )),
                      );

                      if (newDetail != null) {
                        setState(() {
                          experienceDetails.add(newDetail);
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text(
                        "+ Add Employeement History",
                        style: addLanguageT,
                      ),
                    )),
            const SizedBox(
              height: 15,
            ),
            _EducationHistory(),
            InkWell(
                onTap: () async {
                  final newEducationDetail = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Employeement_History_Page(
                              initialDetail:
                                  EmpDetail('', '', '', '', '', '', '', 2),
                              isType: false,
                              educationHistory: EducationDetail(
                                  '', '', '', '', [], '', '', '', '', ''),
                              isEdit: false,
                            )),
                  );

                  if (newEducationDetail != null) {
                    setState(() {
                      eduHistory.add(newEducationDetail);
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    "+ Add Education Details",
                    style: addLanguageT,
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  CandidateProfileResponse() async {
    final candidateProfileApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({"candidate_id": await getcandidateId()});
    final profileResponseJobDetails =
        await candidateProfileApiService.post<CandidateProfileModel>(
            context, ConstantApi.candidateProfileUrl, formData);
    if (profileResponseJobDetails.status == true) {
      setState(() {
        CandidateProfileResponseData = profileResponseJobDetails.data;
        print("RESPONSE : ${profileResponseJobDetails.data}");

        _Dob.text = CandidateProfileResponseData?.dob ?? "";
        _Nationality.text = CandidateProfileResponseData?.nationality ?? "";
        martialVal =
            (CandidateProfileResponseData?.maritalStatus ?? "") == "single"
                ? 0
                : 1;
        passportVal =
            (CandidateProfileResponseData?.passport ?? "") == "yes" ? 0 : 1;
        DifferentlyAbledVal =
            (CandidateProfileResponseData?.differentlyAbled ?? "") == "yes"
                ? 0
                : 1;
        careerBreakVal =
            (CandidateProfileResponseData?.careerBreak ?? "") == "yes" ? 0 : 1;
      });
    } else {
      ShowToastMessage(profileResponseJobDetails.message ?? "");
      print('ERROR');
    }
  }

  //SAVE PROFILE DETAIL API
  Add_Profile_Detail_Api() async{
    final profileEditApiService = ApiService(ref.read(dioProvider));

    var formData = FormData.fromMap({
      "name": CandidateProfileResponseData?.name ?? "",
      "email": CandidateProfileResponseData?.email ?? "",
      "phone": CandidateProfileResponseData?.phone ?? "",
      "address": CandidateProfileResponseData?.address ?? "",
      "gender": CandidateProfileResponseData?.gender ?? "",
      "specialization":
      CandidateProfileResponseData?.specialization ?? "",
      "qualification":
      CandidateProfileResponseData?.qualification ?? "",
      "preferred_location":
      CandidateProfileResponseData?.preferredLocation ?? "",
      "expected_salary":
      CandidateProfileResponseData?.expectedSalary ?? "",
      "current_salary":
      CandidateProfileResponseData?.currentSalary ?? "",
      "location": CandidateProfileResponseData?.location ?? "",
      "skill_set": CandidateProfileResponseData?.skillSet ?? "",
      "marital_status": martialVal == 0 ? "single" : "married",
      "dob": _Dob.text,
      "nationality": _Nationality.text,
      "differently_abled": DifferentlyAbledVal == 0 ? "Yes" : "No",
      "passport": passportVal == 0 ? "Yes" : "No",
      "language_known":
      textFormFields.map((e) => e.text).join(", "),
      "career_break": careerBreakVal == 0 ? "Yes" : "No",
      "candidate_id": await getcandidateId(),
    });

    print('PROFILE DETAIL ${formData}');

    for (int i = 0; i < eduHistory.length; i++) {
      formData.fields.add(MapEntry(
          'education[$i][institute]', eduHistory[i].university_id));
      formData.fields.add(MapEntry('education[$i][qualification]',
          eduHistory[i].qualification_id));
      formData.fields.add(MapEntry('education[$i][specialization]',
          eduHistory[i].specilization_id));
      formData.fields.add(MapEntry('education[$i][education_type]',
          eduHistory[i].educationType));
      formData.fields
          .add(MapEntry('education[$i][cgpa]', eduHistory[i].cgpa));
      formData.fields.add(MapEntry(
          'education[$i][start_date]', eduHistory[i].startYear));
      formData.fields.add(MapEntry(
          'education[$i][end_date]', eduHistory[i].endYear));
    }
    for (int i = 0; i < experienceDetails.length; i++) {
      formData.fields.add(MapEntry('employment[$i][job_role]',
          experienceDetails[i].JobRole));
      formData.fields.add(MapEntry('employment[$i][company_name]',
          experienceDetails[i].CompanyName));
      formData.fields.add(MapEntry('employment[$i][job_type]',
          experienceDetails[i].EmployementType));
      formData.fields.add(MapEntry('employment[$i][start_date]',
          experienceDetails[i].StartDate));
      formData.fields.add(MapEntry('employment[$i][end_date]',
          experienceDetails[i].EndDate));
      formData.fields.add(MapEntry('employment[$i][notice_period]',
          experienceDetails[i].NoticePeriod));
      formData.fields.add(MapEntry('employment[$i][description]',
          experienceDetails[i].Description));
    }

    final profileEditResponse =
    await profileEditApiService.post<OtpModel>(
        context, ConstantApi.candidateEditProfileUrl, formData);

    if (profileEditResponse.status == true) {
      Navigator.pop(context, 'true');
    } else {
      ShowToastMessage(profileEditResponse.message ?? "");
      print('ERROR');
    }
  }

  //PERSONAL DETAILS
  Widget _PersonalDetails() {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(25), color: white1),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [

            //NATIONALITY
            Title_Style(Title: 'Nationality', isStatus: false),
            textFormField(
              hintText: 'Nationality',
              keyboardtype: TextInputType.text,
              inputFormatters: null,
              Controller: _Nationality,
              validating: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Valid ${'Nationality'}";
                } else if (!onlyText.hasMatch(value)) {
                  return "(Special Characters are Not Allowed)";
                }
                return null;
              },
              onChanged: null,
            ),

            //LANGUAGES KNOWN
            Title_Style(Title: 'Languages Known', isStatus: false),
            ListView.builder(
              itemCount: textFormFields.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _languageKnown(textFormFields[index]);
              },
            ),

            InkWell(
                onTap: () {
                  setState(() {
                    textFormFields.add(TextEditingController());
                  });

                  for (var values in textFormFields) {
                    print(values.text);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    "+ Add Language",
                    style: addLanguageT,
                  ),
                )),

            // //MARTIAL STATUS
            // Title_Style(Title: 'Marital Status', isStatus: false),
            // _martialStatus(),

            //Differently Abled
            Title_Style(Title: 'Differently Abled', isStatus: false),
            _differentlyAbled(),

            //Do you have passport
            Title_Style(Title: 'Do you have a passport ?', isStatus: false),
            _passport(),

            //Career Break
            Title_Style(Title: 'Career Break', isStatus: false),
            _careerBreak(),
          ],
        ),
      ),
    );
  }

  //EMPLOYEEMENT HISTORY
  Widget _EmployeementHistory() {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 20, right: 20, top: 20),
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: white1),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileTitle(title: 'Employment History'),
            experienceDetails.length == 0
                ? Center(
                    child: Container(
                        width: MediaQuery.sizeOf(context).width / 1.5,
                        child: Text(
                          "No Employment History Detail Available",
                          style: Wgrey1,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        )),
                  )
                : Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: experienceDetails.length,
                      itemBuilder: (context, index) {
                        var detail = experienceDetails[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: white1,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          detail.JobRole,
                                          style: empHistoryT,
                                        ),
                                        Spacer(),
                                        IconButton(
                                            onPressed: () async {
                                              final editedDetail =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Employeement_History_Page(
                                                    initialDetail: detail,
                                                    isType: true,
                                                    educationHistory:
                                                        EducationDetail(
                                                            '',
                                                            '',
                                                            '',
                                                            '',
                                                            [],
                                                            '',
                                                            '',
                                                            '',
                                                            '',
                                                            ''),
                                                    isEdit: true,
                                                  ),
                                                ),
                                              );

                                              if (editedDetail != null) {
                                                setState(() {
                                                  experienceDetails[index] =
                                                      editedDetail;
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 24,
                                              color: Colors.red,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor: white1,
                                                    title: Text(
                                                        'Delete this employeement detail?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            experienceDetails
                                                                .removeAt(
                                                                    index);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                        },
                                                        child: Text('Delete'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.delete_outline,
                                              size: 24,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    detail.CompanyName,
                                    style: companyT,
                                  ),
                                  Text(
                                    detail.EmployementType,
                                    style: typeT,
                                  ),
                                  Text(
                                    "${detail.StartDate} ${detail.EndDate == "" ? "" : "-"} ${detail.EndDate == "" ? "" : detail.EndDate}",
                                    style: typeT,
                                  ),
                                  detail.NoticePeriod == ""
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                            'Notice Period',
                                            style: empHistoryT,
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      detail.NoticePeriod,
                                      style: companyT,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  //EDUCATION
  Widget _EducationHistory() {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: white1),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                _profileTitle(title: 'Education'),
              ],
            ),
            eduHistory.length == 0
                ? Text(
                    "No Education Detail Available",
                    style: Wgrey1,
                  )
                : Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: eduHistory.length,
                      itemBuilder: (BuildContext context, int index) {
                        var educationDetail = eduHistory[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // COLLEGE NAME
                            Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    margin: EdgeInsets.only(top: 15),
                                    child: Text(
                                      educationDetail.university,
                                      style: empHistoryT,
                                    )),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      final EducationHistory = Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Employeement_History_Page(
                                                    initialDetail: EmpDetail(
                                                        "",
                                                        "",
                                                        "",
                                                        "",
                                                        "",
                                                        '',
                                                        '',
                                                        2),
                                                    isType: false,
                                                    educationHistory:
                                                        eduHistory[index],
                                                    isEdit: true,
                                                  )));

                                      if (EducationHistory != null) {
                                        setState(() {
                                          eduHistory[index] = educationDetail;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      size: 24,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: white1,
                                            title: Text(
                                                'Delete this education detail?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    eduHistory.removeAt(index);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      size: 24,
                                      color: Colors.red,
                                    )),
                              ],
                            ),

                            //QUALIFICATION
                            Text(
                              educationDetail.qualification,
                              style: companyT,
                            ),

                            //SPECLAIZATION
                            Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  "${educationDetail.specilization.join(", ")}",
                                  style: companyT,
                                )),

                            // //EDUCATION TYPE
                            // Container(
                            //     width:MediaQuery.of(context).size.width/1.5,
                            //     child: Text(educationDetail.educationType,style: companyT,)),

                            //PERCENTAGE/CGPA
                            Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  educationDetail.cgpa,
                                  style: companyT,
                                )),

                            //PERCENTAGE/CGPA
                            Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  educationDetail.educationType,
                                  style: companyT,
                                )),

                            //COURSE DURATION
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                "${educationDetail.startYear} - ${educationDetail.endYear}",
                                style: typeT,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  //LANGUAGE FIELD
  Widget _languageKnown(TextEditingController? Controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          textFormField(
            hintText: "Language",
            keyboardtype: TextInputType.text,
            inputFormatters: null,
            Controller: Controller,
            validating: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter ${'Language'}";
              } else if (!onlyText.hasMatch(value)) {
                return "(Special Characters are Not Allowed)";
              }
              return null;
            },
            onChanged: null,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  textFormFields.removeAt(textFormFields.length - 1);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  //RADIO BUTTON
  Widget _martialStatus() {
    return RadioButton(
        groupValue1: martialVal,
        onChanged1: (value) {
          setState(() {
            martialVal = value;
          });
        },
        radioTxt1: "Single",
        groupValue2: martialVal,
        onChanged2: (value) {
          setState(() {
            martialVal = value;
          });
        },
        radioTxt2: 'Married');
  }

  //DIFFERENT ABLED BUTTON
  Widget _differentlyAbled() {
    return RadioButton(
        groupValue1: DifferentlyAbledVal,
        onChanged1: (value) {
          setState(() {
            DifferentlyAbledVal = value;
          });
        },
        radioTxt1: "Yes",
        groupValue2: DifferentlyAbledVal,
        onChanged2: (value) {
          setState(() {
            DifferentlyAbledVal = value;
          });
        },
        radioTxt2: 'No');
  }

  //PASSPORT BUTTON
  Widget _passport() {
    return RadioButton(
        groupValue1: passportVal,
        onChanged1: (value) {
          setState(() {
            passportVal = value;
          });
        },
        radioTxt1: "Yes",
        groupValue2: passportVal,
        onChanged2: (value) {
          setState(() {
            passportVal = value;
          });
        },
        radioTxt2: 'No');
  }

  //CAREERBREAK BUTTON
  Widget _careerBreak() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: RadioButton(
          groupValue1: careerBreakVal,
          onChanged1: (value) {
            setState(() {
              careerBreakVal = value;
            });
          },
          radioTxt1: "Yes",
          groupValue2: careerBreakVal,
          onChanged2: (value) {
            setState(() {
              careerBreakVal = value;
            });
          },
          radioTxt2: 'No'),
    );
  }

  //PROFILE TITLE
  Widget _profileTitle({required String title}) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: profileTitle,
        ));
  }
}
