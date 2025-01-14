import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/InboxModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Job_Details_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';

class Inbox_lists extends ConsumerStatefulWidget {
  final String title;
  const Inbox_lists({super.key, required this.title});

  @override
  ConsumerState<Inbox_lists> createState() => _Inbox_listsState();
}

class _Inbox_listsState extends ConsumerState<Inbox_lists> {
  late String titleText;
  InboxData? scheduleResponseData;

  ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  int totalCount = 0;

  bool _isLoadingMore = false; // List to hold fetched job data

  @override
  void initState() {
    super.initState();
    titleText = widget.title;
    _scrollController.addListener(_scrollListener);

    inboxListResponse();
  }

  void _scrollListener() {
    if (!_isLoadingMore &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        totalCount != scheduleResponseData?.items?.length) {
      SingleTon().isLoading = false;
      _currentPage += 1;

      inboxListResponse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        title: titleText,
        isUsed: true,
        actions: [],
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _ScheduedInboxList(context),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget _ScheduedInboxList(context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: scheduleResponseData?.items?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Job_Details(
                              jobId:
                                  scheduleResponseData?.items?[index].jobId ??
                                      "",
                              recruiterId: '',
                              isApplied: true,
                              isInbox: true,
                              TagActive: scheduleResponseData
                                      ?.items?[index].jobStatus ??
                                  "",
                              isSavedNeeded: false,
                            )));
              },
              child: Inbox_List(
                context,
                CompanyLogo: scheduleResponseData?.items?[index].logo ?? "",
                CompanyName:
                    scheduleResponseData?.items?[index].companyName ?? "",
                jobTitle: scheduleResponseData?.items?[index].jobTitle ?? "",
                Location: scheduleResponseData?.items?[index].location ?? "",
                status: scheduleResponseData?.items?[index].jobStatus ?? "",
              ),
            ),
          );
        });
  }

  inboxListResponse() async {
    final directJobListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "status": widget.title == "Scheduled Jobs" ? 5 : 9,
      "page_no": _currentPage,
      "no_of_records": "10"
    });
    print("CANDIDATE ID :  ${await getcandidateId()}");
    final inboxResponseList = await directJobListApiService.post<InboxModel>(
        context, ConstantApi.inboxUrl, formData);

    if (inboxResponseList.status == true) {
      print("SUCESS");
      setState(() {
        totalCount = inboxResponseList.data?.count?.selected ?? 0;
        scheduleResponseData?.items
            ?.addAll(inboxResponseList.data?.items ?? []);
      });
    } else {
      print("ERROR");
    }
  }
}

Widget _scheduledList(List<Items> inboxlist) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: inboxlist.length,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
          onTap: () {},
          child: Candidate_MyApplies_List(context,
              isApplied: false,
              jobName: "Augmented Reality (AR) Journey Builder‍",
              companyName: "Innova new Technology",
              location: "Coimbatore, Tamil Nadu",
              companyLogo: "companyLogo.png",
              YOP: '3-5 Years Experience',
              ExpSalary: '₹ 3.5 - 5 LPA',
              postedDate: 'Posted: 23 Sep 2023',
              collegeName: '',
              appliedDate: ' 23 Sep 2023',
              status: ''));
    },
  );
}
