import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';

import '../utilits/Text_Style.dart';
import 'Image_Path.dart';
import 'Text_Form_Field.dart';

TextStyle getStatusTextStyle(String status) {
  switch (status) {
    case "Schedule Rejected":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(255, 0, 13, 1),
          fontWeight: FontWeight.w500);
    case "Rejected":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(255, 0, 13, 1),
          fontWeight: FontWeight.w500);
    case "Schedule Requested":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(0, 160, 226, 1),
          fontWeight: FontWeight.w500);
    case "Applied":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(0, 160, 226, 1),
          fontWeight: FontWeight.w500);
    case "Recruiter Rescheduled":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(245, 245, 245, 1),
          fontWeight: FontWeight.w500);
    case "Candidate Rescheduled":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(245, 245, 245, 1),
          fontWeight: FontWeight.w500);
    case "Interview Rescheduled":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(245, 245, 245, 1),
          fontWeight: FontWeight.w500);
    case "Not Attended":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(245, 245, 245, 1),
          fontWeight: FontWeight.w500);
    case "Schedule Accepted":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(61, 186, 40, 1),
          fontWeight: FontWeight.w500);
    case "Selected":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color.fromRGBO(61, 186, 40, 1),
          fontWeight: FontWeight.w500);
    case "Wait List":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: orange4,
          fontWeight: FontWeight.w500);
    default:
      return TextStyle(color: Colors.black);
  }
}

String getStatusText(String status) {
  switch (status) {
    case "Schedule Cancelled":
      return "Schedule Cancelled";
    case "Rejected":
      return "Rejected";
    case "Schedule Requested":
      return "Schedule Requested";
    case "Selected":
      return "Selected";
    case "Not Attended":
      return "Not Attended";
    case "Recruiter Rescheduled":
      return "Recruiter Rescheduled";
    case "Schedule Accepted":
      return "Schedule Accepted";
    case "Wait List":
      return "Wait List";
    default:
      return "Default Status";
  }
}
//NO DATA WIDGET
Widget NoDataWidget({required String content}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(child: Container(
        height: 200,
          width: 200,
          child: ImgPathSvg('nodata.svg'))),
      SizedBox(
        height: 10,
      ),
      Center(
          child: Text(
        content,
        style: TitleT,
      ))
    ],
  );
}

//DIRECT LIST
Widget DirectList(
  context, {
  required bool? isStudent,
  required bool? isApplied,
  required String? campusTag,
  required String jobName,
  required String companyName,
  required String location,
  required String companyLogo,
  required String YOP,
  required String ExpSalary,
  required String postedDate,
  required String collegeName,
  required String appliedDate,
  required String collegeLoctaion,
  required String collegeLogo,
  required bool isCampus,
  required int currentIndex,
  required bool bookmark,
  required Function(int)? bookmarkClick,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top: 15, left: 20, right: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white, // Set the color here
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width/1.2,
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              jobName,
              style: TitleT1,maxLines: 2,overflow:TextOverflow.ellipsis,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: buildCompanyInfoRow1(companyLogo, companyName, TBlack, 50, 50,
              isMapLogo: false),
        ),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle("map-pin.svg", location, Homegrey2, 20, 20)),
        isCampus == true
            ? Container()
            : Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: collegeRowTitle("bag.svg", YOP, Homegrey2, 20, 20)),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle("wallet.svg", ExpSalary, Homegrey2, 20, 20)),
        isStudent == true
            ? Container()
            : Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Applied Date : ${appliedDate}",
                      style: Homegrey2,
                    ),
                  ],
                )),
        Container(
          margin: EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isApplied == true
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: campusTag == "Applied"
                            ? blue2
                            : campusTag == "Rejected"
                            ? red4
                            : campusTag == "Selected"
                            ? green3
                            : campusTag == "Final Round"
                            ? green3
                            : campusTag == "Call For Interview"
                            ? yellow2
                            : green3,
                      ),
                      child:
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              campusTag == "Applied"
                                  ? "Applied":
                              campusTag == "Rejected"?
                              "Rejected"
                                  :
                              campusTag == "Final Round"?
                              "Final Round"
                                  :
                              campusTag == "Selected"?
                              "Selected":
                              campusTag == "Call For Interview"?
                              "Call For Interview":
                              "${campusTag}",
                              style:
                              TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: campusTag == "Selected"
                                      ? green1:
                                  campusTag == "Final Round"
                                      ? green1
                                      : campusTag == "Call For Interview"
                                      ? yellow1
                                      : campusTag == "Rejected"
                                      ? red1
                                      : campusTag == "Applied"
                                      ? blue1
                                      : green1),

                            ),
                          )),
                    )
                  : Text(postedDate, style: decpgrey2),
              isApplied == true
                  ? Container()
                  : InkWell(
                      onTap: () {
                        bookmarkClick?.call(currentIndex);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: ImgPathSvgWithColor(bookmark)),
                    ),
            ],
          ),
        ),
        isStudent == true
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  height: 0,
                  thickness: 2,
                  color: white2,
                ),
              ),
        isStudent == true
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: buildCompanyInfoRow1(
                    collegeLogo, collegeName, TBlack, 50, 50,
                    isMapLogo: false),
              ),
        isStudent == true
            ? Container()
            : Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 15),
                child: collegeRowTitle(
                    "map-pin (1).png", collegeLoctaion, Homegrey2, 20, 20)),
      ],
    ),
  );
}

