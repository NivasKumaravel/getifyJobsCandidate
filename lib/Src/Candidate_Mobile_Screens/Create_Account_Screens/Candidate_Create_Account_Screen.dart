import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getifyjobs/Models/CandidateProfileModel.dart';
import 'package:getifyjobs/Models/LoginModel.dart';
import 'package:getifyjobs/Models/OtpModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Otp_Verification_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../Common_Widgets/Common_Button.dart';
import '../../Common_Widgets/Text_Form_Field.dart';
import '../../utilits/Common_Colors.dart';
import '../../utilits/Text_Style.dart';
import '../Login_Screens/Login_Page.dart';

class Candidate_Create_Account extends ConsumerStatefulWidget {
  canidateProfileData? candidateProfileResponseData;
  final bool isEdit;
   Candidate_Create_Account({super.key,required this.candidateProfileResponseData,required this.isEdit});

  @override
  ConsumerState<Candidate_Create_Account> createState() =>
      _Candidate_Create_AccountState();
}

class _Candidate_Create_AccountState
    extends ConsumerState<Candidate_Create_Account> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String? selectedOption;
  String? selectExpVal;
  String _password = "";
  String ProfileImg = "";

  int? genderVal;
  int? martialVal;
  bool _obscurePassword = true; // Initially hide the password
  String? qualificationOption;
  bool isProfilePicPicked = true;
  List<String> Categoery = ['Experienced', 'Fresher', 'Student'];

  TextEditingController _FullName = TextEditingController();
  TextEditingController _ReferralCode = TextEditingController();
  TextEditingController _Dob = TextEditingController();

  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  FocusNode _focusNode5 = FocusNode();
  FocusNode _focusNode6 = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    super.dispose();
  }

  TextEditingController _EnterOfficialEmail = TextEditingController();
  TextEditingController _EnterOfficialMobile = TextEditingController();
  TextEditingController _Address = TextEditingController();
  TextEditingController _CreatePassword = TextEditingController();

  RegExp onlyText = RegExp(r'^[a-zA-Z ]+$');

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
  String _toTitleCase(String text) {
    if (text.isEmpty) return '';

    return text.toLowerCase().split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return '';
    }).join(' ');
  }
  void _FullNameFormat() {
    final text = _FullName.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _FullName.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  void _AddressFormat() {
    final text = _Address.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _Address.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _FullName.addListener(_FullNameFormat);
    _Address.addListener(_AddressFormat);
    widget.isEdit == true? EditValue(): null;
  }


  EditValue(){
    _FullName.text = widget.candidateProfileResponseData?.name ?? "";
    _Dob.text = widget.candidateProfileResponseData?.dob ?? "";
    _EnterOfficialEmail.text = widget.candidateProfileResponseData?.email ?? "";
    _EnterOfficialMobile.text = widget.candidateProfileResponseData?.phone ?? "";
    _Address.text = widget.candidateProfileResponseData?.address ?? "";
    _Address.text = widget.candidateProfileResponseData?.address ?? "";
    ProfileImg = widget.candidateProfileResponseData?.profilePic ?? "";
    genderVal =widget.candidateProfileResponseData?.gender == "Male"? 0:widget.candidateProfileResponseData?.gender == "Female"?1:2;
    martialVal =widget.candidateProfileResponseData?.maritalStatus == "Married"? 0:widget.candidateProfileResponseData?.maritalStatus == "UnMarried"?1:2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: widget.isEdit == false?null:Custom_AppBar(isUsed: true, actions: null, isLogoUsed: true, isTitleUsed: true,title: "Edit Account",),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top:widget.isEdit == true?0: 20, bottom: 25),
                  child: Center(child: Logo(context)),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: white1),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                        widget.isEdit == true?
                        Padding(
                          padding: const EdgeInsets.only(top: 35, bottom: 5),
                          child: Title_Heading("Edit Account"),
                        ):
                        Padding(
                            padding: const EdgeInsets.only(top: 35, bottom: 5),
                            child: Title_Heading("Create Account"),
                          ),
                          profile_Picker(),

                          //FULL NAME
                          Title_Style(Title: 'Full Name', isStatus: true),
                          textFormField(
                            hintText: 'Full Name',
                            keyboardtype: TextInputType.text,
                            inputFormatters: null,
                            Controller: _FullName,
                            focusNode:_focusNode,
                            validating: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Your Name";
                              }
                              else if (!onlyText.hasMatch(value)) {
                                return "Special Characters are Not Allowed";
                              }
                              return null;
                            },
                            onChanged: null,
                          ),

                          //Phone Number*
                        widget.isEdit == true?Container():  Title_Style(Title: 'Mobile Number', isStatus: true),
                          widget.isEdit == true?Container():  textFormField(
                            hintText: 'Mobile Number',
                            keyboardtype: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            focusNode:_focusNode1,
                            Controller: _EnterOfficialMobile,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Mobile Number";
                              } else if (!RegExp(r"^[0-9]{10}$")
                                  .hasMatch(value)) {
                                return "Please enter a valid 10-digit mobile number";
                              }
                              return null;
                            },
                            onChanged: null,
                          ),
                          // SubText(
                          //     "Recruiter Will Contact You to this Mobile Number"),
                          //Email Address*
                          Title_Style(Title: 'Email Address', isStatus: true),
                          textFormField(
                            hintText: 'Email Address',
                            keyboardtype: TextInputType.text,
                            inputFormatters: null,
                            focusNode:_focusNode2,
                            Controller: _EnterOfficialEmail,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Email Address";
                              } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return "Please Enter Your Email Address";
                              }
                              return null;
                            },
                            onChanged: null,
                          ),

                          //ADDRESS
                          Title_Style(Title: 'Enter Your Address', isStatus: true),
                          textfieldDescription(
                            Controller: _Address,
                            inputFormatters: null,
                            focusNode:_focusNode3,
                            validating: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Your Address with Pincode";
                              }
                              if (value == null) {
                                return "Please Enter Your Address with Pincode";
                              }
                              return null;
                            }, hintText: 'Enter Your Address with Pincode',
                          ),

                          Title_Style(Title: 'Date of Birth', isStatus: false),
                          TextFieldDatePicker(
                            Controller: _Dob,
                            onChanged: null,
                            focusNode:_focusNode4,
                            hintText: 'dd/MM/yyyy',
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat("dd/MM/yyyy").format(pickedDate);
                                if (mounted) {
                                  setState(() {
                                    _Dob.text = formattedDate;
                                  });
                                }
                                DateTime currentDate = DateTime.now();
                                int age = currentDate.year - pickedDate.year;
                                if (age < 16) {
                                  _Dob.text = "";
                                  _showErrorDialog(
                                      "You must be at least 16 years old to register.");
                                }
                              }
                            },
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Please select Date of Birth';
                              } else {
                                DateTime selectedDate =
                                    DateFormat("dd/MM/yyyy").parse(value);
                                DateTime currentDate = DateTime.now();
                                int age = currentDate.year - selectedDate.year;
                                if (age < 16) {
                                  return 'You must be at least 16 years old to register.';
                                } else {
                                  return null;
                                }
                              }
                            }, isDownArrow: true,
                          ),
                          //GENDER
                          Title_Style(Title: 'Gender', isStatus: true),
                          MultiRadioButton(context,
                              groupValue1: genderVal,
                              groupValue2: genderVal,
                              groupValue3: genderVal, onChanged1: (value) {
                            setState(() {
                              genderVal = value;
                            });
                          }, onChanged2: (value) {
                            setState(() {
                              genderVal = value;
                            });
                          }, onChanged3: (value) {
                            setState(() {
                              genderVal = value;
                            });
                          },
                              radioTxt1: 'Male',
                              radioTxt2: 'Female',
                              radioTxt3: 'Others'),


                          //MARTIAL STATUS
                          Title_Style(Title: 'Marital Status', isStatus: true),
                          MultiRadioButton(context,
                              groupValue1: martialVal,
                              groupValue2: martialVal,
                              groupValue3: martialVal, onChanged1: (value) {
                            setState(() {
                              martialVal = value;
                            });
                          }, onChanged2: (value) {
                            setState(() {
                              martialVal = value;
                            });
                          }, onChanged3: (value) {
                            setState(() {
                              martialVal = value;
                            });
                          },
                              radioTxt1: 'Married',
                              radioTxt2: 'UnMarried',
                              radioTxt3: 'UnDisclosed'),

                          //CREATE PASSWORD
                       widget.isEdit == true?Container(): Title_Style(Title: 'Create Password', isStatus: true),
                          widget.isEdit == true?Container():    textFieldPassword(
                            Controller: _CreatePassword,
                            focusNode:_focusNode5,
                            obscure: _obscurePassword,
                            onPressed: _togglePasswordVisibility,
                            hintText: "Enter Password",
                            keyboardtype: TextInputType.text,
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            validating:
                                (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter a Password';
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

                                  // Check if the length is between 8 - 15 characters
                                  if (!lengthRegex.hasMatch(value)) {
                                    return 'Password should between 8 - 15 characters';
                                  }

                                  return null;
                            },
                          ),
                          widget.isEdit == true?Container():
                          SubText(
                              "Password should be with the combination of Aa@#1"),

                          //REFERRAL CODE
                          widget.isEdit == true?Container():     Title_Style(Title: 'Referral Code', isStatus: false),
                          widget.isEdit == true?Container():
                          textFormField(
                            hintText: 'Referral Code',
                            keyboardtype: TextInputType.text,
                            focusNode:_focusNode6,
                            inputFormatters: null,
                            Controller: _ReferralCode,
                            validating: null,
                            onChanged: null,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //MAP LOCATION
                          widget.isEdit == true?Container():   InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login_Page()));
                              },
                              child: AlreadyAccount(
                                txt1: 'If you already have an account, click ',
                                txt2: 'Log in',
                              )),
                          widget.isEdit == true?Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 50, left: 50, right: 50),
                            child:
                            CommonElevatedButton(context, "Submit", ()  {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if(genderVal == null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please Select Your Gender'),
                                    ),
                                  );
                                }else if(martialVal == null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please Select Your Marital Status'),
                                    ),
                                  );
                                }else{
                                  EditApiResponse();
                              }
                              }
                            }),
                          ):   Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 50, left: 50, right: 50),
                            child:
                                CommonElevatedButton(context, "Next", () async {

                                 if (_formKey.currentState!.validate()) {
                                   FocusManager.instance.primaryFocus?.unfocus();
                                   if(genderVal == null){
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                         content: Text('Please Select Your Gender'),
                                       ),
                                     );
                                   }else if(martialVal == null){
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                         content: Text('Please Select Your Marital Status'),
                                       ),
                                     );
                                   }else{
                                     final registerApiService =
                                     ApiService(ref.read(dioProvider));

                                     var formData = FormData.fromMap({
                                       "name": _FullName.text,
                                       "email": _EnterOfficialEmail.text,
                                       "phone": _EnterOfficialMobile.text,
                                       "address": _Address.text,
                                       "dob": _Dob.text,
                                       "password": _CreatePassword.text,
                                       "gender": genderVal==0?"Male":genderVal == 1?"Female":"Others",
                                       "marital_status": martialVal ==0?"Married":martialVal == 1?"UnMarried":"Not to Disclose",
                                       "device_token": "",
                                       "device_id": "",
                                     });

                                     if (_image != null) {
                                       String fileName = _image!.path.split('/').last;
                                       print("IMAGE PATH : ${_image!.path}");

                                       List<int> compressedImage =
                                       await compressImage(_image!);

                                       formData.files.addAll([
                                         MapEntry(
                                             'profile_pic',
                                             await MultipartFile.fromBytes(
                                               compressedImage,
                                               filename: 'compressed_image.jpg',
                                             )),
                                       ]);
                                     }

                                     final recruiterResponse =
                                     await registerApiService.post<OtpModel>(
                                         context,
                                         ConstantApi.candidateRegister,
                                         formData);
                                     print(
                                         'RECRUITER ID : ${recruiterResponse.data?.candidateId ?? ""}');

                                     CandidateId(
                                         recruiterResponse.data?.candidateId ?? "");

                                     if (recruiterResponse.status == true) {
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                               builder: (context) =>
                                                   Otp_Verification_Page(
                                                       isForget: false,
                                                       mobileNumber:
                                                       _EnterOfficialMobile
                                                           .text)));
                                     } else {
                                       ShowToastMessage(
                                           recruiterResponse.message ?? "");
                                       print('ERROR');
                                     }
                                   }
                                 }
                            }),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Profile Picker
  Widget profile_Picker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 80,
              width: 80,
              child: Stack(
                children: [
                  InkWell(
                    onTap: _showImagePickerBottomSheet,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor:
                          isProfilePicPicked == true ? white4 : red1,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : Image.network(ProfileImg).image,
                    ),
                  ),
                  Positioned(top: 55, child: ImgPathSvg("profilepic.svg")),
                  Positioned(
                      top: 60, left: 32, child: ImgPathSvg("camera.svg")),
                ],
              ),
            ),
          ),
          Title_Style(Title: "Profile Photo", isStatus: false)

        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        isProfilePicPicked = true;
      });
    }
    Navigator.pop(context); // Close the bottom sheet after selecting an image
  }

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take Photo'),
                onTap: () {
                  setState(() {
                    _pickImage(ImageSource.camera);
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Choose from Gallery'),
                onTap: () {
                  setState(() {
                    _pickImage(ImageSource.gallery);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
  //EDIT LOGIN API RESPONSE
  EditApiResponse() async{
    final registerApiService =
    ApiService(ref.read(dioProvider));

    var formData = FormData.fromMap({
      "name": _FullName.text,
      "email": _EnterOfficialEmail.text,
      "phone": _EnterOfficialMobile.text,
      "address": _Address.text,
      "dob": _Dob.text,
      "password": _CreatePassword.text,
      "gender": genderVal==0?"Male":genderVal == 1?"Female":"Others",
      "marital_status": martialVal ==0?"Married":martialVal == 1?"UnMarried":"Not to Disclose",
      "device_token": "",
      "device_id": "",
      "candidate_id":widget.candidateProfileResponseData?.candidateId ?? "",
    });

    if (_image != null) {
      String fileName = _image!.path.split('/').last;
      print("IMAGE PATH : ${_image!.path}");

      List<int> compressedImage =
      await compressImage(_image!);

      formData.files.addAll([
        MapEntry(
            'profile_pic',
            await MultipartFile.fromBytes(
              compressedImage,
              filename: 'compressed_image.jpg',
            )),
      ]);
    }

    final recruiterResponse = await registerApiService.post<OtpModel>(context, ConstantApi.editRegisterUrl,formData);

    if(recruiterResponse?.status == true){
      print('EDIT SUCCESS');
      ShowToastMessage(recruiterResponse?.message ?? "");
    Navigator.pop(context,'true');
    }else{
      print("EDIT ERROR");
    }
  }
}