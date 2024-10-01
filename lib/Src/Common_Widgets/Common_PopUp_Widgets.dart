import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';
import 'Common_Button.dart';


//PROFILE DETAIL BACK POP UP
Widget Profile_Back_Pop_Up(BuildContext context,{required void Function()? BackonPress,
  required void Function()? SaveonPress,}) {
  return AlertDialog(
    surfaceTintColor: white1,
    content:Container(
      color: white1,
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Are You Sure Want to Leave this Page",style: Wbalck1,textAlign: TextAlign.center,),

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: MediaQuery.sizeOf(context).width/3.5,
                    child: PopButton(context, "Back", BackonPress)),
                Container(
                    width: MediaQuery.sizeOf(context).width/3.5,
                    child: PopButton(context, "Save", SaveonPress)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


//PROFILE DETAIL BACK POP UP
Widget Profile_Save_Pop_Up(BuildContext context,{
  required void Function()? SaveonPress,}) {
  return AlertDialog(
    surfaceTintColor: white1,
    content:Container(
      color: white1,
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Are you sure do you want to save?",style: Wbalck1,textAlign: TextAlign.center,),

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: MediaQuery.sizeOf(context).width/3.5,
                    child: PopButton(context, "Cancel", (){
                      Navigator.pop(context);
                    })),
                Container(
                    width: MediaQuery.sizeOf(context).width/3.5,
                    child: PopButton(context, "Save", SaveonPress)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