//CANDIDATE MY APPLIES lIST
Widget Candidate_MyApplies_List(context,
    {required bool? isApplied,
    required String jobName,
    required String companyName,
    required String location,
    required String companyLogo,
    required String status,
    required String YOP,
    required String ExpSalary,
    required String postedDate,
    required String collegeName,
    required String appliedDate}) {
  Color containerColor; // Define a variable to hold the container color

  switch (status) {
    case "Schedule Rejected":
      containerColor = pink3;
      break;
    case "Rejected":
      containerColor = pink3;
      break;
    case "Schedule Requested":
      containerColor = blue2;
      break;
    case "Applied":
      containerColor = blue2;
      break;
    case "Recruiter Rescheduled":
      containerColor = grey4;
      break;
    case "Candidate Rescheduled":
      containerColor = grey4;
      break;
    case "Interview Rescheduled":
      containerColor = grey4;
      break;
    case "Not Attended":
      containerColor = grey4;
      break;
    case "Schedule Accepted":
      containerColor = green3;
      break;
    case "Selected":
      containerColor = green3;
      break;
    case "Wait List":
      containerColor = orange3;
      break;
    default:
      containerColor = Colors.black;
      break;
  }
  TextStyle getStatusTextStyle(String status) {
    switch (status) {
      case "Schedule Rejected":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(255, 0, 13, 1),
            fontWeight: FontWeight.w500);
      case "Rejected":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(255, 0, 13, 1),
            fontWeight: FontWeight.w500);
      case "Schedule Requested":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(0, 160, 226, 1),
            fontWeight: FontWeight.w500);
      case "Applied":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(0, 160, 226, 1),
            fontWeight: FontWeight.w500);
      case "Recruiter Rescheduled":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(245, 245, 245, 1),
            fontWeight: FontWeight.w500);
      case "Candidate Rescheduled":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(245, 245, 245, 1),
            fontWeight: FontWeight.w500);
      case "Interview Rescheduled":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(245, 245, 245, 1),
            fontWeight: FontWeight.w500);
      case "Not Attended":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(245, 245, 245, 1),
            fontWeight: FontWeight.w500);
      case "Schedule Accepted":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(61, 186, 40, 1),
            fontWeight: FontWeight.w500);
      case "Selected":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color.fromRGBO(61, 186, 40, 1),
            fontWeight: FontWeight.w500);
      case "Wait List":
        return TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: orange4,
            fontWeight: FontWeight.w500);
      default:
        return TextStyle(color: Colors.black);
    }
  }

  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top: 15, left: 20, right: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white, // Set the color here
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width/1.2,
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              jobName,
              style: TitleT,maxLines: 2,overflow: TextOverflow.ellipsis,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: buildCompanyInfoRow1(companyLogo, companyName, TBlack, 50, 50,
              isMapLogo: false),
        ),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle(
                "map-pin.svg", location, Homegrey2, 20, 20)),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle("bag.svg", YOP, Homegrey2, 20, 20)),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child:
                collegeRowTitle("wallet.svg", ExpSalary, Homegrey2, 20, 20)),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Row(
              children: [
                Text(
                  "Applied Date : ${appliedDate}",
                  style: Homegrey2,
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isApplied == true
                  ? Text(postedDate, style: decpgrey2)
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: containerColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                            child: Text(
                              status,
                          style: getStatusTextStyle(status),
                        )),
                      ),
                    ),
            ],
          ),
        ),
      ],
    ),
  );
}

