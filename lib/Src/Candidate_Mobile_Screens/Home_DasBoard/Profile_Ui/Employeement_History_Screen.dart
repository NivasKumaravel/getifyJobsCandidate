import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getifyjobs/Models/CollegePrfileModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EmpDetail {
  final String JobRole;
  final String CompanyName;
  final String StartDate;
  final String EndDate;
  final String NoticePeriod;
  final String EmployementType;
  final String Description;
  final int CurrentCompany;

  EmpDetail(this.JobRole, this.CompanyName, this.StartDate, this.EndDate,
      this.NoticePeriod, this.EmployementType,this.Description,this.CurrentCompany);
}

class EducationDetail {
  final String university;
  final String university_id;
  final String qualification;
  final String qualification_id;
  final List<String> specilization;
  final String specilization_id;

  final String educationType;
  final String cgpa;
  final String startYear;
  final String endYear;

  EducationDetail(
      this.university,
      this.university_id,
      this.qualification,
      this.qualification_id,
      this.specilization,
      this.specilization_id,
      this.educationType,
      this.cgpa,
      this.startYear,
      this.endYear);
}

class Employeement_History_Page extends ConsumerStatefulWidget {
  final EmpDetail initialDetail;
  final EducationDetail educationHistory;
  bool? isType;
  bool? isEdit;

  Employeement_History_Page(
      {super.key,
      required this.initialDetail,
      required this.isType,
      required this.educationHistory,required this.isEdit});

  @override
  ConsumerState<Employeement_History_Page> createState() =>
      _Employeement_History_PageState();
}

