import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getifyjobs/Models/LoginModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Candidate_Category_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Candidate_Create_Account_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Forgot_Mobile_Number.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Otp_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Otp_Verification_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login_Page extends ConsumerStatefulWidget {
  const Login_Page({super.key});

  @override
  ConsumerState<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends ConsumerState<Login_Page> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode1.dispose();
    super.dispose();
  }

  RegExp passwordSpecial = RegExp(r'^(?=.[a-z])(?=.[A-Z])(?=.[@#$])(?=.[0-9]).*$');
  RegExp passwordLength = RegExp(r'^(?=.[a-z])(?=.[A-Z])(?=.[@#$])(?=.[0-9]).{8,15}$');


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _mobileNumber = '';
  String _password = "";
  bool _obscurePassword = true; // Initially hide the password

  //BUTTON VALIDATION
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      print('Mobile Number: $_mobileNumber');
      print('Password: $_password');

      final apiService = ApiService(ref.read(dioProvider));
      var formData =
          FormData.fromMap({"phone": _mobileNumber, "password": _password});

      // LoginModel? user = await apiService.loginUser<LoginModel>(formData, LoginModel.fromJson);

      // if (user?.status == true)
      // {

      // }

      final postResponse = await apiService.post<LoginModel>(
          context, ConstantApi.candidateLogin, formData);

      if (postResponse.status == true) {
        CandidateId(postResponse.data?.candidateId ?? "");
        CandidateType(postResponse.data?.candidateType ?? "");

        ShowToastMessage(postResponse.message ?? "");
        Routes("true");
        postResponse.data?.candidateType == "Student"
            ? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Bottom_Navigation(select: 0)), (route) => false)
            : Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
            Candidate_Bottom_Navigation(select: 0)), (route) => false);
      } else {
        CandidateId(postResponse.data?.candidateId ?? "");
        CandidateType(postResponse.data?.candidateType ?? "");

        postResponse.otp_verify_status == false
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Otp_Verification_Page(
                        isForget: false, mobileNumber: _mobileNumber)))
            : postResponse.profile_status == false
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Candidate_Categoery_Screen(isEdit: false, candidateProfileResponseData: null,)))
                : ShowToastMessage(postResponse.message ?? "");
      }
    }
  }

  //PASSWORD VISIBILITY FUNCTION
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: white2,
      body: SingleChildScrollView(child: _Mainbody()),
    );
  }

  //MAIN BODY
  Widget _Mainbody() {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Form(
        key: _formKey,
        child: Container(
          color: white2,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //GETIFY LOGO
              Container(
                margin: EdgeInsets.only(top: 20),
                  child: Logo(context)),
              //LOGIN SCREEN IMAGE
              LoginScreenImage(context),
              const Spacer(),
              //LOGIN CONTAINER
              loginContainer(),
            ],
          ),
        ),
      ),
    );
  }

  //LOGIN CONTAINER
  Widget loginContainer() {
    return Container(
      decoration: BoxDecoration(
        color: white1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Log in",
                style: logintxt,
              ),
            ),
            //MOBILE NUMBER
            mobilenumberFiled(),
            //PASSWORD
            passwordField(),
            Row(
              children: [
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Forget_Mobile_Screen(isChangeMobileNo: false,)));
                    },
                    child: Text(
                      "Forgot Password",
                      style: fPassword,
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //CREATE ACCOUNT TEXT
            createAccountText(),

            //Login button
            loginButton(),
          ],
        ),
      ),
    );
  }

  //MOBILE NUMBER
  Widget mobilenumberFiled() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15),
      child: textFormField(
          // isEnabled: false,
          hintText: "Mobile Number",
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
              return 'Please Enter a Mobile Number';
            } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              return 'Please Enter a Valid 10-digit Mobile Number';
            }
            return null;
          }),
    );
  }

  //PASSWORD
  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: textFieldPassword(
        Controller: _passwordController,
        obscure: _obscurePassword,
        onPressed: _togglePasswordVisibility,
        hintText: "Password",
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
          return null;
        },
      ),
    );
  }

  //CREATE ACCOUNT TEXT
  Widget createAccountText() {
    return Center(
      child: InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginCreateaccount()));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Candidate_Create_Account(candidateProfileResponseData: null, isEdit: false,)));
        },
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'If you don’t have an account, click  ',
                style: richtext1,
              ),
              TextSpan(
                text: 'Create Account',
                style: richtext2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //LOGIN BUTTON
  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top:15, left: 50, bottom:40, right: 50),
      child: Center(
        child: CommonElevatedButton(
          context,
          "Login",
          () {
            _submitForm();
          },
        ),
      ),
    );
  }
}
