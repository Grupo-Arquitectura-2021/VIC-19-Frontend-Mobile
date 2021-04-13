import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../PaletteColor.dart';
class LineChartWidget extends StatelessWidget {
  final List<String> _data;
  // final int x;
  // final int y;
  LineChartWidget(this._data);
  final List<Color>gradientColors=[color2,color3,color4];
  final List<Color>lineOne=[color2];
  final List<Color>lineTwo=[color3];
  final List<Color>lineThree=[color4];
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,maxX: 8,
        minY: 0,maxY: 8,
        // titlesData: LineTitles.getTitleData(),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value){
            return FlLine(
              color: color5.withOpacity(0.5),
              strokeWidth: 1
            );
          },
            // drawVerticalLine: false,
            drawVerticalLine: true,
          getDrawingVerticalLine: (value){
            return FlLine(
              color: color5.withOpacity(0.5),
              strokeWidth: 1
            );
          }
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: color7,width: 3)
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(1, 3),
              FlSpot(3.4, 2),
              FlSpot(5, 5),
            ],
            isCurved: true,
            colors: lineOne,
            barWidth: 2
            // colors: gradientColors
          ),
          LineChartBarData(
              spots: [
                FlSpot(2, 5),
                FlSpot(4, 2),
                FlSpot(6, 4),
              ],
              isCurved: true,
              colors: lineTwo,
              barWidth: 2
          ),
          LineChartBarData(
              spots: [
                FlSpot(0, 0),
                FlSpot(5, 2),
                FlSpot(7, 4),
              ],
              isCurved: true,
              colors: lineThree,
              barWidth: 2
          ),
        ],
      )
    );
  }
}
