import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utilits/Common_Colors.dart';
import '../utilits/Text_Style.dart';
import 'Common_Button.dart';
import 'Image_Path.dart';

class Custom_AppBar extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  bool? isTitleUsed;
  bool? isUsed;
  List<Widget>? actions;
  bool? isLogoUsed;
  Custom_AppBar(
      {Key? key,
      this.title,
      required this.isUsed,
      required this.actions,
      required this.isLogoUsed,
      required this.isTitleUsed})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize; // default is 56.0
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<Custom_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      backgroundColor: white2,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black, // Navigation bar
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark // Status bar
          ),
      leading: widget.isTitleUsed == true
          ? Transform.scale(
              scale: widget.isLogoUsed == true ? 1 : 5,
              child: IconButton(
                icon: widget.isLogoUsed == true
                    ? ImgPathSvg("arrowback.svg")
                    : Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ImgPathSvg('logo.svg'),
                      ),
                onPressed: () {
                  widget.isLogoUsed == true
                      ? Navigator.of(context).pop(true)
                      : null;
                },
              ),
            )
          : Container(),
      centerTitle: true,
      actions: widget.actions,
      title: Text(
        widget.title.toString(),
        style: LoginT,
      ),
    );
  }
}

Widget BottomBar(context,
    {required String ButtonTitle,
    required Color? backgroundColor,
    required bool bookmark,
    required bool isSavedUsed,
    required void Function()? shareBtnPress,
    required void Function()? onPress,
      required void Function()? onTap
    }) {
  return Container(
    height: 90,
    width: MediaQuery.of(context).size.width,
    color: white1,
    child: Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(onTap: shareBtnPress, child: ImgPathSvg("share.svg")),
          const SizedBox(
            width: 30,
          ),
          isSavedUsed == true? InkWell(
            onTap: onTap,
              child: ImgPathSvgWithColor(bookmark)): Container(),
          Spacer(),
          Container(
              width: MediaQuery.sizeOf(context).width/2.5,
              child: AppliedButton(context, ButtonTitle,
                  backgroundColor: backgroundColor, onPress: onPress)),
        ],
      ),
    ),
  );
}

//RECRUITER WEB APP BAR
class Recruiter_Web_App_Bar extends StatefulWidget
    implements PreferredSizeWidget {
  String? title;
  bool? isTitleUsed;
  bool? isUsed;
  List<Widget>? actions;
  bool? isLogoUsed;
  Recruiter_Web_App_Bar(
      {Key? key,
      this.title,
      required this.isUsed,
      required this.actions,
      required this.isLogoUsed,
      required this.isTitleUsed})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize; // default is 56.0
  @override
  _Recruiter_Web_App_BarState createState() => _Recruiter_Web_App_BarState();
}

class _Recruiter_Web_App_BarState extends State<Recruiter_Web_App_Bar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: white2,
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black, // Navigation bar
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark // Status bar
          ),
      leading: widget.isTitleUsed == true
          ? Transform.scale(
              scale: widget.isLogoUsed == true ? 1 : 6,
              child: IconButton(
                icon: widget.isLogoUsed == true
                    ? ImgPathSvg("arrowback.svg")
                    : Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ImgPathSvg('logo.svg'),
                      ),
                onPressed: () {
                  widget.isLogoUsed == true
                      ? Navigator.of(context).pop(true)
                      : null;
                },
              ),
            )
          : Container(),
      centerTitle: true,
      actions: widget.actions,
      title: Text(
        widget.title.toString(),
        style: LoginT,
      ),
    );
  }
}