//CAMPUS LIST
Widget CampusList(
    context,
    {required String? isTag,
    required String? iscampTag,
    required String jobName,
    required String companyLogo,
    required String companyName,
    required String collegeName,
    required String collegeLogo,
    required String companyLocation,
    required String collegeLocation,
    required bool? isUsed,
    required bool? isCountNeeded,
      required String applyCount,
    required void Function()? onTap}) {
  return Container(
      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white, // Set the color here
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isUsed == true
              ? Column(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width/1.2,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          jobName,
                          style: TitleT,maxLines: 2,overflow: TextOverflow.ellipsis,
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: buildCompanyInfoRow1(
                          companyLogo, collegeName, TBlack, 50, 50,
                          isMapLogo: false),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                        child: buildCompanyInfoRow("map-pin (1).png",
                            companyLocation, Homegrey2, 20, 20,
                            isMapLogo: true)),
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 15, right: 20, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: isTag == "Applied" ? blue2 : green3,
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              child: Text(
                                isTag == "Applied" ? 'Applied' : 'Shortlisted',
                                style: isTag == "Applied"
                                    ? appliedT
                                    : shortlistedT,
                              ),
                            )),
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 15),
                              child: ImgPathSvg("tag.svg")),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: collegeRowTitle1(
                          collegeLogo, collegeName, TBlack, 50, 50),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: 20, top: 10, right: 20, bottom: 15),
                        child: buildCompanyInfoRow("map-pin (1).png",
                            collegeLocation, Homegrey2, 20, 20,
                            isMapLogo: true)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: onTap,
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(left: 20, bottom: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: iscampTag == "On campus"
                                    ? blue2
                                    : iscampTag == "Applied"
                                        ? blue2
                                        : iscampTag == "Assigned"
                                            ? green3
                                            : iscampTag == "Off campus"
                                                ? white2
                                                : white1),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              child: Text(
                                iscampTag == "On campus"
                                    ? 'On Campus'
                                    : iscampTag == "Off campus"
                                        ? 'Off Campus'
                                        : iscampTag == "Applied"
                                            ? 'Applied'
                                            : iscampTag == "Assigned"
                                                ? 'Assigned'
                                                : '',
                                style: iscampTag == "Applied"
                                    ? appliedT
                                    : iscampTag == "Assigned"
                                        ? shortlistedT
                                        : iscampTag == "On campus"
                                            ? appliedT
                                            : iscampTag == "Off campus"
                                                ? offCampusT
                                                : offCampusT,
                              ),
                            )),
                          ),
                        ),
                        isCountNeeded == true? const Spacer():Container(),
                        isCountNeeded == true?Icon(Icons.person,color: blue1,):Container(),
                        isCountNeeded == true?Text(applyCount,style: TBlack,):Container(),
                        isCountNeeded == true?const SizedBox(width: 20,):Container(),
                      ],
                    ),
                  ],
                )
        ],
      ));
}

