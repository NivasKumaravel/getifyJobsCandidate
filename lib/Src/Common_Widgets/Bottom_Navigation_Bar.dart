import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Home_DasBoard/Home_Screen_Ui/Candidate_Home_Screen/Candidate_Home_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Home_DasBoard/Home_Screen_Ui/Student_Home_Screen/Student_Home_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Home_DasBoard/Inbox_Page.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Home_DasBoard/My_Applies_Screen_Ui/Student_MyApplies_Screen/Student_MyApplies_Screen.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Home_DasBoard/Profile_Ui/Profile_Screen.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import '../Candidate_Mobile_Screens/Home_DasBoard/My_Applies_Screen_Ui/Candidate_MyApplies_Screen/Candidate_MyApplies_Screen.dart';
import 'Image_Path.dart';

class Bottom_Navigation extends StatefulWidget {
  int select;
  Bottom_Navigation({Key? key,required this.select}) : super(key: key);

  @override
  State<Bottom_Navigation> createState() => _Bottom_NavigationState();
}

class _Bottom_NavigationState extends State<Bottom_Navigation> {

  final pages = [
    Student_Home_Screen(),
    Student_MyApplies_Screen(),
    Inbox_Page(),
    Profile_Screen(),
  ];

  void b(index) {
    setState(() {
      widget.select = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: pages[widget.select],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: white1,
            selectedItemColor: blue1,
            selectedLabelStyle: TextStyle(color: blue1),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: _IconImg("home.svg"),
                activeIcon: _IconImg("homeactive.svg"),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  activeIcon: _IconImg("briefcaseactive.svg"),
                  icon: _IconImg("briefcase.svg"),
                  label: "My Applies"),
              BottomNavigationBarItem(
                  activeIcon: _IconImg("inboxactive.svg"),
                  icon: _IconImg("inbox.svg"),
                  label: "Inbox"),
              BottomNavigationBarItem(
                  activeIcon: _IconImg("useractive.svg"),
                  icon: _IconImg("user.svg"),
                  label: "Profile"),
              // BottomNavigationBarItem(
              //     activeIcon: _IconImg("package2.svg"),
              //     icon: _IconImg("package1.svg"),
              //     label: "Products"),
            ],
            currentIndex: widget.select,
            onTap: b,
          ),
        ),
      ),
    );
  }

  Widget _IconImg(String Img) {
    return Container(height: 20, width: 20, child: ImgPathSvg(Img));
  }
}


//CANDIDATE BOTTOM NAVIGATION BAR
class Candidate_Bottom_Navigation extends StatefulWidget {
  int select;
  Candidate_Bottom_Navigation({Key? key,required this.select}) : super(key: key);

  @override
  State<Candidate_Bottom_Navigation> createState() => _Candidate_Bottom_NavigationState();
}

class _Candidate_Bottom_NavigationState extends State<Candidate_Bottom_Navigation> {

  final pages = [
    Candidate_Home_Screen(),
    Candidate_MyApplies_Screen(),
    Inbox_Page(),
    Profile_Screen(),
  ];

  void b(index) {
    setState(() {
      widget.select = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: pages[widget.select],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: white1,
            selectedItemColor: blue1,
            selectedLabelStyle: TextStyle(color: blue1),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: _IconImg("home.svg"),
                activeIcon: _IconImg("homeactive.svg"),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  activeIcon: _IconImg("briefcaseactive.svg"),
                  icon: _IconImg("briefcase.svg"),
                  label: "My Applies"),
              BottomNavigationBarItem(
                  activeIcon: _IconImg("inboxactive.svg"),
                  icon: _IconImg("inbox.svg"),
                  label: "Inbox"),
              BottomNavigationBarItem(
                  activeIcon: _IconImg("useractive.svg"),
                  icon: _IconImg("user.svg"),
                  label: "Profile"),
              // BottomNavigationBarItem(
              //     activeIcon: _IconImg("package2.svg"),
              //     icon: _IconImg("package1.svg"),
              //     label: "Products"),
            ],
            currentIndex: widget.select,
            onTap: b,
          ),
        ),
      ),
    );
  }

  Widget _IconImg(String Img) {
    return Container(height: 20, width: 20, child: ImgPathSvg(Img));
  }
}



