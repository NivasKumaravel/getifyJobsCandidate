import 'package:flutter/material.dart';

import '../utilits/Common_Colors.dart';
import '../utilits/Text_Style.dart';
import 'Common_Button.dart';
import 'Pdf_Picker.dart';

Widget ShowModalBottomSheet(context, {required void Function()? onPress }) {
  return Container(
    width: MediaQuery
        .of(context)
        .size
        .width,
    decoration: BoxDecoration(
      color: white1,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(
          top: 20, right: 20, left: 20, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Icon(Icons.cancel),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Upload Resume to Apply!",
            style: bluetxt1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Upload your resume now, and we'll seamlessly add it to your profile. Remember, exclude personal contact details. Let's get you closer to your dream job!",
              style: desctxt,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              height: 110,
              child: PdfPickerExample(
                optionalTXT: '', isProfile: false, isCancelNeed: true,
              )),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(
                top: 20, bottom: 20),
            child: Container(
                height: 45,
                width: 200,
                child: CommonElevatedButton(
                    context, " Apply Job", onPress)),
          ),
        ],
      ),
    ),
  );
}