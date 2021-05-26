import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/components/graphics/LineTitles.dart';


class PieChartView extends StatelessWidget {
  double _width;
  double _height;
  LocationData _data;
  List<bool> active;

  PieChartView( this._width,this._height, this._data,this.active);
  final List<Color>lineColors=[color2,Colors.lightGreen,color4,Colors.cyan];

  List<PieChartSectionData> getSections(){
    List<PieChartSectionData> list= List();
    if(_data!=null){
      var total=_data.recovered+_data.confirmed+_data.deceased+_data.vaccinated;
      var confirmed=double.parse((100*_data.confirmed/total).toStringAsFixed(2));
      var recovered=double.parse((100*_data.recovered/total).toStringAsFixed(2));
      var deceased=double.parse((100*_data.deceased/total).toStringAsFixed(2));
      var vaccinated=double.parse((100*_data.vaccinated/total).toStringAsFixed(2));
      if(active[0]&&confirmed>0){
        list.add(
            PieChartSectionData(
              color: lineColors[0],
              value: confirmed,
              title: '$confirmed%',
              radius: 50,
              titleStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: color1),
            )
        );
      }
      if(active[1]&&recovered>0){
        list.add(
            PieChartSectionData(
              color: lineColors[1],
              value: recovered,
              title: '$recovered%',
              radius: 50,
              titleStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: color1),
            )

        );
      }
      if(active[2]&&deceased>=0){
        list.add(
            PieChartSectionData(
              color: lineColors[2],
              value: deceased,
              title: '$deceased%',
              radius: 50,
              titleStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: color1),
            )
        );
      }
      if(active[3]&&vaccinated>0){
        list.add(
            PieChartSectionData(
              color: lineColors[3],
              value: vaccinated,
              title: '${vaccinated}%',
              radius: 50,
              titleStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: color1),
            )
        );
      }
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
      child: PieChart(
        PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: getSections()),
        )
    );
  }
}
