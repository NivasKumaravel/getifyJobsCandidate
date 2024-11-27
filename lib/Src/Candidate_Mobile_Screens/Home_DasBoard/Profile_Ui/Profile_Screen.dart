import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getifyjobs/Models/CandidateProfileModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Candidate_Category_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Candidate_Create_Account_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Forget_Password_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Forgot_Mobile_Number.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Login_Screens/Login_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Pdf_Picker.dart';
import 'package:getifyjobs/Src/Common_Widgets/Refferal_Card.dart';
import 'package:getifyjobs/Src/utilits/ApiProvider.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:share_plus/share_plus.dart';

import 'Profile_Detail_Screen.dart';

class Profile_Screen extends ConsumerStatefulWidget {
  const Profile_Screen({super.key});

  @override
  _Profile_ScreenState createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends ConsumerState<Profile_Screen> {
  canidateProfileData? CandidateProfileResponseData;
  List<Employment>? employment = [];
  List<Education>? education= [];
  double? finalpercentage ;


  void _onShare(BuildContext context, referral) async {
    Share.share('Hey!. If you’re looking for a new job, You should give it a shot :\nhttps://play.google.com/store/apps/details?id=com.getifyjobs.candidate\nI’ve had great success with it. Here’s my referral id : $referral'
    );
    // if (result.status == ShareResultStatus.success) {
    //   print('Thank you for sharing my website!');
    // }
  }


  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }



