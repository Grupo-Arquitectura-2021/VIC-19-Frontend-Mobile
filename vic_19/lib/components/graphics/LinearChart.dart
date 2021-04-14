import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../PaletteColor.dart';
import 'LineTitles.dart';
class LineChartWidget extends StatelessWidget {
  final List<String> _data;
  // final int x;
  // final int y;
  LineChartWidget(this._data);
  final List<Color>gradientColors=[color2,color3,color4];
  final List<Color>lineOne=[color2];
  final List<Color>lineTwo=[color3];
  final List<Color>lineThree=[color4];
  List<String> _titles=['1/1','1/2','10/10','11/11','12/12','1/6','12/10','12/12'];//must be of 5 elements
  List<String> _titlesY=['0k','10k','20k','30k','40k','50k','60k','200k'];//must be of 7 elements
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,maxX: 10,
        minY: 0,maxY: 6,
        titlesData: LineTitles.getTitleData(_titles,_titlesY),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value){
            return FlLine(
              color: color5.withOpacity(0.5),
              strokeWidth: 1
            );
          },
            // drawVerticalLine: false,
            drawVerticalLine: false,
          getDrawingVerticalLine: (value){
            return FlLine(
              color: color5.withOpacity(0.5),
              strokeWidth: 1
            );
          }
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: color5.withOpacity(0.5),width: 2)
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
    );
  }
}
