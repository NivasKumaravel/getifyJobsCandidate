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
  List<DirectJobItems> bookMarkItems = [];

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
            _directList(),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  //BOOKMARK LIST RESPONSE
  BookMarkListResponse() async {
    final bookMarkListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "no_of_records": "10",
      "page_no": "1",
    });
    final bookMarkListApiResponse =
        await bookMarkListApiService.post<DirectJobListModel>(
            context, ConstantApi.bookMarkListUrl, formData);
    if (bookMarkListApiResponse?.status == true) {
      setState(() {
        bookMarkItems?.addAll(bookMarkListApiResponse.data?.items ?? []);
      });
    } else {
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

  Widget _directList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookMarkItems?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Job_Details(
                    jobId: bookMarkItems?[index].jobId ?? "",
                    TagActive: '',
                    recruiterId: bookMarkItems?[index].recruiterId ?? "",
                    isApplied: bookMarkItems?[index].already_applied ?? false,
                    isInbox: bookMarkItems?[index].bookmark ?? false,
                    isSavedNeeded: true),
              ),
            );
          },
          child: DirectList(context,
              isApplied: false,
              jobName: bookMarkItems?[index].jobTitle ?? "",
              companyName: bookMarkItems?[index].companyName ?? "",
              location: bookMarkItems?[index].location ?? "",
              companyLogo: bookMarkItems?[index].logo ?? "",
              YOP: bookMarkItems?[index].experience ?? "",
              ExpSalary:
                  '₹ ${bookMarkItems?[index].salaryFrom ?? ""} - ${bookMarkItems?[index].salaryTo ?? ""} Per Annum',
              postedDate: "Posted: ${bookMarkItems?[index].createdDate ?? ""}",
              collegeName: '',
              appliedDate: '',
              collegeLoctaion: '',
              collegeLogo: '',
              isCampus: false,
              currentIndex: index, bookmarkClick: (value) {
            bookMarkApiResponse(bookMarkItems?[index].jobId ?? '',
                bookMarkItems?[index].recruiterId ?? '');
            setState(() {
              bookMarkItems?.removeAt(index);
            });
          }, isStudent: true, bookmark: true, campusTag: ''),
        );
      },
    );
  }
}
