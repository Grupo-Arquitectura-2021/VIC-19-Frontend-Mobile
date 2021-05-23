import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/components/graphics/BarTitles.dart';
import 'package:vic_19/components/graphics/LineTitles.dart';


class BarChartView extends StatelessWidget {
  double _width;
  double _height;
  LocationData _data;
  List<bool> active;
  int maxY=0;
  BarChartView( this._width,this._height, this._data,this.active);
  final List<Color>lineColors=[color2,Colors.lightGreen,color4,Colors.cyan];

  List<BarChartGroupData> getBarGroups() {
    List<BarChartGroupData> list=List();
    if(active[0]&&_data.confirmed>0){
      list.add(
          BarChartGroupData(
            x:0,
            barRods:[BarChartRodData(
              y: _data.confirmed*1.0,
              colors: [lineColors[0]],
              width: _width*0.03,
            ),]
          )
      );
    }
    if(active[1]&&_data.recovered>0){
      list.add(
          BarChartGroupData(
              x:1,
              barRods:[BarChartRodData(
                y: _data.recovered*1.0,
                colors: [lineColors[1]],
                width: _width*0.03,
              ),]
          )

      );
    }
    if(active[2]&&_data.deceased>=0){
      list.add(
          BarChartGroupData(
              x:2,
              barRods:[BarChartRodData(
                y: _data.deceased*1.0,
                colors: [lineColors[2]],
                width: _width*0.03,
              ),]
          )
      );
    }
    if(active[3]&&_data.vaccinated>0){
      list.add(
          BarChartGroupData(
              x:3,
              barRods:[BarChartRodData(
                y: _data.vaccinated*1.0,
                colors: [lineColors[3]],
                width: _width*0.03,
              ),]
          )
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.only(bottom: _height*0.04),
        width: _width,
        height: _height,
        child: Container(
          width: _width,
          height: _height*0.96,
          decoration:
          BoxDecoration(
            border: Border(bottom: BorderSide(color: color5.withOpacity(0.3)))
          ),
          padding: EdgeInsets.only(right: _width*0.05,left: _width*0.05),
        child: BarChart(
          BarChartData(

              borderData: FlBorderData(
                show: false,
              ),
              barGroups: getBarGroups(),
            alignment: BarChartAlignment.spaceEvenly,

            groupsSpace: 1,
              maxY: getMax()*1.0,
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

              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: false
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  margin:1,
                  interval: getTitlesDiv()*1.0,
                  getTextStyles: (value) => const TextStyle(
                      color: color5, fontSize: 8),
                  getTitles: (value) {
                    if(value%getTitlesDiv()==0)return value.toInt().toString();
                    else return "";
                  },
                ),
              ),
          )
    )),
      );
  }
  int getTitlesDiv(){
    int maxData=0;
    maxData=max(active[0]?_data.confirmed:0, max(max(active[1]?_data.recovered:0,active[2]?_data.deceased:0),active[3]?_data.vaccinated:0));
    int divData=maxData~/5;
    return (divData);
  }
  int getMax(){
    return max(active[0]?_data.confirmed:0, max(max(active[1]?_data.recovered:0,active[2]?_data.deceased:0),active[3]?_data.vaccinated:0));
  }
}