Widget cards(
    context,
    {required String countTxt,
    required String txt,
    required Color Ccolor,
    required TextStyle txtStyle}) {
  return Container(
    height: 90,
    width: MediaQuery.sizeOf(context).width/2.5,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: white1),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 7),
          child: Text(
            countTxt,
            style: count,
          ),
        ),
        Container(
          height: 23,
          width: 165,
          color: Ccolor,
          child: Center(
              child: Text(
            txt,
            style: txtStyle,
          )),
        ),
      ],
    ),
  );
}

//APPLIES LIST
Widget AppliesList(context,
    {required String CandidateImg,
    required String CandidateName,
    required String Jobrole,
    required Color? color,
    required bool? isWeb}) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: Row(
        children: [
          Candidate_Img(ImgPath: CandidateImg),
          isWeb == true
              ? Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 15, right: 10),
                        // width: MediaQuery.of(context).size.width/1.5,
                        child: Text(
                          CandidateName,
                          style: appliesT,
                        )),
                    Container(
                        // width: MediaQuery.of(context).size.width/1.5,
                        child: Text(
                      "($Jobrole)",
                      style: positionT1,
                      maxLines: 2,
                    )),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          // width: MediaQuery.of(context).size.width/1.5,
                          child: Text(
                        CandidateName,
                        style: appliesT,
                      )),
                      Container(
                          // width: MediaQuery.of(context).size.width/1.5,
                          child: Text(
                        Jobrole,
                        style: positionT,
                        maxLines: 2,
                      )),
                    ],
                  ),
                )
        ],
      ),
    ),
  );
}

//APPLIES LIST
Widget AppliesListWithTag(
  context, {
  required String CandidateImg,
  required String CandidateName,
  required String Jobrole,
  required String round,
  required Color? color,
}) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: Row(
        children: [
          Candidate_Img(ImgPath: CandidateImg),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    // width: MediaQuery.of(context).size.width/1.5,
                    child: Text(
                  CandidateName,
                  style: appliesT,
                )),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text(
                          Jobrole,
                          style: positionT,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      height: 20,
                      width: 72,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: grey8),
                      child: Center(
                          child: Text(
                        round,
                        style: positionT,
                      )),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget customListItem({
  required String badgeText,
  required String appliedRole,
  required String interviewTime,
  required String status,
  required TextStyle badgeTextStyle,
  required TextStyle countTextStyle,
  required TextStyle interviewTimeTextStyle,
  required Color statusColor,
  required bool isWeb,
}) {
  Color containerColor; // Define a variable to hold the container color

  switch (status) {
    case "Schedule Cancelled":
      containerColor = pink3;
      break;
    case "Rejected":
      containerColor = pink3;
      break;
    case "Schedule Requested":
      containerColor = blue2;
      break;
    case "Reschedule Requested":
      containerColor = grey4;
      break;
    case "Not Attended":
      containerColor = grey4;
      break;
    case "Schedule Accepted":
      containerColor = green3;
      break;
    case "Selected":
      containerColor = green3;
      break;
    case "Wait List":
      containerColor = orange3;
      break;
    default:
      containerColor = Colors.black;
      break;
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: white1, // Use the variable to set the color
    ),
    margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: AssetImage("lib/assets/personicon.jpg"),
                        fit: BoxFit.cover)),
              ),
              isWeb == true
                  ? Row(
                      children: [
                        //NAME
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Text(badgeText, style: badgeTextStyle),
                        ),
                        //JOB ROLE
                        Container(
                          child: Text("($appliedRole)", style: positionT1),
                        ),
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NAME
                          Text(badgeText, style: badgeTextStyle),
                          //JOB ROLE
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(appliedRole, style: countTextStyle),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Divider(
          color: white2,
          height: 0,
          thickness: 2,
        ),
        isWeb == true
            ? Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 10, right: 15, left: 15),
                child: Row(
                  children: [
                    Container(
                      child: Text("Interview Scheduled on: ", style: Wbalck1),
                    ),
                    Container(
                      child: Text(interviewTime, style: Wbalck0),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(color: containerColor),
                      child: Text(getStatusText(status),
                          style: getStatusTextStyle(status)),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Text("Interview Scheduled on: ",
                        style: interviewTimeTextStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 2, bottom: 10),
                          child: Text(interviewTime, style: Wbalck),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(color: containerColor),
                          margin: EdgeInsets.only(right: 5, bottom: 10),
                          child: Text(getStatusText(status),
                              style: getStatusTextStyle(status)),
                        ),
                      ],
                    ),
                  ),
                ],
              )
      ],
    ),
  );
}



