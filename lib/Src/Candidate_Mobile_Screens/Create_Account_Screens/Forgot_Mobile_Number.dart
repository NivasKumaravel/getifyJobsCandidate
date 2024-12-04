import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getifyjobs/Models/ForgotMobileNumberModel.dart';
import 'package:getifyjobs/Models/LoginModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Candidate_Category_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Candidate_Create_Account_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Forgot_Mobile_Number.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Otp_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/Otp_Verification_Page.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/UpdateMobile_Otp_Verification_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Forget_Mobile_Screen extends ConsumerStatefulWidget {
  final bool isChangeMobileNo;
  const Forget_Mobile_Screen({super.key,required this.isChangeMobileNo});

  @override
  ConsumerState<Forget_Mobile_Screen> createState() => _Login_PageState();
}

class _Login_PageState extends ConsumerState<Forget_Mobile_Screen> {
  TextEditingController _mobileController = TextEditingController();


  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _mobileNumber = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      // appBar: Custom_AppBar(
      //   title: "",
      //   isUsed: true,
      //   actions: [],
      //   isLogoUsed: true,
      //   isTitleUsed: true,
      // ),
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
          width: MediaQuery.sizeOf(context).height,
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
              //GETIFY LOGO
              Center(child: Logo(context)),
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
      height: MediaQuery.of(context).size.height/1.5,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 20, right: 20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Enter New Mobile Number",
                style: logintxt,
              ),
            ),
            //MOBILE NUMBER
            mobilenumberFiled(),

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

  //LOGIN BUTTON
  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top:15, left: 50, bottom:40, right: 50),
      child: Center(
        child: CommonElevatedButton(
          context,
          "Next",
              () {
            if(_formKey.currentState!.validate()){
              Mobile_Response();
            }
            },
        ),
      ),
    );
  }

  //MOBILE RESPONSE
 Mobile_Response() async{
    final mobileApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id":await getcandidateId(),
      "phone":_mobileController.text,
    });
    final mobileApiRepsonse = await mobileApiService.post<ForgotMobileNumber>(context,
       widget.isChangeMobileNo == true?ConstantApi.changeMobileNoUrl:ConstantApi.forgotMobileUrl, formData);
    if(mobileApiRepsonse?.status == true){
      CandidateId(mobileApiRepsonse.data?.candidateId ?? "");
      ShowToastMessage(mobileApiRepsonse.message ?? "");
      widget.isChangeMobileNo != true?  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Otp_Verification_Page(
                  isForget: true, mobileNumber: _mobileNumber,))):
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdateMobile_Otp_Verification_Page(
                   mobileNumber: _mobileNumber,)));

    }else{
      ShowToastMessage(mobileApiRepsonse.message ?? "");
    }
 }
}
