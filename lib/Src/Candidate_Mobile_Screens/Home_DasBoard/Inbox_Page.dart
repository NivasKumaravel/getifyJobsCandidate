import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getifyjobs/Models/InboxModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Home_DasBoard/Profile_Ui/Inbox_Lists.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Job_Details_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Inbox_Page extends ConsumerStatefulWidget {
  const Inbox_Page({super.key});
  @override
  ConsumerState<Inbox_Page> createState() => _Inbox_PageState();
}

class _Inbox_PageState extends ConsumerState<Inbox_Page> {
  InboxModel? inboxMessageList;
  String Status = "all";

  inboxListResponse() async {
    final directJobListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "status": 'all',
      "page_no": "1",
      "no_of_records": "10"
    });
    final inboxResponseList = await directJobListApiService.post<InboxModel>(
        context, ConstantApi.inboxUrl, formData);

    if (inboxResponseList.status == true) {
      print("SUCESS");
      setState(() {
        inboxMessageList = inboxResponseList;

        // if (Status == "9") {
        //   if ((inboxMessageList?.data?.items?.length ?? 0) > 0) {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Inbox_lists(
        //                   title: 'Selected List',
        //                   inboxList: inboxMessageList?.data?.items,
        //                 )));
        //   }
        // } else if (Status == "5") {
        //   if ((inboxMessageList?.data?.items?.length ?? 0) > 0) {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Inbox_lists(
        //                   title: 'Scheduled List',
        //                   inboxList: inboxMessageList?.data?.items,
        //                 )));
        //   }
        // }
      });
    } else {
      print("ERROR");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {});

    inboxListResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: false,
        actions: [],
        isLogoUsed: false,
        isTitleUsed: true,
        title: "",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Inbox_lists(
                                title: 'Scheduled Jobs',
                              )));

                    },
                    child: cards(
                      context,
                        countTxt:
                            "${inboxMessageList?.data?.count?.accepted ?? "0"}",
                        txt: "Scheduled",
                        Ccolor: blue2,
                        txtStyle: ScheduleTxt),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Inbox_lists(
                                title: 'Selected Jobs',
                              )));
                    },
                    child: cards(
                      context,
                        countTxt:
                            "${inboxMessageList?.data?.count?.selected ?? "0"}",
                        txt: "Selected",
                        Ccolor: green2,
                        txtStyle: SelectTxt),
                  )
                ],
              ),
            ),
            // SizedBox(height: 20,),

            Container(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _InboxList(context,
                    inboxMessageList: inboxMessageList?.data?.items ?? []),
              ),
            ),
            // SizedBox(height: 50,),
          ],
        ),
      ),
      // body: Container(
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //     children: [
      //       Container(
      //         color: white1,
      //         width: MediaQuery.of(context).size.width,
      //         height: 50,
      //         child: TabBar(
      //           controller: _tabController,
      //           labelColor: white1,
      //           labelStyle: TabT,
      //           indicator: BoxDecoration(
      //               color: blue1
      //           ),
      //           indicatorColor: grey4,
      //           unselectedLabelColor: grey4,
      //           indicatorPadding: EdgeInsets.zero,
      //           indicatorSize: TabBarIndicatorSize.tab,
      //           tabs: [
      //             Container(
      //               width: MediaQuery.of(context).size.width / 2, // Equal width for each tab
      //               child: Tab(
      //                 text: "Scheduled  ${"(10)"}",
      //               ),
      //             ),
      //             Container(
      //               width: MediaQuery.of(context).size.width / 2, // Equal width for each tab
      //               child: Tab(
      //                 text: 'Selected',
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //       ),
      //       Expanded(
      //         child: TabBarView(
      //           controller: _tabController,
      //           children: [
      //             _InboxList(
      //                 context,
      //                 companyname: "Innova new Technology",
      //                 companylogo: "companyLogo.png",
      //                 location: "Coimbatore, Tamil Nadu"),
      //             _InboxList(
      //                 context,
      //                 companyname: "Innova new Technology",
      //                 companylogo: "companyLogo.png",
      //                 location: "Coimbatore, Tamil Nadu"),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _InboxList(context, {required List<Items> inboxMessageList}) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: inboxMessageList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Job_Details(
                    jobId: inboxMessageList[index].jobId ?? "",
                    recruiterId: '',
                  isApplied: true,
                  isInbox: true,
                  TagActive: inboxMessageList[index].jobStatus ?? "", isSavedNeeded: false,))).then((value) => ref.refresh(inboxListResponse()));
              },
              child:
              Inbox_List(
                  context,
                  CompanyLogo: inboxMessageList[index].logo ?? "",
                  CompanyName: inboxMessageList[index].companyName ?? "",
                  jobTitle: inboxMessageList[index].jobTitle ?? "",
                  Location: inboxMessageList[index].location ?? "",
                  status: inboxMessageList[index].jobStatus ?? "",),
            ),
          );
        });
  }
}
