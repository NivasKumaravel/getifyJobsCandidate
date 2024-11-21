import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../Models/CampusJobListModel.dart';
import 'Campus_Job_Detail_Page.dart';

class Campus_Company_Job_List extends ConsumerStatefulWidget {
  String? RecruiterId;
  String? CampusId;
  String? campusTagType;
   Campus_Company_Job_List({super.key,required this.CampusId,required this.RecruiterId,required this.campusTagType});

  @override
  _Campus_Company_Job_ListState createState() =>
      _Campus_Company_Job_ListState();
}

class _Campus_Company_Job_ListState extends  ConsumerState<Campus_Company_Job_List> {
  CampusJobListData? CampusJobListResponseData;
  final FocusNode _focusNode = FocusNode();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CampusJobListResponse();
    });
  }

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
        body: CampusJobListResponseData?.items?.jobs == null
            ?NoDataWidget(content: "No Data Available")
            :SingleChildScrollView(child: MainBody(),)
    );

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
            padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
            child: textFormFieldSearchBar(
              keyboardtype: TextInputType.text,
              hintText: "Search ...",
              Controller: null,
              validating: null,
              onChanged: null, focusNode:_focusNode ,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15,left: 20,right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white, // Set the color here
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    buildCompanyInfoRow(CampusJobListResponseData?.items?.jobs?[0].logo ?? "",
                        CampusJobListResponseData?.items?.jobs?[0].companyName  ?? "", TBlack, 50, 50, isMapLogo: false),

                    Padding(
                      padding: const EdgeInsets.only(left: 30,bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 20,width: 20,
                              child: ImgPathPng("map-pin (1).png")),
                          const SizedBox(width: 40),
                          Expanded(child: Container(child: Text(CampusJobListResponseData?.items?.jobs?[0].location ?? "",style: Wgrey,maxLines: 2,))),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          dateTime(time: 'Date: 09:00 AM, ${CampusJobListResponseData?.items?.recruitmentDate ?? ""}'),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: buildCompanyInfoRow(
                CampusJobListResponseData?.items?.logo ?? "",  CampusJobListResponseData?.items?.name ?? "", TBlack, 50, 50, isMapLogo: false),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Company_Job_List(context,CampusJobListResponseData, RecruiterId: widget.RecruiterId.toString()),
            ),
          ),
        ],
      ),
    );
  }
  CampusJobListResponse() async {
    final campusJobListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
           "candidate_id": await getcandidateId(),
            "recruiter_id":widget.RecruiterId,
            "campus_id": widget.CampusId,
            "page_no": "1",
            "no_of_records": "10"
    }
    );
    final campusResponseJobList =
    await campusJobListApiService.post<CampusJobListModel>(
        context, ConstantApi.campusjoblistUrl, formData);
    if (campusResponseJobList.status == true) {
      setState(() {
        CampusJobListResponseData = campusResponseJobList?.data;
        print("RESPONSE : ${campusResponseJobList.data}");
      });
    } else {
      ShowToastMessage(campusResponseJobList.message ?? "");
      print('ERROR');
    }
  }
  Widget Company_Job_List(context, CampusJobListData? campusJobListResponseData,{required String RecruiterId}) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: campusJobListResponseData?.items?.jobs?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Campus_JobDetail_Screen(
                      JobId: campusJobListResponseData?.items?.jobs?[index].jobId ?? "",
                      CampusId:campusJobListResponseData?.items?.campusId ?? "",
                      ReruiterId:RecruiterId, isApplied: campusJobListResponseData?.items?.jobs?[index].already_applied == true?false:true,
                      TagType: '',
                      interviewDate: '',
                      interviewTime: '', CampusTagType: widget.campusTagType,))).then((value) => ref.refresh(CampusJobListResponse()));

          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: white1),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //JOB ROLE
                    Container(
                        margin: EdgeInsets.only(bottom: 15, top: 10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          campusJobListResponseData?.items?.jobs?[index].jobTitle ?? "",
                          style: TBlue,
                        )),
                    //JOB FOR WHICH YEAR
                    Row(
                      children: [
                        ImgPathSvg('job.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Everyone",
                          style: durationT,
                        ),
                      ],
                    ),
                    //POSTED DATE

                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,width: 20,
                              child: ImgPathPng("map-pin (1).png")),
                          const SizedBox(width: 6),
                          Expanded(child: Container(child: Text(campusJobListResponseData?.items?.jobs?[index].location ?? "",style: Homegrey2,maxLines: 2,))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}

