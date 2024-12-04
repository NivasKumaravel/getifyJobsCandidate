import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ApplyCampusJobModel.dart';
import 'package:getifyjobs/Models/CampusListModel.dart';
import 'package:getifyjobs/Models/DirectJobListModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Home_DasBoard/Profile_Ui/Saved_Page.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Campus_Job_Detail_UI/Campus_Company_List_Page.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Job_Details_Page.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Notification_Ui/Notification_Screen.dart';
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

class Student_Home_Screen extends ConsumerStatefulWidget {
  @override
  _Student_Home_ScreenState createState() => _Student_Home_ScreenState();
}

class _Student_Home_ScreenState extends ConsumerState<Student_Home_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_scrollListener);
    _scrollController1.addListener(_scrollListener1);

    directJobListResponse(
        JobT: '',
        location: '',
        Fdate: '',
        Tdate: '',
        ExpT: '',
        CompanyT: '',
        isFilter: false,
        SalaryT: '');
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
        totalCount != directResponseData?.length) {
      // reached the bottom
      SingleTon().isLoading = false;
      page += 1;
      directJobListResponse(
          JobT: '',
          location: '',
          Fdate: '',
          Tdate: '',
          ExpT: '',
          CompanyT: '',
          isFilter: false,
          SalaryT: '');
    }
  }

  _scrollListener1() {
    print("object 23");
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        totalCount1 != campusResponseData?.length) {
      // reached the bottom
      SingleTon().isLoading = false;
      page1 += 1;
      campusListResponse(
          location: '', Fdate: '', Tdate: '', isFilter: false, campusName: '');
    }
  }

  List<CampusListItems> campusResponseData = [];
  List<DirectJobItems> directResponseData = [];

  List<CampusListItems> tempCampusResponseData = [];
  List<DirectJobItems> tempDirectResponseData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: AppBar(
        toolbarHeight: 80,
        primary: true,
        automaticallyImplyLeading: false,
        backgroundColor: white2,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.black, // Navigation bar
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark // Status bar
            ),
        leading: Transform.scale(
          scale: 3.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 0),
            child: ImgPathSvg('logo.svg'),
          ),
        ),
        // title: Text(
        //   "My Applies",
        //   style: LoginT,
        // ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Saved_Page()))
                  .then((value) {
                directResponseData = [];
                tempDirectResponseData = [];
                ref.refresh(directJobListResponse(
                    JobT: '',
                    location: '',
                    Fdate: '',
                    Tdate: '',
                    ExpT: '',
                    CompanyT: '',
                    isFilter: false,
                    SalaryT: ''));
              });
            },
            child: Container(
                margin: EdgeInsets.only(right: 15),
                child: ImgPathSvg("tag.svg")),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
                },
                child: ImgPathSvg("bell.svg")),
          ),
        ],
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
                    value = value.toLowerCase();
                    if (value != "") {
                      if (tabIndex == 0) {
                        directResponseData = [];
                        tempDirectResponseData = [];
                        directResponseData = tempDirectResponseData
                            .where((job) =>
                                job.jobTitle!.toLowerCase().contains(value) ||
                                job.name!.toLowerCase().contains(value))
                            .toList();
                        print(directResponseData.length ?? 0);
                      } else {
                        campusResponseData = [];
                        tempCampusResponseData = [];
                        campusResponseData = tempCampusResponseData
                            .where((job) =>
                                job.name!.toLowerCase().contains(value))
                            .toList();
                        print(campusResponseData.length);
                      }
                    } else {
                      if (tabIndex == 0) {
                        directResponseData = [];
                        tempDirectResponseData = [];
                        directResponseData = tempDirectResponseData;
                      } else {
                        campusResponseData = [];
                        tempCampusResponseData = [];
                        campusResponseData = tempCampusResponseData;
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
          color: white2,
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
                        directResponseData = [];
                        tempDirectResponseData = [];
                        directJobListResponse(
                            JobT: '',
                            location: '',
                            Fdate: '',
                            Tdate: '',
                            ExpT: '',
                            CompanyT: '',
                            isFilter: false,
                            SalaryT: '');
                      } else {
                        campusResponseData = [];
                        tempCampusResponseData = [];

                        campusListResponse(
                            location: '',
                            Fdate: '',
                            Tdate: '',
                            isFilter: false,
                            campusName: '');
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
                    directResponseData?.length == 0
                        ? Center(
                            child: NoDataWidget(content: "Your Data is Loading"))
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                return _directList(
                                    _scrollController, totalCount, (value) {
                                  var dict = directResponseData?[value];

                                  dict?.bookmark =
                                      dict.bookmark == true ? false : true;

                                  setState(() {
                                    directResponseData?.removeAt(value);
                                    directResponseData?.insert(value, dict!);
                                  });

                                  bookMarkApiResponse(
                                      directResponseData?[value].jobId ?? "",
                                      directResponseData?[value].recruiterId ??
                                          "");
                                }, ref);
                              },
                            ),
                          ),
                    campusResponseData?.length == 0
                        ? Center(
                            child: NoDataWidget(content: "Your Data is Loading"))
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                return _campusList(
                                    _scrollController, totalCount1, ref);
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

  campusListResponse({
    required String campusName,
    required String location,
    required String Fdate,
    required String Tdate,
    required bool? isFilter,
  }) async {
    final campusListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": await getcandidateId(),
      "page_no": page1,
      "no_of_records": totalCount1,
      "campus_name": campusName,
      "location": location,
      "from_date": Fdate,
      "to_date": Tdate,
    });
    final campusResponseList = await campusListApiService.post<CampusListModel>(
        context, ConstantApi.campuslistUrl, formData);
    if (campusResponseList.status == true) {
      setState(() {
        campusResponseData.addAll(campusResponseList.data?.items ?? []);
        tempCampusResponseData.addAll(campusResponseList.data?.items ?? []);

        totalCount1 = campusResponseList.data?.totalItems ?? 0;
      });
      isFilter == true ? Navigator.pop(context) : null;
    } else {
      page1--;
      ShowToastMessage(campusResponseList.message ?? "");
      print('ERROR');
    }
  }

  directJobListResponse({
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
    final directJobResponseList =
        await directJobListApiService.post<DirectJobListModel>(
            context, ConstantApi.directjoblistUrl, formData);

    if (directJobResponseList.status == true) {
      print("SUCESS");
      ShowToastMessage(directJobResponseList?.message ?? "");
      setState(() {
        directResponseData
            .addAll(directJobResponseList.data?.items?.toList() ?? []);

        tempDirectResponseData
            .addAll(directJobResponseList.data?.items?.toList() ?? []);

        totalCount = directJobResponseList.data?.totalItems ?? 0;
      });
      // _jobTitle.clear();
      // _location.clear();
      // _From.clear();
      // _To.clear();
      // _CompanyName.clear();
      // _SalaryRange.clear();

      isFilter == true ? Navigator.pop(context) : null;
    } else {
      page--;
      // _jobTitle.clear();
      // _location.clear();
      // _From.clear();
      // _To.clear();
      // _CompanyName.clear();
      // _SalaryRange.clear();
      ShowToastMessage(directJobResponseList?.message ?? "");
      // Navigator.pop(context);
      print("ERROR");
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

  Widget _directList(ScrollController scrollController, int totalCount,
      Function(int)? bookmarkClick, WidgetRef ref) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: directResponseData?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if (index != (directResponseData?.length ?? 0)) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Job_Details(
                              jobId: directResponseData?[index]?.jobId ?? "",
                              recruiterId:
                                  directResponseData?[index]?.recruiterId ?? "",
                              isApplied:
                                  directResponseData?[index]?.already_applied ??
                                      false,
                              isInbox:
                                  directResponseData?[index]?.bookmark ?? false,
                              TagActive: '',
                              isSavedNeeded: true,
                            ))).then((value) {
                  directResponseData = [];
                  tempDirectResponseData = [];
                  ref.refresh(directJobListResponse(
                      JobT: '',
                      location: '',
                      Fdate: '',
                      Tdate: '',
                      ExpT: '',
                      CompanyT: '',
                      isFilter: false,
                      SalaryT: ''));
                });
              },
              child: DirectList(context,
                  isApplied: false,
                  jobName: directResponseData?[index].jobTitle ?? "",
                  companyName: directResponseData?[index].companyName ?? "",
                  location: directResponseData?[index].location ?? "",
                  companyLogo: directResponseData?[index].logo ?? "",
                  YOP: directResponseData?[index].experience ?? "",
                  ExpSalary:
                      "₹ ${directResponseData?[index].salaryFrom ?? ""} - ${directResponseData?[index].salaryTo ?? ""} Per Annum",
                  postedDate:
                      "Posted : ${directResponseData?[index].createdDate ?? ""}",
                  collegeName: '',
                  appliedDate: '',
                  collegeLoctaion: '',
                  collegeLogo: '',
                  isCampus: false,
                  currentIndex: index, bookmarkClick: (value) {
                bookmarkClick?.call(value);
              },
                  isStudent: true,
                  bookmark: directResponseData?[index].bookmark ?? false,
                  campusTag: ''));
        } else {
          if ((directResponseData?.length ?? 0) != 0 &&
              totalCount != (directResponseData?.length ?? 0)) {
            return buildLoadingIndicator();
          }
        }
      },
    );
  }

  Widget _campusList(
      ScrollController scrollController, int totalCount, WidgetRef ref) {
    return ListView.builder(
      controller: scrollController,
      // scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: campusResponseData?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if (index != (campusResponseData?.length ?? 0)) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Campus_Company_List_Page(
                              CampusId:
                                  campusResponseData?[index].campusId ?? "",
                            ))).then((value) {
                  campusResponseData = [];
                  tempCampusResponseData = [];
                  ref.refresh(campusListResponse(
                      location: _location.text,
                      Fdate: _From.text,
                      Tdate: _To.text,
                      isFilter: false,
                      campusName: _CampusName.text));
                });
              },
              child: CampusList(context,
                  isTag: "",
                  iscampTag: campusResponseData?[index].type ?? "",
                  isUsed: false,
                  onTap: () {},
                  jobName: '',
                  companyLogo: '',
                  companyName: '',
                  collegeName: campusResponseData?[index].name ?? "",
                  collegeLogo: campusResponseData?[index].logo ?? "",
                  companyLocation: '',
                  collegeLocation: campusResponseData?[index].location ?? "",
                  applyCount: '',
                  isCountNeeded: false));
        } else {
          if ((campusResponseData?.length ?? 0) != 0 &&
              totalCount != (campusResponseData?.length ?? 0)) {
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
                    width: MediaQuery.sizeOf(context).width / 3.2,
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
                    width: MediaQuery.sizeOf(context).width / 3.2,
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
                        _jobTitle.clear();
                        _location.clear();
                        _From.clear();
                        _To.clear();
                        _CompanyName.clear();
                        _SalaryRange.clear();
                        _CampusName.clear();

                        Navigator.pop(context);
                      })),
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Okay", () {
                        directResponseData = [];
                        tempDirectResponseData = [];
                        campusResponseData = [];
                        tempCampusResponseData = [];
                        totalCount = 0;
                        isCampus == false
                            ? directJobListResponse(
                                JobT: _jobTitle.text,
                                location: _location.text,
                                Fdate: _From.text,
                                Tdate: _To.text,
                                ExpT: _careerStatus.text,
                                CompanyT: _CompanyName.text,
                                isFilter: true,
                                SalaryT: _SalaryRange.text)
                            : campusListResponse(
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
