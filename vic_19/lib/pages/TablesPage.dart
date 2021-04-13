import 'package:flutter/material.dart';
import 'package:vic_19/components/graphics/LinearChart.dart';
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
            child: Column(
              children: [
                SizedBox(height: 80,),
                LineChartWidget(_dataList),
              ],
            ),
          )
      ),
    );
  }
}
