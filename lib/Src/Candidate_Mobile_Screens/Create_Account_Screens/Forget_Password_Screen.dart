import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ResetPasswordModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Login_Screens/Login_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Forget_Password_Screen extends ConsumerStatefulWidget {
  final String candidateId;
  final bool isReset;
   Forget_Password_Screen({super.key,required this.candidateId,required this.isReset});

  @override
  ConsumerState<Forget_Password_Screen> createState() => _Forget_Password_ScreenState();
}

class _Forget_Password_ScreenState extends ConsumerState<Forget_Password_Screen> {
  String NewPassword = '';
  String ReEnterPassword = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasword = TextEditingController();
  TextEditingController reEnterPassword = TextEditingController();

  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();


  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode1.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      // appBar: Custom_AppBar(isUsed: false, actions: null, isLogoUsed: true, isTitleUsed: false,title: '',),
      body:Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  //LOGO
                  Center(child: Logo(context)),
                   const Spacer(),
                  //CONTAINER
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: white1
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //FORGET PASSWORD
                         Padding(
                           padding: const EdgeInsets.only(top: 35,bottom: 25),
                           child: Text(widget.isReset == true?"Reset Password":"Reset Password",style: TitleT,),
                         ),

                         //ENTER NEW PASSWORD
                          Title_Style(Title: widget.isReset == true?'Enter New Password':"Enter Old Password", isStatus: true),
                          textFormField(
                            hintText: widget.isReset == true?'Enter New Password':"Enter Old Password",
                            keyboardtype: TextInputType.text,
                            focusNode: _focusNode,
                            inputFormatters: null,
                            Controller: newPasword,
                            validating: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter a Valid Password';
                              }

                              // Check if the password meets the complexity requirements
                              RegExp uppercaseRegex = RegExp(r'[A-Z]');
                              RegExp lowercaseRegex = RegExp(r'[a-z]');
                              RegExp digitRegex = RegExp(r'[0-9]');
                              RegExp specialCharRegex = RegExp(r'[@#$*&%^+()!\-_={}[\]]');
                              RegExp lengthRegex = RegExp(r'^.{8,15}$'); // Minimum 8 and maximum 15 characters

                              // Check if all required character types are present
                              if (!uppercaseRegex.hasMatch(value) ||
                                  !lowercaseRegex.hasMatch(value) ||
                                  !digitRegex.hasMatch(value) ||
                                  !specialCharRegex.hasMatch(value)) {
                                return 'Password should be with the combination of Aa@#1';
                              }

                              // Check if the length is between 8 and 15 characters
                              if (!lengthRegex.hasMatch(value)) {
                                return 'Password should be with minimum 8 and maximum 15 characters';
                              }

                              return null;
                            },
                            onChanged:widget.isReset == true? null: (value){
                              NewPassword= value;
                            },
                          ),

                          //Re-Enter New Password
                          Title_Style(Title: widget.isReset == true?'Re-Enter New Password':"Enter New Password", isStatus: true),
                          textFormField(
                            hintText: widget.isReset == true?'Re-Enter New Password':"Enter New Password",
                            keyboardtype: TextInputType.text,
                            inputFormatters: null,
                            focusNode: _focusNode1,
                            Controller: reEnterPassword,
                            validating:widget.isReset == true?
                                (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Valid ${'Password'}";
                                  }
                                  RegExp uppercaseRegex = RegExp(r'[A-Z]');
                                  RegExp lowercaseRegex = RegExp(r'[a-z]');
                                  RegExp digitRegex = RegExp(r'[0-9]');
                                  RegExp specialCharRegex = RegExp(r'[@#$*&%^+()!\-_={}[\]]');
                                  RegExp lengthRegex = RegExp(r'^.{8,15}$'); // Minimum 8 and maximum 15 characters

                                  // Check if all required character types are present
                                  if (!uppercaseRegex.hasMatch(value) ||
                                      !lowercaseRegex.hasMatch(value) ||
                                      !digitRegex.hasMatch(value) ||
                                      !specialCharRegex.hasMatch(value)) {
                                    return 'Password should be with the combination of Aa@#1';
                                  }

                                  // Check if the length is between 8 and 15 characters
                                  if (!lengthRegex.hasMatch(value)) {
                                    return 'Password should be with minimum 8 and maximum 15 characters';
                                  }
                                  if (value == NewPassword) {
                                    return "Password does match with New Password";
                                  }
                                  return null;
                                }:
                              (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Valid ${'Password'}";
                              }
                              RegExp uppercaseRegex = RegExp(r'[A-Z]');
                              RegExp lowercaseRegex = RegExp(r'[a-z]');
                              RegExp digitRegex = RegExp(r'[0-9]');
                              RegExp specialCharRegex = RegExp(r'[@#$*&%^+()!\-_={}[\]]');
                              RegExp lengthRegex = RegExp(r'^.{8,15}$'); // Minimum 8 and maximum 15 characters

                              // Check if all required character types are present
                              if (!uppercaseRegex.hasMatch(value) ||
                                  !lowercaseRegex.hasMatch(value) ||
                                  !digitRegex.hasMatch(value) ||
                                  !specialCharRegex.hasMatch(value)) {
                                return 'Password should be with the combination of Aa@#1';
                              }

                              // Check if the length is between 8 and 15 characters
                              if (!lengthRegex.hasMatch(value)) {
                                return 'Password should be with minimum 8 and maximum 15 characters';
                              }
                              if (value == NewPassword) {
                                return "Password does not match with Old password";
                              }
                              return null;
                            },
                            onChanged: (value){
                              ReEnterPassword = value;
                            },
                          ),


                          //ELEVATED BUTTON
                          Padding(
                            padding: const EdgeInsets.only(top: 50,bottom: 0,left: 50,right: 50),
                            child: CommonElevatedButton(context, widget.isReset == true?"Submit":"Verify", () {
                              if(_formKey.currentState!.validate()){
                                ResetPasswordResponse();
                              }
                            }),
                          )

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  //RESET PASSWORD RESPONSE
ResetPasswordResponse() async{
    final resetApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "password":reEnterPassword.text,
      "old_password":widget.isReset == true?"":newPasword.text,
      "candidate_id":widget.candidateId,
    });
    final resetPasswordResponse = await resetApiService.post<ResetPasswordModel>
      (context, widget.isReset == true?ConstantApi.resetPassowrdUrl:ConstantApi.changePasswordUrl, formData);
    if(resetPasswordResponse?.status == true){
      ShowToastMessage(resetPasswordResponse?.message ?? "");
      print("PASSWORD CHANGED SUCCESS");
    widget.isReset == true?  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login_Page()), (route) => false):Navigator.pop(context);
    }else{
      ShowToastMessage(resetPasswordResponse?.message ?? "");
      print("PASSWORD CHANGED SUCCESS");
    }
}
}
