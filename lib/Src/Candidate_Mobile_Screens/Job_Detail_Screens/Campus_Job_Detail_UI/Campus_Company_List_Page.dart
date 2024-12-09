import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getifyjobs/Models/CampusCompanyListModel.dart';
import 'package:getifyjobs/Models/CandidateProfileModel.dart';
import 'package:getifyjobs/Models/GetPaymentIdModel.dart';
import 'package:getifyjobs/Models/PaymentSuccessModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../Common_Widgets/Common_List.dart';
import 'Campus_Company_Job_List_Page.dart';

class Campus_Company_List_Page extends ConsumerStatefulWidget {
  String? CampusId;

  Campus_Company_List_Page({super.key, required this.CampusId});

  @override
  _Campus_Company_List_PageState createState() =>
      _Campus_Company_List_PageState();
}

class _Campus_Company_List_PageState
    extends ConsumerState<Campus_Company_List_Page> {

  bool isClicked = true;
  canidateProfileData? Candiatedata;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CandidateProfileResponse();
      CampusCompanyListResponse();
      GetPaymentResponse();
    });


  }
  final FocusNode _focusNode = FocusNode();

  CampusCompanyListData? CampusCompanyResponseData;
  GetPaymentData? getPaymentResponseData;
  List<Recruiters>? CampusRecruitersResponseData;

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
        body: CampusCompanyResponseData?.items?.recruiters == null
            ? NoDataWidget(content: "No Data Available")
            : SingleChildScrollView(
                child: MainBody(),
              ));
  }

  Widget MainBody() {
    return InkWell(
      onTap: (){
        if(_focusNode.hasFocus){
          _focusNode.unfocus();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: textFormFieldSearchBar(
              keyboardtype: TextInputType.text,
              hintText: "Search ...",
              Controller: null,
              validating: null,
              onChanged: null, focusNode: _focusNode,
            ),
          ),
          CampusList(
            context,
              isTag: CampusCompanyResponseData?.items?.type ?? "",
              iscampTag: CampusCompanyResponseData?.items?.type ?? "",
              isUsed: false,
              onTap: () {},
              jobName: '',
              companyLogo: '',
              companyName: '',
              collegeName: CampusCompanyResponseData?.items?.name ?? "",
              collegeLogo: CampusCompanyResponseData?.items?.logo ?? "",
              companyLocation: '',
              collegeLocation: CampusCompanyResponseData?.items?.location ?? "", applyCount: '${CampusCompanyResponseData?.items?.appliedCount ?? 0}', isCountNeeded: true),
          dateTime(
              time:
                  'Date: 09:00AM, ${CampusCompanyResponseData?.items?.recruitmentDate ?? ""}'),
          CampusCompanyResponseData?.items?.type == "Off campus"?
          _paidContainer(context, isPayed: CampusCompanyResponseData?.items?.payment ?? false):Container(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: JobDetail_Campus_List(CampusCompanyResponseData),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paidContainer(context, {required bool? isPayed}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
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
            InkWell(
                    onTap:
                    isPayed == true?null:() async{
                      int amountInRupees = CampusCompanyResponseData?.items?.fees ?? 0;
                      int amountInPaisa = amountInRupees * 100;
                      Razorpay razorpay = Razorpay();
                      var options = {
                        'key':"rzp_live_6KHrAGkAbjJClU",
                        'amount': amountInPaisa,
                        'name': CampusCompanyResponseData?.items?.name ?? "",
                        'description': 'To Attend campus, this is one time payment & you can Apply for multiple job in this Campus',
                        'retry': {'enabled': true, 'max_count': 1},
                        'send_sms_hash': true,
                        'prefill': {
                          'contact': "+91 ${Candiatedata?.phone}",
                          'email': "${Candiatedata?.email ?? ""}"
                        },
                        'external': {
                          'wallets': ['paytm']
                        }
                      };

                      print('PAYMENT REQUEST ${options}');
                      razorpay.on(
                          Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                          handlePaymentSuccessResponse);
                      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                          handleExternalWalletSelected);
                      razorpay.open(options);
                      },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: isPayed != true ? blue1 : green1,
                        ),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                            child: Text(
                              isPayed != true ? "Pay ₹${CampusCompanyResponseData?.items?.fees ?? 0}" : "Paid ₹${CampusCompanyResponseData?.items?.fees ?? 0}",
                          style: priceT,
                        )),
                      ),
                    ),
                  ),
            CampusCompanyResponseData?.items?.payment == true
                ? Container()
                : Text(
                    "To Attend campus, this is one time payment & you can Apply for multiple job in this Campus",
                    style: payT,
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }

  CampusCompanyListResponse() async {
    final campusCompanyListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "campus_id": widget.CampusId,
      "no_of_records": "10",
      "page_no": "1"
    });
    final campusResponseCompanyList =
        await campusCompanyListApiService.post<CampusCompanyListModel>(
            context, ConstantApi.campusCompanyListUrl, formData);
    if (campusResponseCompanyList.status == true) {
      print("RESPONSE ANSWER: ${campusResponseCompanyList.data?.items?.name}");
      setState(() {
        CampusCompanyResponseData = campusResponseCompanyList?.data;
        print(
            "RESPONSE ANSWER: ${campusResponseCompanyList.data?.items?.name}");
      });
    } else {
      ShowToastMessage(campusResponseCompanyList.message ?? "");
      print('ERROR');
    }
  }

  //PAYMENT RESPONSE
  GetPaymentResponse() async {
    final paymentApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "key": '7O2ho2MrvgFODp3j18BMSBt1BJWETW1t',
    });
    final paymentApiResponse =
    await paymentApiService.post<GetPaymentIdModel>(
        context, ConstantApi.getPaymentUrl, formData);
    if (paymentApiResponse.status == true) {

      setState(() {
        getPaymentResponseData = paymentApiResponse?.data;
      });
      print('GET PAYMENT SUCCESS');
    } else {
      ShowToastMessage(paymentApiResponse.message ?? "");
      print('GET PAYMENT ERROR');
    }
  }
  //PAYMENT SUCCESS
  PaymentSucessResponse({required String transactionId,required String Data}) async{
    final paymentResponse = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "campus_id": widget.CampusId,
      'amount':"${CampusCompanyResponseData?.items?.fees ?? 0}",
      "transaction_id":transactionId,
      "payment_data":Data,
    });
    final paymentApiResponse = await paymentResponse.post<PaymentSuccessModel>(context, ConstantApi.paymentSuccessUrl, formData);
    if(paymentApiResponse?.status == true){
      print("PAYMENT DONE");
      CampusCompanyListResponse();
      ShowToastMessage(paymentApiResponse.message ?? "");
    }else{
      print("PAYMENT NOT DONE");
      ShowToastMessage(paymentApiResponse.message ?? "");
    }
  }

  CandidateProfileResponse() async {
    final candidateProfileApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap(
        {"candidate_id": await getcandidateId()});
    final profileResponseJobDetails =
    await candidateProfileApiService.post<CandidateProfileModel>(
        context, ConstantApi.candidateProfileUrl, formData);
    if (profileResponseJobDetails.status == true) {
      setState(() {
        Candiatedata = profileResponseJobDetails?.data;
        print("RESPONSE : ${profileResponseJobDetails.data}");

      });

    } else {
      ShowToastMessage(profileResponseJobDetails.message ?? "");
      print('ERROR');
    }
  }
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print("PAYMENT RESPONSE ::: ${response.data.toString()}");
    setState(() {
      isClicked = false;
    });
    PaymentSucessResponse(transactionId: response?.paymentId ?? "", Data: response.data.toString(), );
    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {

      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

//JOBDETAILS LIST
Widget JobDetail_Campus_List(CampusCompanyListData? campusCompanyResponseData) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: campusCompanyResponseData?.items?.recruiters?.length ?? 0,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Campus_Company_Job_List(
                        CampusId: campusCompanyResponseData?.items?.campusId,
                        RecruiterId: campusCompanyResponseData
                                ?.items?.recruiters?[index].recruiterId ??
                            "", campusTagType: campusCompanyResponseData?.items?.type ?? "",
                      )));
        },
        child: Container(
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white, // Set the color here
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: buildCompanyInfoRow(
                        campusCompanyResponseData
                                ?.items?.recruiters?[index].logo ??
                            "",
                        campusCompanyResponseData
                                ?.items?.recruiters?[index].companyName ??
                            "",
                        TBlack,
                        50,
                        50,
                        isMapLogo: false),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 10, right: 20,),
                      child: buildCompanyInfoRow(
                          "map-pin (1).png",
                          campusCompanyResponseData
                                  ?.items?.recruiters?[index].location ??
                              "",
                          Homegrey2,
                          20,
                          20,
                          isMapLogo: true)),

                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10,bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.person,color: blue1,),
                      Text("${campusCompanyResponseData?.items?.recruiters?[index].appliedCandidate ?? 0}",style: TBlack,),
                    ],
                  ),
                ),

                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
