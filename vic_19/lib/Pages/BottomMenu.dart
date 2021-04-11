import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Colors.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 1;
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
            size: 40,
            color: Colors.white,
          ),
          Icon(
            // Icons.menu,
            // Icons.home_rounded,
            Icons.public_rounded,
            size: 40,
            color: Colors.white,
          ),
          Icon(
            // Icons.add_chart,
            // Icons.article_outlined,
            Icons.list_alt_rounded,
            size: 40,
            color: Colors.white,
          ),
          // Icon(Icons.add_shopping_cart,size: 40,),
        ],
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        buttonBackgroundColor: color2,
        backgroundColor: color1,
        color: color5,
        animationCurve: Curves.easeInBack,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: Container(
        color: color1,
      ),
    );
  }
}
