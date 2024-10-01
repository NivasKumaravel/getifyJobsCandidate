import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Login_Screens/Login_Page.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilits/Common_Colors.dart';
import '../utilits/Text_Style.dart';
import 'Image_Path.dart';

// LOGOUT BUTTON
Widget LogOutButton(BuildContext context,{required void Function()? onTap, }) {
  return InkWell(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) => LogOutPopup(context, onTap: onTap),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: red2
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          "Log Out",
          style: logOutT,
        ),
      ),
    ),
  );
}

//LOGOUT POPUP
Widget LogOutPopup(BuildContext context,{required void Function()? onTap,
}) {
  return AlertDialog(
    surfaceTintColor: white1,
    content: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Logout Account",
            style: Wbalck3,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Do you want to logout for sure?",
            style: companyT,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Wbalck3,
                  )),
              InkWell(
                onTap: onTap,
                child: Text(
                  "Confirm",
                  style: logOutStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ELEVATED BUTTON
Widget CommonElevatedButton(
  BuildContext context,
  String titleName,
  void Function()? onPress,
) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: blue1,
      minimumSize: Size(double.infinity, 50),
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: ButtonT,
    ),
  );
}

// POP BUTTON
Widget PopButton(
    BuildContext context,
    String titleName,
    void Function()? onPress,
    ) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: blue1,
      minimumSize: Size(double.infinity, 45),
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: popT,
    ),
  );
}



Widget CommonElevatedButton2(
  BuildContext context,
  String titleName,
  void Function()? onPress,
) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: blue1,
      minimumSize: Size(double.infinity, 50),
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: ButtonT1,
    ),
  );
}

Widget CommonElevatedButton_No_Elevation(BuildContext context, String titleName,
    void Function()? onPress, Color btcolor, TextStyle? style) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: btcolor,
      minimumSize: Size(double.infinity, 35),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: style,
    ),
  );
}

Widget CommonElevatedButton1(BuildContext context, String titleName,
    void Function()? onPress, Color btcolor) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: btcolor,
      minimumSize: Size(double.infinity, 50),
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: ButtonT,
    ),
  );
}
// FLOATING BUTTON

Widget Floating_Button(context) {
  return SpeedDial(
    curve: Curves.bounceInOut,
    //  animatedIcon: AnimatedIcons.event_add,
    icon: Icons.add,
    iconTheme: IconThemeData(color: Colors.white),
    // animatedIconTheme: IconThemeData(color: Colors.white),
    backgroundColor: blue1,
    shape: CircleBorder(),
    children: [
      SpeedDialChild(
          // shape: CircleBorder(),
          // child: ImgPathSvg("bottomquation2.svg"),
          onTap: () {},
          label: "Single job"),
      SpeedDialChild(
          // shape: CircleBorder(),
          // child: Icon(Icons.group_add),
          onTap: () {},
          label: "Bulk job"),
    ],
  );
}

// CHECK BOX
Widget CheckBoxes(
    {required bool? value,
    required void Function(bool?)? onChanged,
    required String checkBoxText}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          activeColor: blue1,
          onChanged: onChanged,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        RadioTerms("Terms & Conditions and", " Privacy Policy", () async {
          final url = "https://getifyjobs.com/terms-and-conditions";
          await launch(
            url,
            forceSafariVC: true,
            forceWebView: true,
            enableJavaScript: true,
          );
        }, () async {
          final url = "https://getifyjobs.com/privacy-policy";
          await launch(
            url,
            forceSafariVC: true,
            forceWebView: true,
            enableJavaScript: true,
          );
        }),
      ],
    ),
  );
}

//RADIO BUTTON
Widget RadioButton(
    {required int? groupValue1,
    required int? groupValue2,
    required void Function(int?)? onChanged1,
    required void Function(int?)? onChanged2,
    required String radioTxt1,
    required String radioTxt2}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Radio(
        value: 0,
        groupValue: groupValue1,
        activeColor: blue1,
        onChanged: onChanged1,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      RadioText(radioTxt1),
      const SizedBox(
        width: 40,
      ),
      Radio(
        value: 1,
        activeColor: blue1,
        groupValue: groupValue2,
        onChanged: onChanged2,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      RadioText(radioTxt2),
    ],
  );
}

//MULTIPLE RADIO BUTTON
Widget MultiRadioButton(context,
    {required int? groupValue1,
    required int? groupValue2,
    required int? groupValue3,
    required void Function(int?)? onChanged1,
    required void Function(int?)? onChanged2,
    required void Function(int?)? onChanged3,
    required String radioTxt1,
    required String radioTxt2,
    required String radioTxt3}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio(
              value: 0,
              groupValue: groupValue1,
              activeColor: blue1,
              onChanged: onChanged1,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            RadioText(radioTxt1),
          ],
        ),
       const Spacer(),
        Row(
          children: [
            Radio(
              value: 1,
              activeColor: blue1,
              groupValue: groupValue2,
              onChanged: onChanged1,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            RadioText(radioTxt2),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio(
              value: 2,
              activeColor: blue1,
              groupValue: groupValue3,
              onChanged: onChanged3,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            Container(
                width: MediaQuery.sizeOf(context).width / 3.5,
                child: RadioText(radioTxt3)),
          ],
        ),
      ],
    ),
  );
}

//ELEVATED BOTTON
Widget AppliedButton(BuildContext context, String titleName,
    {required void Function()? onPress, required Color? backgroundColor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      minimumSize: Size(double.infinity, 50),
      // elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: ButtonT,
    ),
  );
}


//CHAT BUTTON
Widget Chat_Button(
    BuildContext context,
    void Function()? onPress,
    ){
  return InkWell(
    onTap: onPress,
    child: Container(
        height: 35,width: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: blue1
        ),
        child: Center(child: ImgPathSvg('Send.svg'))
    ),
  );
}