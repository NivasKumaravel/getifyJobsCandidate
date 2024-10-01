import 'package:flutter/material.dart';
import '../utilits/Common_Colors.dart';
import '../utilits/Text_Style.dart';
import 'Custom_App_Bar.dart';
import 'Image_Path.dart';
import 'Text_Form_Field.dart';

class TabBarWithSearch extends StatefulWidget {
  @override
  _TabBarWithSearchState createState() => _TabBarWithSearchState();
}

class _TabBarWithSearchState extends State<TabBarWithSearch>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: false, actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: ImgPathSvg("bell.svg"),
        ),
      ], isLogoUsed: false,title: '', isTitleUsed: null,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 20, bottom: 20),
              child: textFormFieldSearchBar(
                keyboardtype: TextInputType.text,
                hintText: "Search ...",
                Controller: null,
                validating: null,
                onChanged: null, focusNode: null,
              ),
            ),
            Container(
              color: white1,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: _tabController,
                labelColor: white1,
                labelStyle: TabT,
                indicator: BoxDecoration(
                  color: blue1
                ),
                indicatorColor: grey4,
                unselectedLabelColor: grey4,
                indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2, // Equal width for each tab
                    child: Tab(
                      text: 'Direct',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2, // Equal width for each tab
                    child: Tab(
                      text: 'Campus',
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(child: Text('Tab 1 Content')),
                  Center(child: Text('Tab 2 Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
