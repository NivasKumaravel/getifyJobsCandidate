import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// PNG IMAGE PATH
Widget ImgPathPng(String pathPNG) {
  return Image(image: AssetImage("lib/assets/${pathPNG}"));
}

// SVG IMAGE PATH

Widget ImgPathSvg(String pathSVG) {
  return SvgPicture.asset("lib/assets/${pathSVG}");
}

Widget ImgPathSvgWithColor(bool bookmark) {
  if (bookmark == true) {
    return SvgPicture.asset(
      "lib/assets/tag_blue.svg",
      color: Colors.blue,
    );
  } else {
    return SvgPicture.asset("lib/assets/tag.svg");
  }
}

// Logo Image
Widget LoginScreenImage(context) {
  return Container(
    height: MediaQuery.sizeOf(context).height/4,
    width: MediaQuery.sizeOf(context).width/1.2,
      child: ImgPathSvg("LoginscreenImg.svg"));
}

Widget Logo(context) {
  return Container(
    height: MediaQuery.sizeOf(context).height/5,
    width: MediaQuery.sizeOf(context).width/1.2,
      child: ImgPathSvg("logo.svg"));
}

//CANDIDATE IMAGE

Widget Candidate_Img({required String ImgPath}) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
            image: AssetImage("lib/assets/$ImgPath"), fit: BoxFit.cover)),
  );
}

// PROFILE IMG
Widget profileImg({required String ProfileImg}) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 20, bottom: 11),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image:
              DecorationImage(image: AssetImage('lib/assets/${ProfileImg}'))),
    ),
  );
}

Widget profileImg1({required String ProfileImg}) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 20, bottom: 11),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(image: NetworkImage('${ProfileImg}'),
          fit: BoxFit.cover),
      ),
    ),
  );
}
