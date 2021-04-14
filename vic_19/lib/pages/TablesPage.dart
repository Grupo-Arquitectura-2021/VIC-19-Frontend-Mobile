import 'package:flutter/material.dart';
import 'package:vic_19/components/graphics/LinearChart.dart';

import '../PaletteColor.dart';
class TablesPage extends StatefulWidget {
  @override
  _TablesPageState createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  List<String> _dataList;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: 80,),
                Container(
                  width: size.width,
                  padding: EdgeInsets.all(30),
                  // color: color6,
                  child: LineChartWidget(_dataList),
                ),
                SizedBox(height: 30,),
                // LineChartWidget(_dataList),
              ],
            ),
          )
      ),
    );
  }
}
