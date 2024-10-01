import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Otp_Verification_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class OtpVerfication extends StatefulWidget {
  const OtpVerfication({super.key});

  @override
  State<OtpVerfication> createState() => _OtpVerficationState();
}

class _OtpVerficationState extends State<OtpVerfication> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _mobileNumber = '';

  TextEditingController _mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white2,
        appBar: Custom_AppBar(
          isUsed: true,
          isLogoUsed: true,
          title: "",
          isTitleUsed: true,
          actions: [],
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Logo(context)),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                      color: white1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 35),
                          child: Text(
                            "OTP Verification",
                            style: TitleT,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            "Mobile Number",
                            style: inboxcompany,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20, top: 20, right: 20, bottom: 250),
                          child: textFormField(
                              // isEnabled: false,
                              hintText: "Mobile No",
                              keyboardtype: TextInputType.phone,
                              Controller: _mobileController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                _mobileNumber = value!;
                              },
                              validating: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a mobile number';
                                } else if (!RegExp(r'^[0-9]{10}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid 10-digit mobile number';
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 15, bottom: 15),
                          child: Center(
                            child: Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text:
                                          'If you already have a account, click ',
                                      style: richtext1,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Log in',
                                            style: richtext2,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // navigate to desired screen
                                                print("object");
                                              })
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 10),
                                  child: Container(
                                      width: 260,
                                      child: CommonElevatedButton(
                                          context, "Verify", () {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Otp_Verification_Page(
                                                        isForget: false,
                                                        mobileNumber:
                                                            _mobileController
                                                                .text,
                                                      )));
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
        ));
  }
}
