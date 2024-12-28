import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getifyjobs/Models/StudentDirectMyAppliesListModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Job_Details_Page.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../utilits/Common_Colors.dart';
import '../../../../utilits/Text_Style.dart';

class Candidate_MyApplies_Screen extends ConsumerStatefulWidget {
  Candidate_MyApplies_Screen({super.key});

  @override
  ConsumerState<Candidate_MyApplies_Screen> createState() =>
      _Candidate_MyApplies_ScreenState();
}

class _Candidate_MyApplies_ScreenState
    extends ConsumerState<Candidate_MyApplies_Screen> {
  List<StudentDirectMyAppliesListData>? DirectMyAppliesResponseData = [];
  List<StudentDirectMyAppliesListData>? tempDirectMyAppliesResponseData = [];
  ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
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
  int _currentPage = 1;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(_scrollListener);
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
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_isLoadingMore &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        _visibleItemCount != DirectMyAppliesResponseData?.length) {
      SingleTon().isLoading = false;
      _currentPage += 1;

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
        leading: Transform.scale(
          scale: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 0),
            child: ImgPathSvg('logo.svg'),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.black, // Navigation bar
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark // Status bar
            ),
        title: Text(
          "",
          style: LoginT,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // Adjust the height as needed
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
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
                    DirectMyAppliesResponseData =
                        tempDirectMyAppliesResponseData
                            ?.where((job) =>
                                job.jobTitle!.toLowerCase().contains(value) ||
                                job.companyName!.toLowerCase().contains(value))
                            .toList();
                    print(DirectMyAppliesResponseData?.length ?? 0);
                  } else {
                    DirectMyAppliesResponseData =
                        tempDirectMyAppliesResponseData;
                  }
                });
              },
              focusNode: _focusNode,
              isMultifilterNeeded: true,
            ),
          ),
        ),
      ),
      body: InkWell(
        onTap: () {
          if (_focusNode.hasFocus) {
            _focusNode.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(children: [
            DirectMyAppliesResponseData?.length == 0
                ? SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.5,
                    child: Center(
                        child: NoDataWidget(content: "No Data Available")))
                : _campusList(DirectMyAppliesResponseData),
            SizedBox(height: 50),
          ]),
        ),
      ),
    );
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
    final directMyAppliesResponseList =
        await directJobListApiService.post<StudentDirectMyAppliesListModel>(
            context, ConstantApi.directMyAppliesListUrl, formData);

    if (directMyAppliesResponseList.status == true) {
      print("SUCCESS");
      setState(() {
        DirectMyAppliesResponseData?.addAll(
            directMyAppliesResponseList.data?.toList() ?? []);
        tempDirectMyAppliesResponseData
            ?.addAll(directMyAppliesResponseList.data?.toList() ?? []);
      });
      isFilter == true ? Navigator.pop(context) : null;
    } else {
      _currentPage--;
      print("ERROR");
      ShowToastMessage(directMyAppliesResponseList?.message ?? "");
    }
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
                        DirectMyAppliesResponseData = [];
                        tempDirectMyAppliesResponseData = [];
                        _visibleItemCount = 0;

                        DirectMyAppliesListResponse(
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

  Widget _campusList(
      List<StudentDirectMyAppliesListData>? directMyAppliesResponseData) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: directMyAppliesResponseData?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Job_Details(
                            jobId: directMyAppliesResponseData?[index].jobId,
                            recruiterId:
                                directMyAppliesResponseData?[index].recruiterId,
                            isApplied: true,
                            isInbox: true,
                            TagActive: directMyAppliesResponseData?[index]
                                    ?.jobStatus ??
                                "",
                            isSavedNeeded: false,
                          ))).then((value) {
                DirectMyAppliesResponseData = [];
                DirectMyAppliesResponseData = [];
                _visibleItemCount = 0;
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
            child: Candidate_MyApplies_List(
              context,
              isApplied: false,
              jobName: directMyAppliesResponseData?[index]?.jobTitle ?? "",
              companyName:
                  directMyAppliesResponseData?[index]?.companyName ?? "",
              location: directMyAppliesResponseData?[index]?.location ?? "",
              companyLogo: directMyAppliesResponseData?[index]?.logo ?? "",
              YOP: directMyAppliesResponseData?[index]?.experience ?? "",
              ExpSalary:
                  '₹ ${directMyAppliesResponseData?[index]?.salaryFrom ?? ""} - ${directMyAppliesResponseData?[index]?.salaryTo ?? ""} Per Annum',
              postedDate: 'Posted: 23 Sep 2023',
              collegeName: '',
              appliedDate:
                  directMyAppliesResponseData?[index]?.appliedDate ?? "",
              status: directMyAppliesResponseData?[index]?.jobStatus ?? "",
            ));

        // CampusList(isTag: "Applied", iscampTag: 'OffCampus',isUsed: true, onTap: () {  },
        //   jobName: 'Augmented Reality (AR) Journey Builder‍',
        //   companyLogo: 'companyLogo.png',
        //   companyName: '',
        //   collegeName: 'Innova new Technology',
        //   collegeLogo: '',
        //   companyLocation: 'Coimbatore, Tamil Nadu',
        //   collegeLocation: '',));
      },
    );
  }
}
