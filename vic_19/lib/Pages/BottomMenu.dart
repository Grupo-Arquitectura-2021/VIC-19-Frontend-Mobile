import 'package:vic_19/Pages/Map.dart';
import 'package:vic_19/bottomNav/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../PaletteColor.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  List<Widget> pages;

  int _selectedIndex = 1;
  PageController pageController=PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages=[MapPage(),MapPage(),MapPage()];
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: [
          Icon(
            // Icons.analytics_outlined,
            Icons.table_chart_rounded,
            // Icons.assessment_outlined,
            size: 30,
            color: _selectedIndex==0?color1:color5,
          ),
          Icon(
            // Icons.menu,
            // Icons.home_rounded,
            Icons.public_rounded,
            size: 30,
            color: _selectedIndex==1?color1:color5,
          ),
          Icon(
            // Icons.add_chart,
            // Icons.article_outlined,
            Icons.list_alt_rounded,
            size: 30,
            color: _selectedIndex==2?color1:color5,
          ),
          // Icon(Icons.add_shopping_cart,size: 40,),
        ],
        onTap: (index){
          setState(() {
            _selectedIndex = index;
            pageController.jumpToPage(_selectedIndex);
          });
        },
        buttonBackgroundColor: color2,

        backgroundColor: color1,
        height: size.height*0.07,

        color: color1,
        // animationCurve: Curves.easeInBack,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.right,
          color: color1.withOpacity(0),

          child: PageView(
            physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: pages
          ),
        ),
      )
    );
  }
}

