import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/components/graphics/LineTitles.dart';

class LinearChart extends StatelessWidget {
  int _maxP;
  List<String> _labelY;
  int _intP;
  double _width;
  double _height;
  final List<Color>lineColors=[color2,Colors.lightGreen,color4,Colors.cyan];
  List<List<FlSpot>> _dataGraphics;

  LinearChart(this._maxP, this._intP,this._labelY, this._width,this._height, this._dataGraphics);

  getPoints(List<List<FlSpot>> data){
    List<LineChartBarData> list=List();
    for(int i=0;i<data.length;i++){

      if(data[i].length>0)list.add(
          LineChartBarData(
            spots: data[i],
            isCurved: false,
            colors: [lineColors[i]],
            dotData: FlDotData(
              show: false,
            ),
            barWidth: 1,
          ));
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
        ),
        padding: EdgeInsets.only(right: _width*0.05,left: 0,bottom: _height*0.04),
      child: LineChart(


        LineChartData(

            minX: 0,maxX: 9,

            minY: 0,maxY: _maxP*1.0+_intP,
            titlesData: LineTitles.getTitleData(_labelY,_intP,_width*0.02),
            gridData: FlGridData(
                show: true,

                getDrawingHorizontalLine: (value){
                  return FlLine(
                      color: color5.withOpacity(0.05),
                      strokeWidth: 0.5
                  );
                },
                drawVerticalLine:true,
                getDrawingVerticalLine: (value){
                  return FlLine(
                    color: color5.withOpacity(0.05),
                    strokeWidth: 0.5,
                  );
                }
            ),
            borderData: FlBorderData(
                show: true,
                border: Border.all(color: color5.withOpacity(0.1),width: 0.5)
            ),
            lineBarsData:getPoints(_dataGraphics)
        ),

      ),
    );
  }
}
