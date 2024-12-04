import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/NotificationModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';


class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  List<NotificationData>? NotificationResponseData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationApiResponse();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_AppBar(
        isUsed: false,
        actions: [],
        isLogoUsed: true,
        title: 'Notification',
        isTitleUsed: true,
      ),
      backgroundColor: white2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20,left: 20,top: 5,bottom: 30),
              child:_Notification_List() ,
            )
          ],
        ),
      ),
    );
  }
  //NOTIFICATION LIST
 NotificationApiResponse() async{
    final notificationApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
    });
    final notificationApiResponse = await notificationApiService.post<NotificationModel>
      (context, ConstantApi.notificationUrl, formData);

    if(notificationApiResponse?.status ==true){
      setState(() {
        NotificationResponseData = notificationApiResponse?.data;
      });
    }else{
      ShowToastMessage(notificationApiResponse?.message ?? "");
    }
 }

 Widget _Notification_List(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: NotificationResponseData?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        String postedOn = NotificationResponseData?[index].postedOn ?? "";
        List<String> parts = postedOn.split(' @ ');

        String datePart = parts[0];
        String timePart = parts[1];

        return Container(
            width: MediaQuery.of(context).size.width,
            child:buildCompanyInfoRowNotifacation(
                context,
                jobName: NotificationResponseData?[index].notification ?? "",
                name: NotificationResponseData?[index].companyName ?? "", Date: datePart, Time: '',
                )
          // Text("data")
        );
      },);
 }
}
