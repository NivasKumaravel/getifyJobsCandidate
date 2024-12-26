import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ApplyCampusJobModel.dart';
import 'package:getifyjobs/Models/DirectJobListModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Home_DasBoard/Profile_Ui/Saved_Page.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Job_Details_Page.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Notification_Ui/Notification_Screen.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';

import '../../../../utilits/Common_Colors.dart';

class Candidate_Home_Screen extends ConsumerStatefulWidget {
  Candidate_Home_Screen({super.key});

  @override
  ConsumerState<Candidate_Home_Screen> createState() =>
      _Candidate_Home_ScreenState();
}

class _Candidate_Home_ScreenState extends ConsumerState<Candidate_Home_Screen> {
  List<DirectJobItems> jobLists = []; // List to hold fetched job data
  List<DirectJobItems> tempjobLists = []; //

  ScrollController _scrollController = ScrollController();
  FocusNode _focusNode = FocusNode();
  TextEditingController _From = TextEditingController();
  TextEditingController _To = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _jobTitle = TextEditingController();
  TextEditingController _SalaryRange = TextEditingController();
  TextEditingController _CompanyName = TextEditingController();
  TextEditingController _careerStatus = TextEditingController();
  int tabIndex = 0;
  RegExp onlyText = RegExp(r'^[a-zA-Z ]+$');

  int _visibleItemCount = 10; // Initial number of visible items
  bool _isLoadingMore = false; // List to hold fetched job data
  int _currentPage = 1; // Track the current page for pagination

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    directJobListResponse(
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
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_isLoadingMore &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        _visibleItemCount != jobLists?.length) {
      SingleTon().isLoading = false;
      _currentPage += 1;
      // User has reached the end of the list
      // Load more data when scrolled to the bottom
      // loadMoreData();
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
      "page_no": _currentPage,
      "no_of_records": _visibleItemCount,
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
      print("DIRECT LIST SUCCESS");
      setState(() {
        jobLists.addAll(directJobResponseList.data?.items?.toList() ?? []);

        tempjobLists.addAll(directJobResponseList.data?.items?.toList() ?? []);
      });
      isFilter == true ? Navigator.pop(context) : null;
      print(
          'BOOK MARK LIST ${directJobResponseList.data?.items?[0].bookmark ?? false}');
    } else {
      print("DIRECT LIST ERROR");
      ShowToastMessage(directJobResponseList?.message ?? "");
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: white2,
        appBar: AppBar(
          toolbarHeight: 80,
          primary: true,
          backgroundColor: white2,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.black, // Navigation bar
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark // Status bar
              ),
          leading: Transform.scale(
            scale: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 5),
              child: ImgPathSvg('logo.svg'),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Saved_Page()),
                    ).then((value) {
                      jobLists = [];
                      tempjobLists = [];
                      ref.refresh(directJobListResponse(
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
                  child: ImgPathSvg("save1.svg")),
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
                  child: Icon(
                    Icons.notifications_none,
                    size: 28,
                  )),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // Adjust the height as needed
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 20, bottom: 20),
              child: textFormFieldSearchBar(
                MultifilteronTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        InterviewSchedulePopup(context),
                  );
                },
                keyboardtype: TextInputType.text,
                hintText: "Search ...",
                Controller: null,
                validating: null,
                onChanged: (value) {
                  setState(() {
                    if (value != "") {
                      jobLists = tempjobLists
                          .where((job) =>
                              job.jobTitle!.toLowerCase().contains(value) ||
                              job.companyName!.toLowerCase().contains(value))
                          .toList();
                      print(jobLists?.length ?? 0);
                    } else {
                      jobLists = tempjobLists;
                    }
                  });
                },
                focusNode: _focusNode,
                isMultifilterNeeded: true,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            jobLists?.length == 0
                ? SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.5,
                    child: Center(
                        child: NoDataWidget(content: "No Data Available")))
                : ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: jobLists?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Job_Details(
                                      jobId: jobLists?[index].jobId ?? "",
                                      recruiterId:
                                          jobLists?[index].recruiterId ?? "",
                                      isApplied:
                                          jobLists?[index].already_applied ??
                                              false,
                                      isInbox:
                                          jobLists[index].bookmark ?? false,
                                      TagActive: '',
                                      isSavedNeeded: true,
                                    )),
                          ).then((value) {
                            jobLists = [];
                            tempjobLists = [];
                            _visibleItemCount = 0;
                            ref.refresh(directJobListResponse(
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
                        child: DirectList(
                          context,
                          isApplied: false,
                          jobName: jobLists?[index].jobTitle ?? '',
                          companyName: jobLists?[index].companyName ?? '',
                          location: jobLists?[index].location ?? '',
                          companyLogo: jobLists?[index].logo ?? '',
                          YOP: jobLists?[index].experience ?? '',
                          ExpSalary:
                              '₹ ${jobLists?[index].salaryFrom ?? ""} - ${jobLists?[index].salaryTo ?? ""} Per Annum',
                          postedDate:
                              'Posted: ${jobLists?[index].createdDate ?? ""}',
                          collegeName: '',
                          appliedDate: '',
                          collegeLoctaion: '',
                          collegeLogo: '',
                          isCampus: false,
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
                          currentIndex: index,
                          isStudent: true,
                          bookmark: jobLists[index].bookmark ?? false,
                          campusTag: '',
                        ),
                      );
                    },
                  ),
            SizedBox(height: 50),
          ]),
        ),
      ),
    );
  }

  Widget InterviewSchedulePopup(
    BuildContext context,
  ) {
    return Container(
      child: AlertDialog(
        surfaceTintColor: white1,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Multiple selection of ${"Job title, Location, Salary etc"}",
              style: Wbalck1,
              textAlign: TextAlign.center,
            ),
            Padding(
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
            Padding(
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
            Padding(
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
            Padding(
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
                        Navigator.pop(context);
                      })),
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Okay", () {
                        jobLists = [];
                        tempjobLists = [];
                        _visibleItemCount = 0;

                        directJobListResponse(
                            JobT: _jobTitle.text,
                            location: _location.text,
                            Fdate: _From.text,
                            Tdate: _To.text,
                            ExpT: _careerStatus.text,
                            CompanyT: _CompanyName.text,
                            isFilter: true,
                            SalaryT: _SalaryRange.text);
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

Widget buildLoadingIndicator() {
  return Center(
    child: CircularProgressIndicator(), // Use CircularProgressIndicator
  );
}
