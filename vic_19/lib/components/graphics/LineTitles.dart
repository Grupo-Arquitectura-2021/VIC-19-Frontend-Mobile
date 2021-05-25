import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/PaletteColor.dart';


class LineTitles{
  static getTitleData(List<String> _titles,int intP,double size){
    // getTitleData(this._titles);
    return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 10,
          margin: 10,
          getTextStyles: (value)=> TextStyle(
            fontWeight: FontWeight.w300,
              color: color5.withOpacity(0.7),
            fontSize: size
          ),
          getTitles: (value){
            switch (value.toInt()){
              case 0:
                return _titles[0];
              case 2:
                return _titles[2];
              case 4:
                return _titles[4];
              case 6:
                return _titles[6];
              case 8:
                return _titles[8];
            }
            return '';
          }
        ),
      leftTitles: SideTitles(
        showTitles: true,
          margin: 1,
          interval: intP!=0?intP*1.0:1,
          getTextStyles: (value)=> TextStyle(
              fontWeight: FontWeight.w300,
              color: color5.withOpacity(0.7),
              fontSize: size
          ),
          getTitles: (value){
            if(intP==0){
              return "";
            }
            else{

              if(value%intP==0){return value.toInt()>999?"${(value~/1000)}k":value.toInt().toString();}
              else return "";
            }
          }
      ),
    );
  }

}