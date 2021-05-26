import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/components/graphics/LineTitles.dart';

class LinearChart extends StatelessWidget {
  int _intY;
  List<String> _labelY;
  int _intX;
  int _minY;
  double _width;
  double _height;
  final List<Color>lineColors=[color2,Colors.lightGreen,color4,Colors.cyan];
  List<List<FlSpot>> _dataGraphics;

  LinearChart(this._intX, this._intY,this._minY,this._labelY, this._width,this._height, this._dataGraphics);

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

            minY: 0,maxY: 6,
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(getTooltipItems:(touchedSpots) {
                List<LineTooltipItem> list=List();
                for(var i=0;i<touchedSpots.length;i++){
                  var data=touchedSpots[i].props[4] as double;
                  var dataX=touchedSpots[i].props[3] as double;
                  print(touchedSpots[i].props);
                  if(i==0){
                    var dateY=DateTime.fromMillisecondsSinceEpoch((dataX*_intX).toInt()+_minY);
                    list.add(LineTooltipItem("${dateY.day}/${dateY.month}/${dateY.year}\n"+(data*_intY).truncate().toString(),TextStyle(color: touchedSpots[i].bar.colors[0])));
                  }
                  else{
                    list.add(LineTooltipItem((data*_intY).truncate().toString(),TextStyle(color: touchedSpots[i].bar.colors[0])));
                  }
                }
                return list;
              },tooltipBgColor: color8,
              )
            ),

            titlesData: LineTitles.getTitleData(_labelY,_intY,_width*0.02),
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
