import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/OtpModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Login_Screens/Login_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Models/ResentOtpModel.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';

import '../../utilits/ApiService.dart';
import '../../utilits/Text_Style.dart';
import 'Candidate_Category_Screen.dart';
import 'Forget_Password_Screen.dart';

class Otp_Verification_Page extends ConsumerStatefulWidget {
  final bool? isForget;
  final String? mobileNumber;

  Otp_Verification_Page(
      {super.key, required this.isForget, required this.mobileNumber});

  @override
  ConsumerState<Otp_Verification_Page> createState() =>
      _Otp_Verification_PageState();
}

class _Otp_Verification_PageState extends ConsumerState<Otp_Verification_Page> {
  int _timeLeft = 30; // Timer duration in seconds
  bool _isTimerActive = false;
  TextEditingController _OTP1 = TextEditingController();
  TextEditingController _OTP2 = TextEditingController();
  TextEditingController _OTP3 = TextEditingController();
  TextEditingController _OTP4 = TextEditingController();
  TextEditingController _OTP5 = TextEditingController();
  TextEditingController _OTP6 = TextEditingController();

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  FocusNode _focusNode5 = FocusNode();
  FocusNode _focusNode6 = FocusNode();

  @override
  void dispose() {
    _OTP1.dispose();
    _OTP2.dispose();
    _OTP3.dispose();
    _OTP4.dispose();
    _OTP5.dispose();
    _OTP6.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    super.dispose();
  }

  void _tick() {
    if (_timeLeft == 0) {
      setState(() {
        _isTimerActive = false;
      });
    } else {
      setState(() {
        _timeLeft--;
      });
    }
  }

  void _startTimer() {
    setState(() {
      _timeLeft = 30;
      _isTimerActive = true;
    });

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_isTimerActive) {
        _tick();
      } else {
        timer.cancel();
      }
    });
  }

  void _clearOtpFields() {
    _OTP1.clear();
    _OTP2.clear();
    _OTP3.clear();
    _OTP4.clear();
    _OTP5.clear();
    _OTP6.clear();
  }

  Widget _textFieldOTP({bool? first, bool? last, TextEditingController? controller, FocusNode? focusNode}) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: TextField(
        controller: controller,
        maxLength: 1,
        focusNode: focusNode,
        onChanged: (value) {
          if (value.length == 1) {
            focusNode?.nextFocus();
          }
          if (value.isEmpty) {
            focusNode?.previousFocus();
          }
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          counter: Offstage(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }



  @override
  Widget build(BuildContext context) {
    String maskedMobileNumber = widget.mobileNumber!.replaceRange(6, 10, "xxxx");

    return Scaffold(
      backgroundColor: white2,
      // appBar: Custom_AppBar(
      //   title: "",
      //   isUsed: true,
      //   actions: [],
      //   isLogoUsed: true,
      //   isTitleUsed: true,
      // ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50,bottom: 0,left: 20),
                      child: ImgPathSvg("arrowback.svg"),
                    )),
                Center(child: Logo(context)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25)),
                      color: white1,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 35, bottom: 25),
                              alignment: Alignment.center,
                              child: Text(
                                widget.isForget == true
                                    ? "Forgot Password"
                                    : "OTP Verification",
                                style: TitleT,
                              )),
                          Center(
                              child: Text(
                            "We have sent a verification code to ",
                            style: inboxcompany,
                          )),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Text(
                              maskedMobileNumber,
                              style: TBlack,
                            ),
                          )),
                          Container(
                            // color: Colors.green,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _textFieldOTP(controller: _OTP1, focusNode: _focusNode1),
                                _textFieldOTP(controller: _OTP2, focusNode: _focusNode2),
                                _textFieldOTP(controller: _OTP3, focusNode: _focusNode3),
                                _textFieldOTP(controller: _OTP4, focusNode: _focusNode4),
                                _textFieldOTP(controller: _OTP5, focusNode: _focusNode5),
                                _textFieldOTP(controller: _OTP6, focusNode: _focusNode6),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap:
                                      // _isTimerActive ? null:
                                      () {
                                    _startTimer();

                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child:
                                        Text(_isTimerActive ? "00:$_timeLeft" : "",
                                            // style: changeT,
                                            style: TextStyle(color: red1)),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: InkWell(
                                    onTap: () async {
                                      _startTimer(); // Assuming _startTimer() function handles timer functionality
                                      _clearOtpFields();
                                      // API Call
                                      final apiService =
                                          ApiService(ref.read(dioProvider));
                                      var formData = FormData.fromMap(
                                          {"candidate_id": await getcandidateId()});

                                      try {
                                        final postResponse =
                                            await apiService.post<Resentotp>(
                                                context,
                                                ConstantApi.OtpResent,
                                                formData);
                                        print(
                                            "Candidate ID: ${postResponse.data?.candidateId ?? ""}");
                                      } catch (e) {
                                        print("Error occurred: $e");
                                        // Handle error here
                                      }
                                    },
                                    child: Text(
                                      _isTimerActive
                                          ? 'Resending OTP...'
                                          : 'Resend OTP',
                                      style: TextStyle(
                                        color: _isTimerActive
                                            ? red1
                                            : Color.fromRGBO(34, 152, 255, 1),
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),

                                  // InkWell(
                                  //   onTap: (){
                                  //     _startTimer();
                                  //   },
                                  //   child: Text(
                                  //     _isTimerActive
                                  //         ? 'Resend OTP'
                                  //         : 'Resend OTP',
                                  //     style: TextStyle(
                                  //         color: _isTimerActive
                                  //             ?  red1
                                  //             : Color.fromRGBO(34, 152, 255, 1),
                                  //         fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 200,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 15, bottom: 15),
                            child: Center(
                              child: Column(
                                children: [
                                 widget.isForget == true?Container(): RichText(
                                    text: TextSpan(
                                        text:
                                            'If you already have an account, click ',
                                        style: richtext1,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Login',
                                              style: richtext2,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Login_Page()), (route) => false);
                                                  print("object");
                                                })
                                        ]),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 16, bottom: 10),
                                    child: Container(
                                        width: 260,
                                        child: CommonElevatedButton(
                                            context, "Verify", () async {
                                          final apiService =
                                              ApiService(ref.read(dioProvider));
                                          var formData = FormData.fromMap({
                                            "phone":widget.mobileNumber,
                                            "otp":
                                                "${_OTP1.text}${_OTP2.text}${_OTP3.text}${_OTP4.text}${_OTP5.text}${_OTP6.text}",
                                            "candidate_id": await getcandidateId()
                                          });
                                          final postResponse =
                                              await apiService.post<OtpModel>(
                                                  context,
                                                 widget.isForget == true?ConstantApi.forgotOtpUrl: ConstantApi.otpVerification,
                                                  formData);
                                          print(
                                              "Candidate ID: ${postResponse.data?.candidateId ?? ""}");

                                          if (postResponse.status == true) {
                                            widget.isForget == true
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Forget_Password_Screen(candidateId: postResponse.data?.candidateId ?? "", isReset: true,)))
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Candidate_Categoery_Screen(isEdit: false, candidateProfileResponseData: null, )));
                                          } else {
                                            ShowToastMessage(
                                                postResponse.message ?? "");
                                          }
                                        })),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


