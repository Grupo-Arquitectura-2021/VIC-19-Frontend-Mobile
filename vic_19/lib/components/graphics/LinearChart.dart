import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../PaletteColor.dart';
import 'LineTitles.dart';
class LineChartWidget extends StatelessWidget {
  final List<String> _data;
  // final int x;
  // final int y;
  LineChartWidget(this._data,this._width, this._height);
  final List<Color>gradientColors=[color2,color3,color4];
  final List<Color>lineOne=[color2];
  final List<Color>lineTwo=[color3];
  final List<Color>lineThree=[color4];
  List<String> _titles=['1\nENE','4\nFEB','6\nABR','19\nJUN','30\nJUL','10\nSEP','15\nOCT','1\nNOV','24\nDIC'];//must be of 5 elements
  List<String> _titlesY=['0k','10k','20k','30k','40k','50k','60k','200k'];//must be of 7 elements
  double _width;
  double _height;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        color: color8,
        borderRadius: BorderRadius.circular(_height*0.05)
      ),
      width: _width,
      height: _height,
      padding: EdgeInsets.only(bottom: _height*0.12,right: _height*0.1,top: _height*0.1,left: _width*0.03),
      child: LineChart(

        LineChartData(
          minX: 0,maxX: 10,

          minY: 0,maxY: 6,
          titlesData: LineTitles.getTitleData(_titles,_titlesY,_height*0.04),
          gridData: FlGridData(
            show: true,

            getDrawingHorizontalLine: (value){
              return FlLine(
                color: color5.withOpacity(0.2),
                strokeWidth: 1
              );
            },
              // drawVerticalLine: false,
              drawVerticalLine:true,
            getDrawingVerticalLine: (value){
              return FlLine(
                color: color5.withOpacity(0.2),
                strokeWidth: 1
              );
            }
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: color5.withOpacity(0.3),width: 1)
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(1, 3),
                FlSpot(6.8, 2),
                // FlSpot(10, 5),
                // FlSpot(14, 7),
              ],
              isCurved: true,
              colors: lineOne,
              barWidth: 2,
              // colors: gradientColors,
              // belowBarData: BarAreaData(
              //   show: true,
              //   colors: lineOne.map((color) => color.withOpacity(0.3)).toList(),
              // )
            ),
            LineChartBarData(
                spots: [
                  FlSpot(2, 5),
                  FlSpot(8, 2),
                  // FlSpot(12, 4),
                  // FlSpot(16, 3),
                ],
                isCurved: true,
                colors: lineTwo,
                barWidth: 2,
                // belowBarData: BarAreaData(
                //   show: true,
                //   colors: lineTwo.map((color) => color.withOpacity(0.3)).toList(),
                // )
            ),
            LineChartBarData(
                spots: [
                  FlSpot(0, 0),
                  FlSpot(4.3,4.3),
                  FlSpot(7, 6),
                  // FlSpot(10, 2),
                  // FlSpot(14, 4),
                  // FlSpot(14.4, 5.2),
                  // FlSpot(16, 5),
                ],
                isCurved: true,
                colors: lineThree,
                barWidth: 2,
                // belowBarData: BarAreaData(
                //   show: true,
                //   colors: lineThree.map((color) => color.withOpacity(0.3)).toList(),
                // )
            ),
          ],
        ),

      ),
    );
  }
}