class _Employeement_History_PageState
    extends ConsumerState<Employeement_History_Page> {
  String? selectedOption;
  bool? isCurrentCompany;
  int? _value;
  List<String> EductiontypeList = [
    'Regular',
    'Correspondence/Distance',
    'Part time'
  ];

  String? qualificationOption;

  String? collegeption;
  String? qualificationOption_id;

  String? collegeption_id;

  List<DropDownData> qualificationVal = [];
  List<String>? specializationOption;
  List<DropDownData> specializationonVal = [];
  List<DropDownData> collegeVal = [];
  List<DropDownData> DesinationVal = [];
  String? DesinationOption;

  TextEditingController _JobRole = TextEditingController();
  TextEditingController _CompanyName = TextEditingController();
  TextEditingController _StartDate = TextEditingController();
  TextEditingController _EndDate = TextEditingController();
  TextEditingController _NoticePeriod = TextEditingController();
  int? typeVal;

  //EDUCATION CONTROLLER
  TextEditingController _CGPA = TextEditingController();
  TextEditingController _StartD = TextEditingController();
  TextEditingController _EndD = TextEditingController();
  TextEditingController _Description = TextEditingController();

  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  FocusNode _focusNode5 = FocusNode();
  final focus3 = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String _toTitleCase(String text) {
    if (text.isEmpty) return '';

    return text.toLowerCase().split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return '';
    }).join(' ');
  }

  void _JobroleFormat() {
    final text = _JobRole.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _JobRole.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  void _CompanyFormat() {
    final text = _CompanyName.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _CompanyName.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  void _jobprofileformat() {
    final text = _Description.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _Description.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _JobRole.addListener(_JobroleFormat);
    _CompanyName.addListener(_CompanyFormat);
    _Description.addListener(_jobprofileformat);
    widget.isEdit == true?EditResponse():null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      apiCall();
    });
  }

  apiCall() async {
    await loadQualificationOptions();
    SingleTon().isLoading = false;
    await CollegeName();
    SingleTon().isLoading = true;
  }

  EditResponse() async{
    if (widget.isType == true) {
      if (widget.initialDetail != null) {
        _JobRole.text = widget.initialDetail.JobRole;
        _CompanyName.text = widget.initialDetail.CompanyName;
        _StartDate.text = widget.initialDetail.StartDate;
        _EndDate.text = widget.initialDetail.EndDate;
        _NoticePeriod.text = widget.initialDetail.NoticePeriod;
        _Description.text = widget.initialDetail.Description;
        _value = widget.initialDetail.CurrentCompany == 0?0:widget.initialDetail.CurrentCompany == 1?1:null;
        typeVal = widget.initialDetail.EmployementType == 'Full Time'?0:widget.initialDetail.EmployementType == 'Part Time'?1:widget.initialDetail.EmployementType == 'Intern'?2:null;
      }
    } else {
      if (widget.educationHistory != null) {
        collegeption = widget.educationHistory.university;
        qualificationOption = widget.educationHistory.qualification;
        specializationOption = widget.educationHistory.specilization;
        selectedOption = widget.educationHistory.educationType;
        _StartD.text = widget.educationHistory.startYear;
        _EndD.text = widget.educationHistory.endYear;
      }
    }
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
        "qualification": qualificationOption_id
      }); // Pass appropriate FormData if needed
      // );
      final response = await apiService.post<Collage_Profile>(
          context, ConstantApi.ProfileScreenspecial, formData);

      // final response = await apiService.get<Collage_Profile>(
      //     context, ConstantApi.ProfileScreenspecialization);
      setState(() {
        // Assuming response.data is a List<Data> from your API
        specializationonVal = response.data ?? [];
      });
    } catch (e) {
      print('Error fetching data from API: $e');
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: [],
        isLogoUsed: true,
        isTitleUsed: true,
        title: widget.isType == true ? 'Employment History' : 'Education',
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              //EMPLOYEEMENT HISTORY && EDUCATION HISTORY
              widget.isType == true
                  ? Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25), color: white1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [

                            //JOB ROLE
                            Title_Style(Title: 'Job Role', isStatus: true),
                            textFormField(
                                hintText: 'Job Role',
                                keyboardtype: TextInputType.text,
                                inputFormatters: null,
                                focusNode: _focusNode1,
                                Controller: _JobRole,
                                validating: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Valid ${'Job Role'}";
                                  }
                                  if (value == null) {
                                    return "Please Enter Valid ${'Job Role'}";
                                  }
                                  return null;
                                },
                                onChanged: null),


                            //Company Name
                            Title_Style(Title: 'Company Name', isStatus: true),
                            textFormField(
                                hintText: 'Company Name',
                                keyboardtype: TextInputType.text,
                                inputFormatters: null,
                                focusNode: _focusNode2,
                                Controller: _CompanyName,
                                validating: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Valid ${'Company Name'}";
                                  }
                                  if (value == null) {
                                    return "Please Enter Valid ${'Company Name'}";
                                  }
                                  return null;
                                },
                                onChanged: null),

                            //TYPE
                            Title_Style(Title: 'Work Type', isStatus: true),
                            MultiRadioButton(context,
                                groupValue1: typeVal,
                                groupValue2: typeVal,
                                groupValue3: typeVal, onChanged1: (value) {
                              setState(() {
                                typeVal = value;
                              });
                            }, onChanged2: (value) {
                              setState(() {
                                typeVal = value;
                              });
                            }, onChanged3: (value) {
                              setState(() {
                                typeVal = value;
                              });
                            },
                                radioTxt1: "Full Time",
                                radioTxt2: "Part Time",
                                radioTxt3: 'Intern'),

                            Title_Style(
                                Title: "Is this your current company ?",
                                isStatus: true),
                            _RadioButton(),
                            //START DATE AND END DATE
                            _value == null?Container():    Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Title_Style(
                                            Title: 'Start Date', isStatus: true),
                                        TextFieldDatePicker(
                                            Controller: _StartDate,
                                            onChanged: null,
                                            validating: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please select Start Date ';
                                              } else {
                                                return null;
                                              }
                                            },
                                            onTap: () async {
                                              FocusScope.of(context).unfocus();
                                              DateTime? pickdate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(1950),
                                                      lastDate: DateTime.now());
                                              if (pickdate != null) {
                                                String formatdate =
                                                    DateFormat("dd/MM/yyyy")
                                                        .format(pickdate!);
                                                if (mounted) {
                                                  setState(() {
                                                    _StartDate.text = formatdate;
                                                    print(_StartDate.text);
                                                  });
                                                }
                                              }
                                            },
                                            hintText: 'dd/MM/yyyy', isDownArrow: true),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: isCurrentCompany == false
                                        ? Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Title_Style(
                                                    Title: 'End Date',
                                                    isStatus: true),
                                                TextFieldDatePicker(
                                                    Controller: _EndDate,
                                                    onChanged: null,
                                                    validating: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please select End Date';
                                                      } else if (_StartDate.text.isEmpty) {
                                                        return 'Please select Start Date first';
                                                      } else {
                                                        DateTime startDate = DateFormat("dd/MM/yyyy").parse(_StartDate.text);
                                                        DateTime endDate = DateFormat("dd/MM/yyyy").parse(value);
                                                        if (endDate.isBefore(startDate)) {
                                                          return 'End date cannot be before\nstart date';
                                                        } else if (endDate.isAtSameMomentAs(startDate)) {
                                                         return 'End date cannot be the same as\nstart date';
                                                        }
                                                      }
                                                      return null;
                                                    },
                                                    onTap: () async {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      DateTime? pickdate =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime.now(),
                                                              firstDate:
                                                                  DateTime(1950),
                                                              lastDate:
                                                                  DateTime.now());
                                                      if (pickdate != null) {
                                                        String formatdate =
                                                            DateFormat(
                                                                    "dd/MM/yyyy")
                                                                .format(
                                                                    pickdate!);
                                                        if (mounted) {
                                                          setState(() {
                                                            _EndDate.text =
                                                                formatdate;
                                                            print(_EndDate.text);
                                                          });
                                                        }
                                                      }
                                                    },
                                                    hintText: 'dd/MM/yyyy', isDownArrow: true),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            child: Column(
                                              children: [
                                                //Notice Period
                                                Title_Style(
                                                    Title:
                                                        'Notice Period in days',
                                                    isStatus: true),
                                                textFormField(
                                                  hintText: 'Notice Period',
                                                  keyboardtype:
                                                      TextInputType.number,
                                                  inputFormatters: null,
                                                  Controller: _NoticePeriod,
                                                  validating: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Please Enter Valid days";
                                                    }
                                                    if (value == null) {
                                                      return "Please Enter Valid days";
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: null,
                                                ),
                                              ],
                                            ),
                                          )),
                              ],
                            ),

                            // //Notice Period
                            // Title_Style(Title: 'Notice Period', isStatus: false),
                            // textFormField(
                            //   hintText: 'Notice Period',
                            //   keyboardtype: TextInputType.text,
                            //   inputFormatters: null,
                            //   Controller: _NoticePeriod,
                            //   validating: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "Please Enter Valid ${'Notice Period'}";
                            //     }
                            //     if (value == null) {
                            //       return "Please Enter Valid ${'Notice Period'}";
                            //     }
                            //     return null;
                            //   },
                            //   onChanged: null,
                            // ),

                            //DESCRIPTION
                            Title_Style(Title: 'Enter Your Job Profile', isStatus: true),
                            textfieldDescription(
                              Controller: _Description,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Write ${'Job Profile'}";
                                }
                                else if (value == null) {
                                  return "Please Write ${'Job Profile'}";
                                }
                                return null;
                              }, hintText: 'About Job Profile',
                            ),

                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25), color: white1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [

                            //Institute
                            Title_Style(
                                Title: 'Name of  University / Institute',
                                isStatus: true),
                            dropDownSearchFieldCollege(
                              context,
                              listValue: collegeVal,
                              onChanged: ((x) {
                                _focusNode.unfocus();

                                setState(() {
                                  DropDownData result = collegeVal.firstWhere(
                                      (value) =>
                                          value.collegeName == x.searchKey);

                                  // Print the result
                                  print(result.id);

                                  collegeption = x.searchKey;
                                  collegeption_id = result.id;
                                });
                              }),
                              focus: _focusNode,
                              validator: (x) {
                                if (x!.isEmpty) {
                                  return 'Please Select Institute';
                                }
                                return null;
                              },
                              hintT: 'Search Institute',
                              searchText: (SearchValue) {
                                collegeption = SearchValue;
                              },
                            ),

                            //Qualification*
                            Title_Style(Title: 'Qualification', isStatus: true),
                            dropDownSearchField(
                              context,
                              listValue: qualificationVal,
                              onChanged: ((x) {
                                focus3.unfocus();

                                setState(() {
                                  DropDownData result = qualificationVal
                                      .firstWhere((value) => value.qualification == x.searchKey);

                                  // Print the result
                                  print(result.id);

                                  qualificationOption = result.qualification;
                                  qualificationOption_id = result.id;

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


                            //Specialization
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
                            ),

                            // textFormField(
                            //   hintText: 'Specialization',
                            //   keyboardtype: TextInputType.text,
                            //   inputFormatters: null,
                            //   Controller: _Specialization,
                            //   validating: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "Please Enter Valid ${'Specialization'}";
                            //     }
                            //     if (value == null) {
                            //       return "Please Enter Valid ${'Specialization'}";
                            //     }
                            //     return null;
                            //   },
                            //   onChanged: null,
                            // ),
                            //Education Type
                            Title_Style(Title: 'Education Type', isStatus: true),
                            dropDownField(
                              context,
                              value: selectedOption,
                              listValue: EductiontypeList,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedOption = newValue;
                                });
                              },
                              hintText: '  Select Your Education Type',
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Please Select Education Type';
                              //   }
                              //   return null;
                              // },
                            ),
                            //PERCENTAGE/CGPA
                            Title_Style(
                                Title: 'Percentage / CGPA', isStatus: true),
                            textFormField(
                              hintText: 'CGPA',
                              keyboardtype: TextInputType.number,
                              inputFormatters: null,
                              Controller: _CGPA,
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
                            ),

                            //Course duration
                            Title_Style(
                                Title: 'Course duration', isStatus: true),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _durationText(title: 'Starting Year & Month'),
                                        TextFieldDatePicker(
                                          Controller: _StartD,
                                          onChanged: null,
                                          validating: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please select Start Date';
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            FocusScope.of(context).unfocus();
                                            DateTime? pickdate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime.now(),
                                            );
                                            if (pickdate != null) {
                                              String formatdate = DateFormat("dd/MM/yyyy").format(pickdate);
                                              if (mounted) {
                                                setState(() {
                                                  _StartD.text = formatdate;
                                                  print(_StartD.text);
                                                });
                                              }
                                            }
                                          },
                                          hintText: 'dd/MM/yyyy', isDownArrow: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _durationText(title: 'Ending Year & Month'),
                                        TextFieldDatePicker(
                                          Controller: _EndD,
                                          onChanged: null,
                                          validating: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please select End Date';
                                            } else if (_StartD.text.isEmpty) {
                                              return 'Please select Start Date first';
                                            } else {
                                              DateTime startDate = DateFormat("dd/MM/yyyy").parse(_StartD.text);
                                              DateTime endDate = DateFormat("dd/MM/yyyy").parse(value);
                                              if (endDate.isBefore(startDate)) {
                                                return 'End date cannot be before start date';
                                              } else if (endDate.isAtSameMomentAs(startDate)) {
                                                return 'End date cannot be the same as start date';
                                              }
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            FocusScope.of(context).unfocus();
                                            DateTime? pickdate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2050),
                                            );
                                            if (pickdate != null) {
                                              String formatdate = DateFormat("dd/MM/yyyy").format(pickdate);
                                              if (mounted) {
                                                setState(() {
                                                  _EndD.text = formatdate;
                                                  print(_EndD.text);
                                                });
                                              }
                                            }
                                          },
                                          hintText: 'dd/MM/yyyy', isDownArrow: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
                child: CommonElevatedButton(
                  context,
                  "Add",
                  widget.isType == true
                      ? () {
                    if(_formKey.currentState!.validate()){
                      if(typeVal == null){
                        ShowToastMessage(
                            "Please Select Work Type");
                      }else if(_value == null){
                        ShowToastMessage(
                            "Please Select the Current Company");
                      }
                      else{
                        final editedDetail = EmpDetail(
                          _JobRole.text,
                          _CompanyName.text,
                          _StartDate.text,
                          _EndDate.text,
                          _NoticePeriod.text,
                          typeVal == 0?"Full Time":typeVal == 1?"Part Time":"Intern",
                          _Description.text,
                          _value ?? 0,

                        );
                        Navigator.pop(context, editedDetail);
                      }
                    }
                  }
                      : () {
                    print("SPECILIZATION ${ specializationOption ?? []}");
                    if(_formKey.currentState!.validate()){
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
                      if(selectedOption == null){
                        ShowToastMessage(
                            "Please Select Education Type");
                      }else if (specializationOption == []){
                        ShowToastMessage("Please");
                      }

                      else if(specializationOption == []){
                        ShowToastMessage(
                            "Please Select Specialization");
                      }
                      else{
                        final eduHistoryDetail = EducationDetail(
                            collegeption ?? "",
                            collegeption_id ?? "",
                            qualificationOption ?? "",
                            qualificationOption_id ?? "",
                            specializationOption ?? [],
                            getSpecializationID.join(', '),
                            selectedOption ?? "",
                            _CGPA.text,
                            _StartD.text,
                            _EndD.text);
                        Navigator.pop(context, eduHistoryDetail);
                      }

                    }
                    },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _RadioButton() {
    return RadioButton(
        groupValue1: _value,
        onChanged1: (value1) {
          setState(() {
            _value = value1;
            isCurrentCompany = true;
            print("Yes");
          });
        },
        radioTxt1: "Yes",
        groupValue2: _value,
        onChanged2: (value2) {
          setState(() {
            _value = value2;
            isCurrentCompany = false;
            print("No");
          });
        },
        radioTxt2: 'No');
  }
}

//PROFILE TITLE
Widget _profileTitle({required String title}) {
  return Container(
      margin: EdgeInsets.only(top: 30, bottom: 10),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: profileTitle,
      ));
}

Widget _durationText({required String title}) {
  return Container(
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: durationT,
      ));
}
