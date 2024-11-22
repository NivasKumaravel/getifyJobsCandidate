import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ApplyCampusJobModel.dart';
import 'package:getifyjobs/Models/DirectJobListModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Job_Details_Page.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';

import '../../../Common_Widgets/Common_List.dart';
import '../../../Common_Widgets/Custom_App_Bar.dart';
import '../../../utilits/Common_Colors.dart';

class Saved_Page extends ConsumerStatefulWidget {
  @override
  _Saved_PageState createState() => _Saved_PageState();
}

class _Saved_PageState extends ConsumerState<Saved_Page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    BookMarkListResponse();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  DirectJobListData? bookMarkListData;
  List<DirectJobItems> jobLists = []; // List to hold fetched job data
  List<DirectJobItems> tempjobLists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: [],
        isLogoUsed: true,
        title: "Saved Jobs",
        isTitleUsed: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _directList(bookMarkListData),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
  //BOOKMARK LIST RESPONSE
 BookMarkListResponse()async{
    final bookMarkListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "no_of_records":"10",
      "page_no":"1",
    });
    final bookMarkListApiResponse = await bookMarkListApiService.
    post<DirectJobListModel>(context, ConstantApi.bookMarkListUrl, formData);
    if(bookMarkListApiResponse?.status == true){
      setState(() {
        bookMarkListData = bookMarkListApiResponse?.data;
        jobLists
            .addAll(bookMarkListData?.items?.reversed.toList() ?? []);

        tempjobLists
            .addAll(bookMarkListData?.items?.reversed.toList() ?? []);
      });
    }else{
      ShowToastMessage(bookMarkListApiResponse?.message ?? "");
    }
 }

 //BOOKMARK LIST RESPONSE
  bookMarkApiResponse(String jobId, String recruiterId) async {
    final directJobListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "job_id": jobId,
      "recruiter_id": recruiterId
    });
    final bookMarkJobResponse =
    await directJobListApiService.post<ApplyCampusJobModel>(
        context, ConstantApi.bookmarkJobUrl, formData);

    if (bookMarkJobResponse.status == true) {
      print("SUCESS");
      ShowToastMessage(bookMarkJobResponse.message ?? "");
    } else {
      print("ERROR");
      ShowToastMessage(bookMarkJobResponse.message ?? "");
    }
  }
  Widget _directList(DirectJobListData? bookMarkListData) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookMarkListData?.items?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Job_Details(
                    jobId: bookMarkListData?.items?[index].jobId ?? "",
                    TagActive: '',
                    recruiterId: bookMarkListData?.items?[index].recruiterId ?? "",
                    isApplied: bookMarkListData?.items?[index].already_applied ?? false,
                    isInbox: bookMarkListData?.items?[index].bookmark ?? false,
                    isSavedNeeded: true),
              ),
            );
          },
          child: DirectList(context,
              isApplied: false,
              jobName: bookMarkListData?.items?[index].jobTitle ?? "",
              companyName: bookMarkListData?.items?[index].companyName ?? "",
              location: bookMarkListData?.items?[index].location ?? "",
              companyLogo: bookMarkListData?.items?[index].logo ?? "",
              YOP: bookMarkListData?.items?[index].experience ?? "",
              ExpSalary: '₹ ${bookMarkListData?.items?[index].salaryFrom ?? ""} - ${bookMarkListData?.items?[index].salaryTo ?? ""} Per Annum',
              postedDate: "Posted: ${bookMarkListData?.items?[index].createdDate ?? ""}",
              collegeName: '',
              appliedDate: '',
              collegeLoctaion: '',
              collegeLogo: '',
              isCampus: false,
              currentIndex: index,
              bookmarkClick: (value) {
                var dict = jobLists[value];

                dict.bookmark =
                dict.bookmark == true ? false : true;

                setState(() {
                  jobLists.removeAt(value);
                  jobLists.insert(value, dict);
                });

                bookMarkApiResponse(jobLists[value].jobId ?? '',
                    jobLists[index].recruiterId ?? '');
              },
              isStudent: true,
              bookmark: bookMarkListData?.items?[index].bookmark ?? false,
              campusTag: ''),
        );
      },
    );
  }
}