Widget DirectList1(
  context, {
  required bool? isApplied,
  required String jobName,
  required String companyName,
  required String location,
  required String companyLogo,
  required String collegeName,
  required String collegeLogo,
  required String collegeLoaction,
  required String posteddate,
  required String ExpSalary,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top: 15, left: 20, right: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white, // Set the color here
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              jobName,
              style: TitleT,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: buildCompanyInfoRow1(companyLogo, companyName, TBlack, 50, 50,
              isMapLogo: false),
        ),
        isApplied == false
            ? Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: collegeRowTitle(
                    "map-pin (1).png", location, Homegrey2, 20, 20))
            : Container(
                margin: EdgeInsets.only(left: 20),
                height: 20,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: yellow3,
                ),
                child: Center(
                    child: Text(
                  'Pending',
                  style: RecYellow,
                )),
              ),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child:
                collegeRowTitle("walletpng.png", ExpSalary, Homegrey2, 20, 20)),
        Container(
          margin: EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isApplied == true
                  ? Text("Posted: 23 Sep 2023", style: decpgrey2)
                  : Container(
                      height: 20,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: blue2,
                      ),
                      child: Center(
                          child: Text(
                        'Pending',
                        style: appliedT,
                      )),
                    ),
            ],
          ),
        ),
        isApplied == true
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  height: 0,
                  thickness: 2,
                  color: white2,
                ),
              ),
        isApplied == true
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: buildCompanyInfoRow1(
                    collegeLogo, collegeName, TBlack, 50, 50,
                    isMapLogo: false),
              ),
        isApplied == true
            ? Container()
            : Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 15),
                child: collegeRowTitle(
                    "Pin.svg", collegeLoaction, Homegrey2, 20, 20)),
      ],
    ),
  );
}

Widget CampusList2({
  required String? isTag,
  required String? iscampTag,
  required bool? isUsed,
  required bool isOnCampus,
  required String companyName,
  required String companyLogo,
  required String companyLocation,
}) {
  Color campTagColor;
  TextStyle campTagTextStyle;
  switch (iscampTag) {
    case "OnCampus":
      campTagColor = blue2;
      campTagTextStyle = isOnCampus
          ? TextStyle(color: Colors.blue)
          : TextStyle(color: Colors.black);
      break;
    case "OffCampus":
      campTagColor = white2;
      campTagTextStyle = TextStyle(color: Colors.black);
      break;
    case "Applied": // Added case for "Applied"
      campTagColor = blue2; // Assuming appliedColor is defined
      campTagTextStyle = appliedT; // Assuming appliedT is defined
      break;
    default:
      campTagColor = Colors.transparent;
      campTagTextStyle = TextStyle();
      break;
  }
  return Container(
    margin: EdgeInsets.only(right: 20, left: 20, top: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isUsed == true)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child:
                    collegeRowTitle1(companyLogo, companyName, TBlack, 50, 50),
              ),
              Container(
                  margin:
                      EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 15),
                  child: buildCompanyInfoRow(
                      "map-pin (1).png", companyLocation, Homegrey2, 20, 20,
                      isMapLogo: true)),
              Container(
                width: 100,
                margin: EdgeInsets.only(left: 22, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: campTagColor,
                ),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        isOnCampus
                            ? 'On Campus'
                            : (isTag == 'Applied' ? 'Applied' : 'Off Campus'),
                        style: campTagTextStyle,
                      )),
                ),
              ),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (Your existing code)
              Container(
                width: 100,
                margin: EdgeInsets.only(left: 20, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: campTagColor,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      isOnCampus ? 'On Campus' : 'Off Campus',
                      style: campTagTextStyle,
                    ),
                  ),
                ),
              ),
              isTag == "Applied"
                  ? Text(
                      'Applied',
                      style: appliedT,
                    )
                  : Container()
            ],
          )
      ],
    ),
  );
}