  @override
  Widget build(BuildContext context) {
    final profileResponseData = ref.watch(profileApiProvider);
    return Scaffold(
      backgroundColor: white2,
      appBar:   Custom_AppBar(
        isUsed: false,
        actions: [
          PopupMenuButton(
              surfaceTintColor: white1,
              icon: Icon(Icons.more_vert_outlined),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Candidate_Create_Account(
                                    candidateProfileResponseData:
                                    CandidateProfileResponseData,
                                    isEdit: true,
                                  ))).then((value) {
                                    if (value == "true")
                                      {
                                        ref.refresh(profileApiProvider);
                                      }
                                  });
                    },
                    child: Text(
                      'Edit Info',
                      style: refferalCountT,
                    )),
                PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Candidate_Categoery_Screen(
                                    isEdit: true,
                                    candidateProfileResponseData:
                                    CandidateProfileResponseData,
                                  ))).then((value) {
                        if (value == "true")
                        {
                          ref.refresh(profileApiProvider);
                        }

                      });
                    },
                    child: Text(
                      'Edit Career',
                      style: refferalCountT,
                    )),
                // PopupMenuItem(
                //     onTap: () {
                //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile_Detail_Screen
                //         (CandidateProfileResponseData: CandidateProfileResponseData))).then((value) {
                //         if (value == "true")
                //         {
                //           ref.refresh(profileApiProvider);
                //         }
                //
                //       });
                //     },
                //     child: Text(
                //       'Edit Profile Detail',
                //       style: refferalCountT,
                //     )),
                PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Forget_Password_Screen(
                                candidateId:
                                CandidateProfileResponseData
                                    ?.candidateId ??
                                    "",
                                isReset: false,
                              ))).then((value) {
                        if (value == "true")
                        {
                          ref.refresh(profileApiProvider);
                        }

                      });
                    },
                    child: Text(
                      'Reset Password',
                      style: refferalCountT,
                    )),
                PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Forget_Mobile_Screen(isChangeMobileNo: true,))).then((value) {
                        if (value == "true")
                        {
                          ref.refresh(profileApiProvider);
                        }

                      });
                    },
                    child: Text(
                      'Change Number',
                      style: refferalCountT,
                    )),
              ]),
        ],
        isLogoUsed: false,
        isTitleUsed: true,
        title: "",
      ),

      body:
      profileResponseData?.when(data: (data){
        CandidateProfileResponseData = data?.data;
        PercentageFinalVal(data?.data?.profilePercentage ?? 0);
        return     Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileImg1(
                    ProfileImg: data?.data?.profilePic ?? ""),
                Center(
                    child: Text(
                      data?.data?.name ?? "",
                      style: TitleT,
                    )),

                data?.data?.resume == ""
                    ?SizedBox(
                  height: 20,
                ):
                Container(
                  height: 100,
                  child: _pdfContain(data?.data?.name ?? "",
                      data?.data?.resume ?? ""),
                ),

                contactDetails(
                    ContactLogo: 'phone.svg',
                    Details: '+91 ${data?.data?.phone ?? ""}'),
                contactDetails(
                    ContactLogo: 'email.svg',
                    Details: data?.data?.email ?? ""),
                contactDetails(
                    ContactLogo: 'mapblue.svg',
                    Details: data?.data?.preferredLocation ?? ""),
                contactDetails(
                    ContactLogo: 'briefcaseactive.svg',
                    Details: data?.data?.careerStatus ?? ""),

                // if (finalpercentage != null)
                  ProfileScreen(PercentageVal:   finalpercentage !,),
                _detailInfo(data?.data),
                data?.data?.nationality == null?Container():_PassportDetails(data?.data),
                data?.data?.education == []?Container(): _Education_List(data?.data),
                data?.data?.employment == []?Container(): _EmployeementHistory(data?.data),
                _addMore(data?.data),
                //REFERAL CARD
                ReferalCard(context,
                    isRefferal: false,
                    RefferEarn: 'Refer & Earn 12 Coins',
                    refferalCode: data?.data?.refferalCode ?? "", refferalOnTap: () {
                      _onShare(context,data?.data?.refferalCode ?? "");
                    }),
                referralCount(context, totalReferal: "${data?.data?.totalReferral ?? ""}", pending: '2'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Center(child: LogOutButton(context, onTap: () {
                    CandidateId("");
                    CandidateType("");
                    Routes("false");
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login_Page()), (route) => false);
                  })),
                ),
              ],
            ),
          ),
        );
      }, error: (Object error, StackTrace stackTrace){
        return Text("ERROR");
      }, loading: (){



          return  Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: white2,
                ),
              ),
              const Center(
                child: SpinKitWaveSpinner(
                  trackColor: blue1,
                  color: Colors.black,
                  size: 70,
                  waveColor: Colors.white,
                  curve: Curves.bounceInOut,
                ),
              ),
            ],
          )         ;
      })

    );
  }

  //PDF CONTAINER
  Widget _pdfContain(String username, String pdfURL) {
    return
      PdfPickerExample(
        optionalTXT: "${username}.pdf",
        pdfUrl: pdfURL, isProfile: true, isCancelNeed: false,
      );
  }

  //DETAIL INFO CONTAINER
  Widget _detailInfo(canidateProfileData? data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: white1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          _profileInformation(
              title: 'Date of Birth',
              data:  data?.dob ?? ""),
          _profileInformation(
              title: 'Gender',
              data: data?.gender ?? ""),
          _profileInformation(
              title: 'Martial Status',
              data: data?.maritalStatus ?? ""),
          data?.designation == null
              ? Container()
              : _profileInformation(
                  title: 'Designation',
                  data: data?.designation ?? ""),
          data?.experience == null
              ? Container()
              : _profileInformation(
                  title: 'Experience',
                  data: data?.experience ?? ""),
          data?.startYear == null
              ? Container()
              : _profileInformation(
                  title: 'Course Duration',
                  data: "${data?.startYear ?? ""} - ${data?.endYear ?? ""}"),
          data?.collegeName == null
              ? Container()
              : _profileInformation(
              title: 'College Name',
              data: data?.collegeName ?? ""),
          _profileInformation(
              title: 'Qualification',
              data: data?.qualification ?? ""),
          _profileInformation(
              title: 'Specialization',
              data: data?.specialization ?? ""),
          _profileInformation(
              title: 'Skill Sets',
              data: data?.skill ?? ""),
          //CURRENT ARRERS
          data?.currentArrears == null
              ? Container()
              : _profileInformation(
                  title: 'Current Arrears',
                  data: data?.currentArrears ?? ""),
          //HISTORY ARREARS
          data?.historyOfArrears == null
              ? Container()
              : _profileInformation(
                  title: 'History of Arrears',
                  data: data?.historyOfArrears ?? ""),
          //CURRENT PERCENTAGE
          data?.currentPercentage == null
              ? Container()
              : _profileInformation(
                  title: 'Current Percentage',
                  data: data?.currentPercentage ?? ""),
          _profileInformation(
              title: 'Address',
              data: data?.address ?? ""),

          _profileInformation(
              title: 'Preferred Location',
              data: data?.preferredLocation ?? ""),

          data?.currentSalary == null
              ? Container()
              : _profileInformation(
                  title: 'Current Salary (Per Annum)',
                  data: data?.currentSalary ?? ""),
          data?.expectedSalary == null
              ? Container()
              : _profileInformation(
                  title: 'Expected Salary (Per Annum)',
                  data: data?.expectedSalary ?? ""),
        ],
      ),
    );
  }

  //PASSPORT DEATILS
  Widget _PassportDetails(canidateProfileData? data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 15),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: white1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),

          data?.nationality == '' ? Container() :
          _profileInformation(
              title: 'Nationality',
              data: data?.nationality ?? ""),
          data?.languageKnown == '' ? Container() :
          _profileInformation(
              title: 'Language Known',
              data: data?.languageKnown?? ""),
          data?.differentlyAbled == '' ? Container() :
          _profileInformation(
              title: 'Differently Abled',
              data: data?.differentlyAbled ?? ""),
          data?.passport == '' ? Container() :
          _profileInformation(
              title: 'Passport',
              data: data?.passport ?? ""),
          data?.careerBreak == '' ? Container() :
          _profileInformation(
              title: 'Career Break',
              data: data?.careerBreak ?? ""),
          SizedBox(
            height: 15,
          ),

        ],
      ),
    );
  }

  //CONTENT
  Widget _profileInformation({required String? title, required String? data}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                title.toString(),
                style: infoT,
              )),
          Container(
            width: MediaQuery.sizeOf(context).width/1.2,
              margin: EdgeInsets.only(bottom: 15),
              alignment: Alignment.topLeft,
              child: Text(
                data.toString(),
                style: stxt,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      ),
    );
  }

  //ADD MORE
  Widget _addMore(canidateProfileData? data) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 25),
      child: Center(
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile_Detail_Screen(
                            CandidateProfileResponseData:
                                null, careerStatus: CandidateProfileResponseData?.careerStatus ?? "",
                          ))).then((value) {
                if (value == "true")
                {
                  ref.refresh(profileApiProvider);
                }

              });
            },
            child: Text(
              "Add More",
              style: addMoreT,
            )),
      ),
    );
  }

  //EDUCATION
  Widget _Education_List(canidateProfileData? data){
    return  Container(
      margin: EdgeInsets.only(bottom: 0, top: 15),
      width: MediaQuery.of(context).size.width,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(5), color: white1),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data?.education?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            var educationDetail = data?.education?[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // COLLEGE NAME
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          educationDetail?.institute ?? "",
                          style: empHistoryT,
                        )),

                  ],
                ),

                //QUALIFICATION
                Text(
                  educationDetail?.qualification ?? "",
                  style: companyT,
                ),

                //SPECLAIZATION
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      "${educationDetail?.specialization ?? ""}",
                      style: companyT,
                    )),

                // //EDUCATION TYPE
                Container(
                    width:MediaQuery.of(context).size.width/1.5,
                    child: Text(educationDetail?.educationType ?? "",style: companyT,)),

                //PERCENTAGE/CGPA
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      educationDetail?.cgpa ?? "",
                      style: companyT,
                    )),

                //COURSE DURATION
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "${educationDetail?.startDate ?? ""} - ${educationDetail?.endDate ?? ""}",
                    style: typeT,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  //EMPLOYEEMENT HISTORY
  Widget _EmployeementHistory(canidateProfileData? data){
    return  Container(
      margin: EdgeInsets.only(bottom: 0, top: 15),
      width: MediaQuery.of(context).size.width,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(5), color: white1),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child:
        Container(
          child:
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data?.employment?.length ?? 0,
            itemBuilder: (context, index) {
              var detail = data?.employment?[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10,),
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
                          child: Text(
                            detail?.jobRole ?? "",
                            style: empHistoryT,
                          ),
                        ),
                        Text(
                          detail?.companyName ?? "",
                          style: companyT,
                        ),
                        Text(
                          detail?.jobType ?? "",
                          style: typeT,
                        ),
                        Text(
                          "${detail?.startDate ?? ""} ${detail?.endDate == ""?"":"-"} ${detail?.endDate == ""?"":detail?.endDate ?? ""}",
                          style: typeT,
                        ),
                        detail?.noticePeriod == ""?Container(): Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            'Notice Period',
                            style: empHistoryT,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            detail?.noticePeriod ?? "",
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
      ),
    );
  }



  // CandidateProfileResponse() async {
  //   final candidateProfileApiService = ApiService(ref.read(dioProvider));
  //   var formData = FormData.fromMap({"candidate_id": await getcandidateId()});
  //   final profileResponseJobDetails =
  //       await candidateProfileApiService.post<CandidateProfileModel>(
  //           context, ConstantApi.candidateProfileUrl, formData);
  //   if (profileResponseJobDetails.status == true) {
  //     setState(() {
  //       CandidateProfileResponseData = profileResponseJobDetails?.data;
  //       print("RESPONSE : ${profileResponseJobDetails.data}");
  //       PercentageFinalVal(CandidateProfileResponseData?.profilePercentage ?? 0);
  //     });
  //
  //   } else {
  //     ShowToastMessage(profileResponseJobDetails.message ?? "");
  //     print('ERROR');
  //   }
  // }

  void PercentageFinalVal(int currentPercentage) {
    if (currentPercentage != null) {
      try {
        int percentage = currentPercentage;
        setState(() {
          finalpercentage = percentage / 100;
        });
        print("FINAL PERCENTAGE ${finalpercentage}"); // Divide by 10 as per your requirement // Update the state to reflect the new value
      } catch (e) {
        print('Error parsing percentage: $e');
      }
    } else {
      print('Current percentage is null or empty');
      // Handle if necessary
    }
  }
}

class ProfileScreen extends StatefulWidget {
  double PercentageVal;
  ProfileScreen({super.key,required this.PercentageVal});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  double? profileCompletion; // Set the profile completion percentage here (e.g., 0.75 for 75%)

  Color getColorForProgress(double progress) {
    if (progress <= 0.2) {
      return red2;
    } else if (progress <= 0.4) {
      return orange2;
    } else if (progress <= 0.6) {
      return yellow3;
    } else {
      return green1;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileCompletion = widget.PercentageVal;
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = profileCompletion!.clamp(
        0.0, 1.0); // Ensure progress is within the range [0, 1]
    Color progressColor = getColorForProgress(progressValue);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 8),
            alignment: Alignment.topLeft,
            child: Text(
              '${(progressValue * 100).toInt()}% Profile Completed',
              style: progressT,
            )),
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(5),
          minHeight: 15,
          value: progressValue,
          backgroundColor: white1,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
