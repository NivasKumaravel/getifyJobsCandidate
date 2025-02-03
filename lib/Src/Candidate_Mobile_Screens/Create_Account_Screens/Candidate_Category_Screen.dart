import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getifyjobs/Models/AddProfileModel.dart';
import 'package:getifyjobs/Models/CandidateProfileModel.dart';
import 'package:getifyjobs/Models/CollegePrfileModel.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Create_Account_Screens/SearchLocation.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Pdf_Picker.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class Candidate_Categoery_Screen extends ConsumerStatefulWidget {
  final bool isEdit;
  canidateProfileData? candidateProfileResponseData;
  Candidate_Categoery_Screen(
      {super.key,
      required this.isEdit,
      required this.candidateProfileResponseData});

  @override
  ConsumerState<Candidate_Categoery_Screen> createState() =>
      _Candidate_Categoery_ScreenState();
}

class _Candidate_Categoery_ScreenState
    extends ConsumerState<Candidate_Categoery_Screen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedOption;
  String? selectExpVal;

  // String? qualificationOption;
  List<String> experieceVal = [
    "0-1",
    "1-2",
    "2-3",
    "3-4",
    "4-5",
    "5-6",
    "6-7",
    "7-8",
    "8-9",
    "9-10",
    "10-15",
    "15 & Above"
  ];
  List<String> Categoery = ['Experienced', 'Fresher', 'Student'];
  bool _isChecked = false;

  TextEditingController _PreferredLocation = TextEditingController();
  TextEditingController _CurrentSalary = TextEditingController();
  TextEditingController _ExpectedSalary = TextEditingController();
  TextEditingController _StartYear = TextEditingController();
  TextEditingController _EndYear = TextEditingController();
  TextEditingController _CurrentPercent = TextEditingController();
  TextEditingController _CurrentArrears = TextEditingController();
  TextEditingController _HistoryofArrears = TextEditingController();

  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  FocusNode _focusNode5 = FocusNode();
  FocusNode _focusNode6 = FocusNode();
  FocusNode _focusNode7 = FocusNode();
  FocusNode _focusNode8 = FocusNode();
  FocusNode _focusNode9 = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    _focusNode7.dispose();
    _focusNode8.dispose();
    _focusNode9.dispose();
    _CurrentSalary.dispose();
    _ExpectedSalary.dispose();
    super.dispose();
  }

  String? qualificationOption = "";
  String? qualificationOptionId;
  String? experienceOption;
  List<String>? specializationOption;
  List<String>? specializationId;
  List<String>? skillsetOption;
  List<String> preferredlocationOption = [];

  String? DesinationOption;
  String? DesinationOptionName;

  String? collegeOption;
  String? collegeOptionId;
  List<DropDownData> qualificationVal = [];
  List<DropDownData> experienceVal = [];
  List<DropDownData> specializationonVal = [];
  List<DropDownData> DesinationVal = [];
  List<DropDownData> skillsetVal = [];
  List<DropDownData> collegeVal = [];

  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.isEdit == true ? EditCareer() : null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      apiCall();
    });
  }

  apiCall() async {
    await loadQualificationOptions();
    SingleTon().isLoading = false;
    // await SetSpecializrion();
    await setSkillset();
    await Desination();
    await CollegeName();
    await SetSpecializrion();

    SingleTon().isLoading = true;
  }

  Future<void> loadQualificationOptions() async {
    final apiService = ApiService(ref.read(dioProvider));

    try {
      print(ConstantApi.ProfileScreenQualifaction);
      final response = await apiService.get<Collage_Profile>(
          context, ConstantApi.ProfileScreenQualifaction);

      setState(() {
        qualificationVal = response.data ?? []; // Assuming data is a List<Data>
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  // SetSpecializrion
  Future<void> SetSpecializrion() async {
    try {
      final apiService =
          ApiService(ref.read(dioProvider)); // Access ApiService using Riverpod

      // Make an API call using the post method
      // final response = await apiService.post<Collage_Profile>(
      //   ConstantApi.ProfileScreenspecialization,
      // var formData = FormData.fromMap({
      //   "qualification": qualificationOption
      // } // Pass appropriate FormData if needed
      //     );
      var formData = FormData.fromMap({
        "qualification": qualificationOptionId
      }); // Pass appropriate FormData if needed
      // );
      final response = await apiService.post<Collage_Profile>(
          context, ConstantApi.ProfileScreenspecial, formData);

      // final response = await apiService.get<Collage_Profile>(
      //     context, ConstantApi.ProfileScreenspecialization);
      // setState(() {
      // Assuming response.data is a List<Data> from your API
      specializationonVal = response.data ?? [];
      // });
    } catch (e) {
      print('Error fetching data from API: $e');
    }
  }

  // skillset
  Future<void> setSkillset() async {
    try {
      final apiService = ApiService(ref.read(dioProvider));
      print(ConstantApi.ProfileScreenskills);

      final response = await apiService.get<Collage_Profile>(
          context, ConstantApi.ProfileScreenskills);

      setState(() {
        skillsetVal = response.data?.toSet().toList() ??
            []; // Using a set to eliminate duplicates
      });
    } catch (e) {
      print('Error: $e');
    }
  }

// Desination
  Future<void> Desination() async {
    try {
      final apiService = ApiService(ref.read(dioProvider));
      print(ConstantApi.ProfileScreensdesignation);

      final response = await apiService.get<Collage_Profile>(
          context, ConstantApi.ProfileScreensdesignation);

      setState(() {
        DesinationVal = response.data?.toSet().toList() ??
            []; // Using a set to eliminate duplicates
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> CollegeName() async {
    try {
      final apiService = ApiService(ref.read(dioProvider));
      print(ConstantApi.ProfileScreen);

      final response = await apiService.get<Collage_Profile>(
          context, ConstantApi.ProfileScreen);

      setState(() {
        collegeVal = response.data?.toSet().toList() ??
            []; // Using a set to eliminate duplicates
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  EditCareer() {
    _PreferredLocation.text =
        widget.candidateProfileResponseData?.preferredLocation ?? "";
    _ExpectedSalary.text =
        widget.candidateProfileResponseData?.expectedSalary ?? "";
    _CurrentSalary.text =
        widget.candidateProfileResponseData?.currentSalary ?? "";
    _CurrentArrears.text =
        widget.candidateProfileResponseData?.currentArrears ?? "";
    _CurrentPercent.text =
        widget.candidateProfileResponseData?.currentPercentage ?? "";
    _StartYear.text = widget.candidateProfileResponseData?.startYear ?? "";
    _EndYear.text = widget.candidateProfileResponseData?.endYear ?? "";
    _HistoryofArrears.text =
        widget.candidateProfileResponseData?.historyOfArrears ?? "";
    selectExpVal = widget.candidateProfileResponseData?.experience ?? "";
    selectedOption = widget.candidateProfileResponseData?.careerStatus ?? "";
    qualificationOption =
        widget.candidateProfileResponseData?.qualification ?? "";
    collegeOption = widget.candidateProfileResponseData?.collegeName ?? "";
    collegeOptionId = widget.candidateProfileResponseData?.collegeId ?? "";
    qualificationOptionId =
        widget.candidateProfileResponseData?.qualificationId ?? "";
    specializationOption =
        (widget.candidateProfileResponseData?.specialization ?? "").split(',');
    specializationId =
        (widget.candidateProfileResponseData?.specialization ?? "")
            .split(',')
            .toList();

    skillsetOption =
        (widget.candidateProfileResponseData?.skill ?? "").split(',');
    preferredlocationOption =
        (widget.candidateProfileResponseData?.preferredLocation ?? "")
            .split(',');
    DesinationOption = widget.candidateProfileResponseData?.designationId ?? "";
    DesinationOptionName =
        widget.candidateProfileResponseData?.designation ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      // appBar: Custom_AppBar(
      //   isUsed: false,
      //   actions: null,
      //   isLogoUsed: true,
      //   isTitleUsed: false,
      //   title: '',
      // ),
      appBar: widget.isEdit == false
          ? null
          : Custom_AppBar(
              isUsed: true,
              actions: null,
              isLogoUsed: true,
              isTitleUsed: true,
              title: "Edit Career",
            ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 25),
                  child: Logo(context),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: white1),
                  width: MediaQuery.of(context).size.width,
                  height: selectedOption == "Experienced"
                      ? 1650
                      : selectedOption == "Fresher"
                          ? 1150
                          : selectedOption == "Student"
                              ? 1750
                              : MediaQuery.sizeOf(context).height,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        //Career Status
                        widget.isEdit == true
                            ? Container()
                            : Title_Style(
                                Title: 'Career Status', isStatus: true),
                        widget.isEdit == true
                            ? Container()
                            : dropDownField(context,
                                focusNode: _focusNode,
                                value: selectedOption,
                                listValue: Categoery,
                                onChanged: (String? newValue) {
                                setState(() {
                                  selectedOption = newValue;

                                  qualificationOption = "";
                                  experienceOption = "";
                                  specializationOption = [];
                                  skillsetOption = [];
                                  DesinationOption = "";
                                  DesinationOptionName = "";
                                  collegeOption = "";

                                  selectExpVal = null;

                                  _PreferredLocation.text = "";
                                  _ExpectedSalary.text = "";
                                  _CurrentSalary.text = "";
                                  _StartYear.text = "";
                                  _EndYear.text = "";
                                  _CurrentPercent.text = "";
                                  _CurrentArrears.text = "";
                                  _HistoryofArrears.text = "";
                                });
                              },
                                hintText: '  Select Your Career Status',
                                error: null),

                        //CURRENT DESIGNATION
                        selectedOption == "Fresher"
                            ? CategoeryField()
                            : selectedOption == "Student"
                                ? CategoeryField()
                                : selectedOption == "Experienced"
                                    ? CategoeryField()
                                    : Container(),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 50, right: 50),
                          child: CommonElevatedButton(context,
                              widget.isEdit == true ? "Submit" : "Register",
                              () async {
                            focus.unfocus();
                            focus1.unfocus();
                            focus2.unfocus();
                            focus3.unfocus();
                            focus4.unfocus();
                            focus5.unfocus();
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                if (selectedOption == null) {
                                  ShowToastMessage(
                                      "Please select career status");
                                } else if (selectedOption == "Student" &&
                                    collegeOption == "") {
                                  ShowToastMessage("Please enter college name");
                                } else if (specializationOption?.length == 0) {
                                  ShowToastMessage(
                                      "Please Select Specialization");
                                } else if (preferredlocationOption.length ==
                                    0) {
                                  ShowToastMessage(
                                      "Please Select Preferred Location");
                                } else if (skillsetOption?.length == 0) {
                                  ShowToastMessage("Please Select Skill Set");
                                } else if (preferredlocationOption.length ==
                                    0) {
                                  ShowToastMessage(
                                      "Please Select Preferred Location");
                                } else {
                                  if (widget.isEdit == true) {
                                    AddProfileResponse();
                                  } else if (_isChecked == false) {
                                    ShowToastMessage(
                                        " Please Read and Agree to Our T&C");
                                  } else {
                                    AddProfileResponse();
                                  }
                                }
                              }
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Current designation
  Widget CategoeryField() {
    return Column(
      children: [
        //CURRENT DESIGNATION && COLLEGE NAME
        selectedOption == "Fresher"
            ? Container()
            : selectedOption == "Student"
                ? Title_Style(
                    Title: selectedOption == "Fresher"
                        ? ""
                        : selectedOption == "Student"
                            ? "College Name"
                            : selectedOption == "Experienced"
                                ? 'Current Designation'
                                : "",
                    isStatus: true)
                : selectedOption == "Experienced"
                    ? Title_Style(
                        Title: selectedOption == "Fresher"
                            ? ""
                            : selectedOption == "Student"
                                ? "College Name"
                                : selectedOption == "Experienced"
                                    ? 'Current Designation'
                                    : "",
                        isStatus: true)
                    : Container(),
        selectedOption == "Experienced"
            ? dropDownSearchField(context,
                listValue: DesinationVal,
                controller: TextEditingController(text: DesinationOptionName),
                onChanged: ((x) {
                  focus.unfocus();
                  setState(() {
                    DropDownData result = DesinationVal.firstWhere(
                        (value) => value.qualification == x.searchKey);

                    // Print the result
                    print(result.id);

                    DesinationOption = result.id;
                    DesinationOptionName = result.designation;
                  });
                }),
                focus: focus,
                validator: (x) {
                  if (x!.isEmpty) {
                    return 'Please Select Current Designation';
                  }
                  return null;
                },
                hintT: 'Please Select Current Designation',
                searchText: (SearchValue) {
                  DesinationOption = SearchValue;
                })
            : selectedOption == "Student"
                ? dropDownSearchField(context,
                    listValue: collegeVal,
                    controller: TextEditingController(text: collegeOption),
                    onChanged: ((x) {
                      focus1.unfocus();
                      setState(() {
                        DropDownData result = collegeVal.firstWhere(
                            (value) => value.qualification == x.searchKey);

                        // Print the result
                        print(result.id);

                        collegeOption = result.collegeName;
                        collegeOptionId = result.id;
                      });
                    }),
                    focus: focus1,
                    validator: (x) {
                      if (x!.isEmpty) {
                        return 'Please Select College';
                      }
                      return null;
                    },
                    hintT: 'Please Select College',
                    searchText: (SearchValue) {
                      collegeOption = SearchValue;
                    })
                : Container(),

        //EXPERIENCE
        selectedOption == "Experienced"
            ? Title_Style(Title: 'Experience (In Years)', isStatus: true)
            : Container(),
        selectedOption == "Experienced"
            ? dropDownField(
                context,
                focusNode: _focusNode1,
                value: selectExpVal,
                listValue: experieceVal,
                onChanged: (String? newValue) {
                  setState(() {
                    selectExpVal = newValue;
                  });
                },
                hintText: '  Select Your Experienced',
                error: selectExpVal == null
                    ? "Please Select Your Experience"
                    : null,
              )
            : Container(),
        //Qualification*
        Title_Style(Title: 'Qualification', isStatus: true),

        dropDownSearchField(
          context,
          listValue: qualificationVal,
          controller: TextEditingController(text: qualificationOption),
          onChanged: ((x) {
            focus3.unfocus();

            setState(() {
              DropDownData result = qualificationVal
                  .firstWhere((value) => value.qualification == x.searchKey);

              // Print the result
              print(result.id);

              qualificationOption = result.qualification;
              qualificationOptionId = result.id;

              specializationOption = [];
              specializationonVal = [];
              SetSpecializrion();
            });
          }),
          focus: focus3,
          validator: (x) {
            if (x!.isEmpty) {
              return 'Please Select Qualification';
            }
            return null;
          },
          hintT: 'Please Select Qualification',
          searchText: (SearchValue) {
            qualificationOption = SearchValue;
          },
        ),

        //Specialization*
        Title_Style(Title: 'Specialization', isStatus: true),

        tagSearchField(
          hintText: "Specialization",
          focus: null,
          listValue: specializationonVal,
          focusTagEnabled: false,
          values: specializationOption ?? [],
          onPressed: (p0) {
            print(p0);

            setState(() {
              specializationOption = p0;
            });
          },
          error: (specializationOption?.length ?? 0) == 0
              ? "Please select at least one specialization"
              : null,
        ),
        // dropDownSearchField(
        //   context,
        //   listValue: specializationonVal,
        //   onChanged: ((x) {
        //     focus4.unfocus();
        //     setState(() {
        //       DropDownData result = specializationonVal
        //           .firstWhere((value) => value.specialization == x.searchKey);
        //       print(result.id);

        //       specializationOption = result.id;
        //     });
        //   }),
        //   focus: focus4,
        //   validator: (x) {
        //     if (x!.isEmpty) {
        //       return 'Please Select Specialization';
        //     }
        //     return null;
        //   },
        //   hintT: 'Please Select Specialization',
        //   searchText: (SearchValue) {
        //     specializationOption = SearchValue;
        //   },
        // ),

        //Skill Set*
        Title_Style(Title: 'Skill Sets', isStatus: true),
        tagSearchField(
          hintText: "Skill Sets",
          focus: focus5,
          listValue: skillsetVal,
          focusTagEnabled: false,
          values: skillsetOption ?? [],
          onPressed: (p0) {
            print(p0);

            setState(() {
              skillsetOption = p0;
            });
          },
          error: (skillsetOption?.length ?? 0) == 0
              ? "Please select at least one Skill Set"
              : null,
        ),
        // dropDownSearchField(context,
        //     listValue: skillsetVal,
        //     onChanged: ((x) {
        //       focus5.unfocus();
        //       setState(() {
        //         DropDownData result = skillsetVal.firstWhere(
        //             (value) => value.qualification == x.searchKey);
        //         print(result.id);

        //         skillsetOption = result.id;
        //       });
        //     }),
        //     focus: focus5,
        //     validator: (x) {
        //       if (x!.isEmpty) {
        //         return 'Please Select Skill Set';
        //       }
        //       return null;
        //     },
        //     hintT: 'Please Select Skill Set',
        //     searchText: (SearchValue) {
        //       skillsetOption = SearchValue;
        //     }),

        //Year*
        selectedOption == "Student"
            ? Title_Style(Title: 'Course Duration', isStatus: true)
            : Container(),
        selectedOption == "Student"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Starting Year",
                          style: Homegrey2,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: textFormField(
                          hintText: 'Start Year',
                          focusNode: _focusNode2,
                          keyboardtype: TextInputType.number,
                          inputFormatters: null,
                          Controller: _StartYear,
                          validating: (value) {
                            if (value == null || value.isEmpty) {
                              return " Enter Valid Start Year";
                            }
                            if (value == null) {
                              return " Enter Valid Start Year";
                            }
                            return null;
                          },
                          onChanged: null,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Ending Year",
                          style: Homegrey2,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: textFormField(
                          hintText: 'End Year',
                          focusNode: _focusNode3,
                          keyboardtype: TextInputType.number,
                          inputFormatters: null,
                          Controller: _EndYear,
                          validating: _endYearValidator,
                          onChanged: null,
                        ),
                      )
                    ],
                  ),
                ],
              )
            : Container(),

        //Current Percentage / CGPA*
        selectedOption == "Student"
            ? Title_Style(Title: 'Current Percentage / CGPA', isStatus: true)
            : Container(),
        selectedOption == "Student"
            ? textFormField(
                hintText: 'CGPA',
                keyboardtype: TextInputType.number,
                inputFormatters: null,
                Controller: _CurrentPercent,
                focusNode: _focusNode4,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Valid ${'CGPA'}";
                  }
                  if (value == null) {
                    return "Please Enter Valid ${'CGPA'}";
                  }
                  return null;
                },
                onChanged: null,
              )
            : Container(),

        //Current Arrears*
        selectedOption == "Student"
            ? Title_Style(Title: 'Current Arrears', isStatus: true)
            : Container(),
        selectedOption == "Student"
            ? textFormField(
                hintText: 'Current Arrears',
                keyboardtype: TextInputType.number,
                focusNode: _focusNode5,
                inputFormatters: null,
                Controller: _CurrentArrears,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Valid ${'Current Arrears'}";
                  }
                  if (value == null) {
                    return "Please Enter Valid ${'Current Arrears'}";
                  }
                  return null;
                },
                onChanged: null,
              )
            : Container(),

        // History of Arrears*
        selectedOption == "Student"
            ? Title_Style(Title: ' History of Arrears', isStatus: true)
            : Container(),
        selectedOption == "Student"
            ? textFormField(
                hintText: 'Arrears',
                keyboardtype: TextInputType.number,
                focusNode: _focusNode6,
                inputFormatters: null,
                Controller: _HistoryofArrears,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Valid ${'History of Arrears'}";
                  }
                  if (value == null) {
                    return "Please Enter Valid ${'History of Arrears'}";
                  }
                  return null;
                },
                onChanged: null,
              )
            : Container(),

        //Preferred Location*
        Title_Style(Title: 'Preferred Job Location', isStatus: true),

        GestureDetector(
          onTap: () {
            focus.unfocus();
            focus1.unfocus();
            focus2.unfocus();
            focus3.unfocus();
            focus4.unfocus();
            focus5.unfocus();

            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchLocation()))
                .then((value) {
              if (value != null) {
                setState(() {
                  preferredlocationOption.add(value);
                });
              }
            });
          },
          child: tagSearchFieldPreferredLoc(
            hintText: "Preferred Job Location",
            listValue: [],
            focusTagEnabled: false,
            values: preferredlocationOption,
            onPressed: (p0) {
              print(" PREFFERED LOCATION DATA ${p0}");

              setState(() {
                preferredlocationOption = p0;
              });
            },
            error: (skillsetOption?.length ?? 0) == 0
                ? "Please enter job location"
                : null,
          ),
        ),

        // textFormField(
        //   hintText: 'Preferred Job Location',
        //   keyboardtype: TextInputType.text,
        //   inputFormatters: null,
        //   Controller: _PreferredLocation,
        //   validating: (value) {
        //     if (value == null || value.isEmpty) {
        //       return "Please Enter Valid ${'Location'}";
        //     }
        //     if (value == null) {
        //       return "Please Enter Valid ${'Location'}";
        //     }
        //     return null;
        //   },
        //   onChanged: null,
        // ),

        //Current Salary*
        selectedOption == "Experienced"
            ? Title_Style(Title: 'Current Salary (Per Annum)', isStatus: true)
            : Container(),
        selectedOption == "Experienced"
            ? textFormField(
                hintText: 'Current Salary',
                focusNode: _focusNode8,
                keyboardtype: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  _SalaryInputFormatter(),
                ],
                Controller: _CurrentSalary,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Current Salary';
                  }
                  final cleanValue = value.replaceAll(',', '');
                  if (double.tryParse(cleanValue) == null) {
                    return 'Please enter a valid number';
                  }
                  if (_ExpectedSalary.text.isNotEmpty &&
                      double.parse(cleanValue) >=
                          double.parse(
                            _ExpectedSalary.text.replaceAll(',', ''),
                          )) {
                    return 'Current Salary must be lower than Expected Salary';
                  }
                  return null;
                },
                onChanged: null,
              )
            : Container(),

        //Expected Salary*
        Title_Style(
            Title: 'Expected Salary (Per Annum)',
            isStatus: selectedOption == "Experienced" ? true : false),
        textFormField(
          hintText: 'Expected Salary',
          keyboardtype: TextInputType.number,
          focusNode: _focusNode9,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            _SalaryInputFormatter(),
          ],
          Controller: _ExpectedSalary,
          validating: selectedOption == "Experienced"
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Expected Salary';
                  }
                  final cleanValue = value.replaceAll(',', '');
                  if (double.tryParse(cleanValue) == null) {
                    return 'Please enter a valid number';
                  }
                  if (_CurrentSalary.text.isNotEmpty &&
                      double.parse(cleanValue) <=
                          double.parse(
                            _CurrentSalary.text.replaceAll(',', ''),
                          )) {
                    return 'Expected Salary must be greater than Current Salary';
                  }
                  return null;
                }
              : null,
          onChanged: null,
        ),
        //
        // // //MAP
        // Container(height: 105, child: Common_Map()),

        //ATTACHMENT
        widget.isEdit == true
            ? Container(
                height: 110,
                alignment: Alignment.center,
                color: white1,
                margin: EdgeInsets.only(top: 25),
                child: PdfPickerExample(
                  optionalTXT:
                      '${widget.candidateProfileResponseData?.name ?? ""}.pdf',
                  pdfUrl: widget.candidateProfileResponseData?.resume ?? "",
                  isProfile: true,
                  isCancelNeed: true,
                ))
            : Container(
                height: 110,
                alignment: Alignment.center,
                color: white1,
                margin: EdgeInsets.only(top: 25),
                child: PdfPickerExample(
                  optionalTXT: ' ',
                  isProfile: false,
                  isCancelNeed: true,
                )),

        //CHECK BOX
        widget.isEdit == true
            ? Container()
            : CheckBoxes(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    setState(() => _isChecked = !_isChecked);
                  });
                },
                checkBoxText: 'Terms & Conditions and Privacy Policy'),
      ],
    );
  }

  //ADD DETAIL RESPONSE
  AddProfileResponse() async {
    List<String> getSpecializationID = [];

    if ((specializationOption?.length ?? 0) > 0) {
      specializationOption!.forEach((user) {
        String username = user;

        DropDownData result = specializationonVal.firstWhere(
            (value) => value.qualification == username,
            orElse: () => DropDownData());

        String userId = result.id ?? "";

        if (userId != "") {
          getSpecializationID.add(userId);
        } else {
          getSpecializationID.add(username);
        }
        print('Username: $username, User ID: $userId');
      });
    }

    List<String> getSkillID = [];

    if ((skillsetOption?.length ?? 0) > 0) {
      skillsetOption!.forEach((user) {
        String username = user;

        DropDownData result = skillsetVal.firstWhere(
            (value) => value.qualification == username,
            orElse: () => DropDownData());

        String userId = result.id ?? "";

        if (userId != "") {
          getSkillID.add(userId);
        } else {
          getSkillID.add(username);
        }
        print('Username: $username, User ID: $userId');
      });
    }

    final addProfileApiService = ApiService(ref.read(dioProvider));
    print("SPECILIZATION Array ${getSpecializationID}");

    print("SPECILIZATION ID ${getSpecializationID.join(',')}");
    print("skill_set ID ${getSkillID.join(',')}");
    var formData = FormData.fromMap({
      "career_status": selectedOption,
      "qualification": qualificationOptionId,
      "specialization": getSpecializationID.join(','),
      "preferred_location": preferredlocationOption.join(','),
      "expected_salary": _ExpectedSalary.text,
      "skill_set": getSkillID.join(','),
      "location": SingleTon().setLocation,
      "experience": selectExpVal,
      "designation": DesinationOption,
      "current_salary": _CurrentSalary.text,
      "college_name": collegeOptionId == null ? collegeOption : collegeOptionId,
      "start_year": _StartYear.text,
      "end_year": _EndYear.text,
      "current_percentage": _CurrentPercent.text,
      "current_arrears": _CurrentArrears.text,
      "history_of_arrears": _HistoryofArrears.text,
      "candidate_id": await getcandidateId(),
      "latitude": SingleTon().lattidue,
      "longitude": SingleTon().longitude,
    });

    if (SingleTon().setPdf != null) {
      formData.files.addAll([
        MapEntry(
            'resume', await MultipartFile.fromFile(SingleTon().setPdf!.path)),
      ]);
    }

    final addProfileResponse = await addProfileApiService.post<AddProfileModel>(
        context, ConstantApi.candidateAddProfile, formData);
    if (addProfileResponse.status == true) {
      print("SUCESS");
      Routes("true");
      ShowToastMessage(addProfileResponse.message ?? "");
      CandidateType(selectedOption == "Student" ? "Student" : "Candidate");

      if (widget.isEdit == true) {
        Navigator.pop(context, "true");
        // selectedOption == 'Student'
        //     ? Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Bottom_Navigation(
        //                   select: 3,
        //                 )),
        //         (route) => false)
        //     : Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Candidate_Bottom_Navigation(
        //                   select: 3,
        //                 )),
        //         (route) => false);
      } else {
        selectedOption == 'Student'
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Bottom_Navigation(
                          select: 0,
                        )),
                (route) => false)
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Candidate_Bottom_Navigation(
                          select: 0,
                        )),
                (route) => false);
      }
    } else {
      ShowToastMessage(addProfileResponse.message ?? "");

      print("ERROR");
    }
  }

  String? _endYearValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an end year';
    }
    int? startYear = int.tryParse(_StartYear.text);
    int? endYear = int.tryParse(value);

    if (startYear != null && endYear != null) {
      if (endYear < startYear) {
        return 'End year must be greater than or equal to start year';
      }
    }
    return null;
  }
}

class _SalaryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final cleanValue = newValue.text.replaceAll(',', '');
    final formatter = NumberFormat("#,###");

    int value = int.tryParse(cleanValue) ?? 0;

    String newText = formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