Widget buildCompanyInfoRowNotifacation(
  context, {
  required String jobName,
  required String name,
  required String Date,
  required String Time,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      // width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width/1.8,
                child: Text(
                  name,
                  style: appliesT,
                  maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Text(
                Date,
                style: attacht1,
                maxLines: 2,
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Text(
              jobName,
              style:
                  Homegrey, // You can use the same style as the company name or customize it as needed
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

//CANDIDATE JOB List SCREEN
Widget NoOfCandidatesSection(
  BuildContext context, {
  required String jobName,
  required String noOfCandidates,
  required String postedDate,
  required bool isWeb,
  required String status,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
    child: Container(
      // height: 115,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: isWeb == true
              ? BorderRadius.circular(5)
              : BorderRadius.circular(10),
          color: white1),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    jobName,
                    style: pdfT,
                  ),
                ),
                Spacer(),
                isWeb == true
                    ? Text(
                        postedDate,
                        style: Wgrey,
                      )
                    : Container(),
              ],
            ),
            status == "Pending"
                ? Container(
                    height: 25,
                    width: 100,
                    // margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: orange3),
                    child: Center(
                        child: Text(
                      "Pending",
                      style: orange,
                    )),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      noOfCandidates,
                      style: noOfCandidatesStyle,
                    ),
                  ),
            isWeb == false
                ? Text(
                    postedDate,
                    style: Wgrey,
                  )
                : Container(),
          ],
        ),
      ),
    ),
  );
}


//INBOX LIST
Widget Inbox_List(context,{
  required String CompanyLogo,
  required String CompanyName,
  required String jobTitle,
  required String Location,
  required String status,
}){
  Color containerColor; // Define a variable to hold the container color

  switch (status) {
    case "Schedule Rejected":
      containerColor = pink3;
      break;
    case "Rejected":
      containerColor = pink3;
      break;
    case "Schedule Requested":
      containerColor = blue2;
      break;
    case "Applied":
      containerColor = blue2;
      break;
    case "Recruiter Rescheduled":
      containerColor = grey4;
      break;
    case "Candidate Rescheduled":
      containerColor = grey4;
      break;
    case "Interview Rescheduled":
      containerColor = grey4;
      break;
    case "Not Attended":
      containerColor = grey4;
      break;
    case "Schedule Accepted":
      containerColor = green3;
      break;
    case "Selected":
      containerColor = green3;
      break;
    case "Wait List":
      containerColor = orange3;
      break;
    default:
      containerColor = Colors.black;
      break;
  }
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: white1),
    child: Padding(
      padding: const EdgeInsets.only(
          left: 20, right: 20, top: 13, bottom: 13),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(right: 10),
            // child: ImgPathSvg(companylogo),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                  image: NetworkImage(
                      CompanyLogo),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width/1.8,
                child: Text(
                  CompanyName,
                  style: inboxcompany,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width/1.8,
                child: Text(
                  jobTitle,
                  style: inboxJobTitle,
                ),
              ),
              Row(
                children: [
                  ImgPathSvg("map-pin.svg"),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width/2,
                    child: Text(
                      Location,
                      style: Homegrey2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(color: containerColor),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(status,
                      style: getStatusTextStyle(status)),
                ),
              ),
              const SizedBox(height: 5,),
            ],
          ),
          //COMPANY NAME AND LOCATION
        ],
      ),
    ),
  );

}