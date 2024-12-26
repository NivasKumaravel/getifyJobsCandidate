import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ApplyCampusJobModel.dart';
import 'package:getifyjobs/Models/StudentCampusMyAppliesListModel.dart';
import 'package:getifyjobs/Models/StudentDirectMyAppliesListModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Campus_Job_Detail_UI/Campus_Job_Detail_Page.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Job_Details_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:intl/intl.dart';

import '../../../../utilits/Common_Colors.dart';
import '../../../../utilits/Text_Style.dart';

class Student_MyApplies_Screen extends ConsumerStatefulWidget {
  @override
  _Student_MyApplies_ScreenState createState() =>
      _Student_MyApplies_ScreenState();
}

class _Student_MyApplies_ScreenState
    extends ConsumerState<Student_MyApplies_Screen>
    with SingleTickerProviderStateMixin {
  List<StudentDirectMyAppliesListData> DirectMyAppliesResponseData = [];
  List<StudentDirectMyAppliesListData> tempDirectMyAppliesResponseData = [];
  List<StudentCampusMyAppliesListData> CampusMyAppliesResponseData = [];
  List<StudentCampusMyAppliesListData> tempCampusMyAppliesResponseData = [];

  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController1 = ScrollController();
  TextEditingController _From = TextEditingController();
  TextEditingController _To = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _jobTitle = TextEditingController();
  TextEditingController _SalaryRange = TextEditingController();
  TextEditingController _CompanyName = TextEditingController();
  TextEditingController _careerStatus = TextEditingController();
  TextEditingController _CampusName = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  RegExp onlyText = RegExp(r'^[a-zA-Z ]+$');

  int totalCount = 10;
  int page = 1;

  int totalCount1 = 10;
  int page1 = 1;

  late TabController _tabController;

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_scrollListener);
    _scrollController1.addListener(_scrollListener1);

    DirectMyAppliesListResponse(
        JobT: '',
        location: '',
        Fdate: '',
        Tdate: '',
        ExpT: '',
        CompanyT: '',
        SalaryT: '',
        isFilter: false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _scrollController1.dispose();

    super.dispose();
  }

  _scrollListener() {
    print("object");
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        totalCount != DirectMyAppliesResponseData?.length) {
      // reached the bottom
      SingleTon().isLoading = false;
      page += 1;
      DirectMyAppliesListResponse(
          JobT: '',
          location: '',
          Fdate: '',
          Tdate: '',
          ExpT: '',
          CompanyT: '',
          SalaryT: '',
          isFilter: false);
    }
  }

  _scrollListener1() {
    print("object 23");
    // if (_scrollController.offset >=
    //         _scrollController.position.maxScrollExtent &&
    //     !_scrollController.position.outOfRange &&
    //     totalCount1 != CampusMyAppliesResponseData?.length) {
    //   // reached the bottom
    //   SingleTon().isLoading = false;
    //   page1 += 1;
    //   CampusMyAppliesListResponse(
    //       campusName: '', location: '', Fdate: '', Tdate: '', isFilter: false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: AppBar(
        toolbarHeight: 80,
        primary: true,
        leading: Transform.scale(
          scale: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 0),
            child: ImgPathSvg('logo.svg'),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: white2,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.black, // Navigation bar
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark // Status bar
            ),
        title: Text(
          '',
          style: LoginT,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // Adjust the height as needed
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
            child: textFormFieldSearchBar(
                keyboardtype: TextInputType.text,
                hintText: "Search ...",
                Controller: null,
                validating: null,
                onChanged: (value) {
                  setState(() {
                    if (tabIndex == 0) {
                      if (value != "") {
                        DirectMyAppliesResponseData =
                            tempDirectMyAppliesResponseData
                                .where((job) =>
                                    job.jobTitle!
                                        .toLowerCase()
                                        .contains(value) ||
                                    job.companyName!
                                        .toLowerCase()
                                        .contains(value))
                                .toList();
                        print(DirectMyAppliesResponseData?.length ?? 0);
                      } else {
                        DirectMyAppliesResponseData =
                            tempDirectMyAppliesResponseData;
                      }
                    } else {
                      if (value != "") {
                        CampusMyAppliesResponseData =
                            tempCampusMyAppliesResponseData
                                .where((job) =>
                                    job.jobTitle!
                                        .toLowerCase()
                                        .contains(value) ||
                                    job.companyName!
                                        .toLowerCase()
                                        .contains(value))
                                .toList();
                        print(DirectMyAppliesResponseData?.length ?? 0);
                      } else {
                        CampusMyAppliesResponseData =
                            tempCampusMyAppliesResponseData;
                      }
                    }
                  });
                },
                focusNode: _focusNode,
                isMultifilterNeeded: true,
                MultifilteronTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => InterviewSchedulePopup(
                        context,
                        isCampus: tabIndex == 0 ? false : true),
                  );
                }),
          ),
        ),
      ),
      body: InkWell(
        onTap: () {
          if (_focusNode.hasFocus) {
            _focusNode.unfocus();
          }
        },
        child: Container(
          // color: Colors.green,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                color: white1,
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: TabBar(
                  controller: _tabController,
                  labelColor: white1,
                  labelStyle: TabT,
                  indicator: BoxDecoration(color: blue1),
                  indicatorColor: grey4,
                  unselectedLabelColor: grey4,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (value) {
                    setState(() {
                      tabIndex = value;
                      if (tabIndex == 0) {
                        DirectMyAppliesResponseData = [];
                        tempDirectMyAppliesResponseData = [];
                        DirectMyAppliesListResponse(
                            JobT: '',
                            location: '',
                            Fdate: '',
                            Tdate: '',
                            ExpT: '',
                            CompanyT: '',
                            SalaryT: '',
                            isFilter: false);
                      } else {
                        CampusMyAppliesResponseData = [];
                        tempCampusMyAppliesResponseData = [];
                        CampusMyAppliesListResponse(
                            campusName: '',
                            location: '',
                            Fdate: '',
                            Tdate: '',
                            isFilter: false);
                      }
                    });
                  },
                  tabs: [
                    Container(
                      width: MediaQuery.of(context).size.width /
                          2, // Equal width for each tab
                      child: Tab(
                        text: 'Direct',
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width /
                          2, // Equal width for each tab
                      child: Tab(
                        text: 'Campus',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    DirectMyAppliesResponseData?.length == 0
                        ? Center(
                            child:
                                NoDataWidget(content: "Your Data is Loading"))
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                return _DirectList(DirectMyAppliesResponseData,
                                    _scrollController, totalCount, ref);
                              },
                            ),
                          ),
                    CampusMyAppliesResponseData?.length == 0
                        ? Center(
                            child:
                                NoDataWidget(content: "Your Data is Loading"))
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                return _campusList(CampusMyAppliesResponseData,
                                    _scrollController1, totalCount1, (value) {
                                  bookMarkApiResponse(
                                      CampusMyAppliesResponseData?[value]
                                              .jobId ??
                                          '',
                                      CampusMyAppliesResponseData?[value]
                                              .recruiterId ??
                                          '');
                                }, ref);
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CampusMyAppliesListResponse({
    required String campusName,
    required String location,
    required String Fdate,
    required String Tdate,
    required bool? isFilter,
  }) async {
    final campusMyAppliesListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "page_no": page1,
      "no_of_records": totalCount1,
      "campus_name": campusName,
      "location": location,
      "from_date": Fdate,
      "to_date": Tdate,
    });
    final campusMyAppliesResponseList = await campusMyAppliesListApiService
        .post<StudentCampusMyAppliesListModel>(
            context, ConstantApi.campusMyAppliesListUrl, formData);
    if (campusMyAppliesResponseList.status == true) {
      print('CAMPUS APPLIES LIST SUCCESS');
      setState(() {
        CampusMyAppliesResponseData.addAll(
            campusMyAppliesResponseList.data?.toList() ?? []);
        tempCampusMyAppliesResponseData
            .addAll(campusMyAppliesResponseList.data?.toList() ?? []);
        totalCount1 = campusMyAppliesResponseList.data?.length ?? 0;

        // print("CAMPUS ID : ${campusMyAppliesResponseList?.data?[0]?.jobId ?? ""}");
        // print("CAMPUS ID : ${campusMyAppliesResponseList?.data?[1]?.jobId ?? ""}");
        // print("CAMPUS ID : ${campusMyAppliesResponseList?.data?[2]?.jobId ?? ""}");
        // print("CAMPUS ID : ${campusMyAppliesResponseList?.data?[0]?.jobTitle ?? ""}");
        // print("CAMPUS ID : ${campusMyAppliesResponseList?.data?[1]?.jobTitle ?? ""}");
        // print("CAMPUS ID : ${campusMyAppliesResponseList?.data?[2]?.jobTitle ?? ""}");
        isFilter == true ? Navigator.pop(context) : null;
      });
    } else {
      page1--;
      ShowToastMessage(campusMyAppliesResponseList.message ?? "");
      print('CAMPUS APPLIES LIST ERROR');
    }
  }

  DirectMyAppliesListResponse({
    required String JobT,
    required String location,
    required String Fdate,
    required String Tdate,
    required String ExpT,
    required String CompanyT,
    required String SalaryT,
    required bool? isFilter,
  }) async {
    final directJobListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "page_no": page,
      "no_of_records": totalCount,
      "job_title": JobT,
      "location": location,
      "from_date": Fdate,
      "to_date": Tdate,
      "experience": ExpT,
      "company_name": CompanyT,
      "salary_from": SalaryT
    });
    final directMyAppliesResponseList =
        await directJobListApiService.post<StudentDirectMyAppliesListModel>(
            context, ConstantApi.directMyAppliesListUrl, formData);

    if (directMyAppliesResponseList.status == true) {
      print("DIRECT APPLIES LIST SUCCESS");
      setState(() {
        DirectMyAppliesResponseData.addAll(
            directMyAppliesResponseList.data?.toList() ?? []);
        tempDirectMyAppliesResponseData
            .addAll(directMyAppliesResponseList.data?.toList() ?? []);
        totalCount = directMyAppliesResponseList.data?.length ?? 0;

        // print("D JOB ID  :  ${directMyAppliesResponseList?.data?[0]?.jobId }");
        // print("D JOB ID  :  ${directMyAppliesResponseList?.data?[1]?.jobId }");
        // print("D JOB ID  :  ${directMyAppliesResponseList?.data?[2]?.jobId }");
        // print("D JOB ID  :  ${directMyAppliesResponseList?.data?[0]?.jobTitle }");
        // print("D JOB ID  :  ${directMyAppliesResponseList?.data?[1]?.jobTitle }");
        // print("D JOB ID  :  ${directMyAppliesResponseList?.data?[2]?.jobTitle }");
        // print("D JOB LENGTH  :  ${directMyAppliesResponseList?.data?.length}");
        isFilter == true ? Navigator.pop(context) : null;
      });
    } else {
      page--;
      ShowToastMessage(directMyAppliesResponseList?.message ?? "");
      print("DIRECT APPLIES LIST ERROR");
    }
  }

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

  Widget _campusList(
      List<StudentCampusMyAppliesListData>? campusMyAppliesResponseList,
      ScrollController scrollController,
      int totalCount,
      Function(int)? bookmarkClick,
      WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: campusMyAppliesResponseList?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if (index != (campusMyAppliesResponseList?.length ?? 0)) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Campus_JobDetail_Screen(
                              JobId:
                                  campusMyAppliesResponseList?[index]?.jobId ??
                                      "",
                              CampusId: campusMyAppliesResponseList?[index]
                                      ?.college
                                      ?.campusId ??
                                  "",
                              ReruiterId: campusMyAppliesResponseList?[index]
                                      ?.recruiterId ??
                                  "",
                              isApplied: false,
                              TagType: campusMyAppliesResponseList?[index]
                                      ?.jobStatus ??
                                  "",
                              interviewDate: campusMyAppliesResponseList?[index]
                                      ?.interviewdate ??
                                  "",
                              interviewTime: campusMyAppliesResponseList?[index]
                                      ?.interviewtime ??
                                  "",
                              CampusTagType: '',
                            )));
              },
              child: DirectList(
                context,
                isApplied: true,
                jobName: campusMyAppliesResponseList?[index].jobTitle ?? "",
                companyName:
                    campusMyAppliesResponseList?[index].companyName ?? "",
                location: campusMyAppliesResponseList?[index].location ?? "",
                companyLogo: campusMyAppliesResponseList?[index].logo ?? "",
                YOP: campusMyAppliesResponseList?[index]?.jobTitle ?? "",
                ExpSalary:
                    "₹ ${campusMyAppliesResponseList?[index]?.salaryFrom ?? " "} - ${campusMyAppliesResponseList?[index]?.salaryTo ?? " "} Per Annum",
                postedDate: '',
                collegeName:
                    campusMyAppliesResponseList?[index]?.college?.name ?? "",
                appliedDate:
                    campusMyAppliesResponseList?[index]?.appliedDate ?? "",
                collegeLoctaion:
                    campusMyAppliesResponseList?[index]?.college?.location ??
                        "",
                collegeLogo:
                    campusMyAppliesResponseList?[index]?.college?.logo ?? "",
                isCampus: true,
                currentIndex: index,
                bookmarkClick: (value) {},
                isStudent: false,
                bookmark: false,
                campusTag: campusMyAppliesResponseList?[index]?.jobStatus ?? "",
              ));
        } else {
          if ((campusMyAppliesResponseList?.length ?? 0) != 0 &&
              totalCount != (campusMyAppliesResponseList?.length ?? 0)) {
            return buildLoadingIndicator();
          }
        }
        // CampusList(isTag: "Applied", iscampTag: 'OnCampus',isUsed: true, onTap: () {  },
        //     jobName: 'Augmented Reality (AR) Journey Builder‍',
        //     companyLogo: 'companyLogo.png',
        //     companyName: 'Innova new Technology',
        //     collegeName: 'ABCD Arts and Science College',
        //     collegeLogo: 'companyLogo.png',
        //     companyLocation: 'Coimbatore, Tamil Nadu',
        //     collegeLocation: 'Coimbatore, Tamil Nadu'));
      },
    );
  }

  Widget _DirectList(
      List<StudentDirectMyAppliesListData>? directMyAppliesResponseData,
      ScrollController scrollController,
      int totalCount,
      WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: directMyAppliesResponseData?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if (index != (directMyAppliesResponseData?.length ?? 0)) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Job_Details(
                              jobId:
                                  directMyAppliesResponseData?[index]?.jobId ??
                                      "",
                              recruiterId: directMyAppliesResponseData?[index]
                                      ?.recruiterId ??
                                  "",
                              isApplied: true,
                              isInbox: false,
                              TagActive: directMyAppliesResponseData?[index]
                                      ?.jobStatus ??
                                  "",
                              isSavedNeeded: false,
                            ))).then((value) {
                  DirectMyAppliesResponseData = [];
                  tempCampusMyAppliesResponseData = [];
                  totalCount = 0;
                  ref.refresh(DirectMyAppliesListResponse(
                      JobT: '',
                      location: '',
                      Fdate: '',
                      Tdate: '',
                      ExpT: '',
                      CompanyT: '',
                      SalaryT: '',
                      isFilter: false));
                });
              },
              child: Candidate_MyApplies_List(context,
                  isApplied: false,
                  jobName: directMyAppliesResponseData?[index]?.jobTitle ?? "",
                  companyName:
                      directMyAppliesResponseData?[index]?.companyName ?? "",
                  location: directMyAppliesResponseData?[index]?.location ?? "",
                  companyLogo: directMyAppliesResponseData?[index]?.logo ?? "",
                  YOP: directMyAppliesResponseData?[index]?.experience ?? "",
                  ExpSalary:
                      '₹${directMyAppliesResponseData?[index]?.salaryFrom ?? ""} - ${directMyAppliesResponseData?[index]?.salaryTo ?? ""} Per Annum',
                  postedDate: 'Posted: 23 Sep 2023',
                  collegeName: "",
                  appliedDate:
                      directMyAppliesResponseData?[index]?.appliedDate ?? "",
                  status:
                      directMyAppliesResponseData?[index]?.jobStatus ?? ""));
        } else {
          if ((directMyAppliesResponseData?.length ?? 0) != 0 &&
              totalCount != (directMyAppliesResponseData?.length ?? 0)) {
            return buildLoadingIndicator();
          }
        }
      },
    );
  }

  Widget InterviewSchedulePopup(BuildContext context,
      {required bool isCampus}) {
    return Container(
      child: AlertDialog(
        surfaceTintColor: white1,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Multiple selection of ${isCampus == true ? "campus name, location etc" : "Job title, Location, Salary etc"}",
              style: Wbalck1,
              textAlign: TextAlign.center,
            ),
            isCampus == true
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: textFormField(
                      hintText: 'Campus Name',
                      keyboardtype: TextInputType.text,
                      inputFormatters: null,
                      Controller: _CampusName,
                      focusNode: null,
                      validating: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Campus Name";
                        } else if (!onlyText.hasMatch(value)) {
                          return "(Special Characters are Not Allowed)";
                        }
                        return null;
                      },
                      onChanged: null,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: textFormField(
                      hintText: 'Job Title',
                      keyboardtype: TextInputType.text,
                      inputFormatters: null,
                      Controller: _jobTitle,
                      focusNode: null,
                      validating: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Job Title";
                        } else if (!onlyText.hasMatch(value)) {
                          return "(Special Characters are Not Allowed)";
                        }
                        return null;
                      },
                      onChanged: null,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: textFormField(
                hintText: 'Location',
                keyboardtype: TextInputType.text,
                inputFormatters: null,
                Controller: _location,
                focusNode: null,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Location";
                  } else if (!onlyText.hasMatch(value)) {
                    return "(Special Characters are Not Allowed)";
                  }
                  return null;
                },
                onChanged: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width / 3,
                    child: TextFieldDatePicker(
                        Controller: _From,
                        onChanged: (value) {},
                        validating: (value) {
                          if (value!.isEmpty) {
                            return 'Please select  Date';
                          } else {
                            return null;
                          }
                        },
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          DateTime? pickdate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1980),
                              lastDate: DateTime(2050));
                          if (pickdate != null) {
                            String formatdate =
                                DateFormat("yyyy-MM-dd").format(pickdate!);
                            if (mounted) {
                              setState(() {
                                _From.text = formatdate;
                                print(_From.text);
                              });
                            }
                          }
                        },
                        hintText: 'Form',
                        isDownArrow: false),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 3.1,
                    child: TextFieldDatePicker(
                        Controller: _To,
                        onChanged: (value) {},
                        validating: (value) {
                          if (value!.isEmpty) {
                            return 'Please select  Date';
                          } else {
                            return null;
                          }
                        },
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          DateTime? pickdate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1980),
                              lastDate: DateTime(2050));
                          if (pickdate != null) {
                            String formatdate =
                                DateFormat("yyyy-MM-dd").format(pickdate!);
                            if (mounted) {
                              setState(() {
                                _To.text = formatdate;
                                print(_To.text);
                              });
                            }
                          }
                        },
                        hintText: 'To',
                        isDownArrow: false),
                  ),
                ],
              ),
            ),
            isCampus == true
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: textFormField(
                      hintText: 'Expected Salary',
                      keyboardtype: TextInputType.text,
                      inputFormatters: null,
                      Controller: _SalaryRange,
                      focusNode: null,
                      validating: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Salary";
                        } else {
                          return "Please Enter Valid Salary";
                        }
                      },
                      onChanged: null,
                    ),
                  ),
            isCampus == true
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: textFormField(
                      hintText: 'Career Status',
                      keyboardtype: TextInputType.text,
                      inputFormatters: null,
                      Controller: _careerStatus,
                      focusNode: null,
                      validating: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter CareerStatus";
                        } else if (!onlyText.hasMatch(value)) {
                          return "(Special Characters are Not Allowed)";
                        }
                        return null;
                      },
                      onChanged: null,
                    ),
                  ),
            isCampus == true
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: textFormField(
                      hintText: 'Company Name',
                      keyboardtype: TextInputType.text,
                      inputFormatters: null,
                      Controller: _CompanyName,
                      focusNode: null,
                      validating: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Company Name";
                        } else if (!onlyText.hasMatch(value)) {
                          return "(Special Characters are Not Allowed)";
                        }
                        return null;
                      },
                      onChanged: null,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Cancel", () {
                        _CampusName.clear();
                        _jobTitle.clear();
                        _location.clear();
                        _From.clear();
                        _To.clear();
                        _CompanyName.clear();
                        _SalaryRange.clear();
                        Navigator.pop(context);
                      })),
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Okay", () {
                        DirectMyAppliesResponseData = [];
                        tempCampusMyAppliesResponseData = [];
                        totalCount = 0;
                        isCampus == false
                            ? DirectMyAppliesListResponse(
                                JobT: _jobTitle.text,
                                location: _location.text,
                                Fdate: _From.text,
                                Tdate: _To.text,
                                ExpT: _careerStatus.text,
                                CompanyT: _CompanyName.text,
                                isFilter: true,
                                SalaryT: _SalaryRange.text)
                            : CampusMyAppliesListResponse(
                                location: _location.text,
                                Fdate: _From.text,
                                Tdate: _To.text,
                                isFilter: true,
                                campusName: _CampusName.text);
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
