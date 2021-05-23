import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/PaletteColor.dart';


class BarTitles{
  static getTitleData(List<String> _titles,List<int> _titlesY,double size){
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
                return _titles[1];
              case 4:
                return _titles[2];
              case 6:
                return _titles[3];
              case 8:
                return _titles[4];
              // case 12:
              //   return _titles[5];
              // case 14:
              //   return _titles[6];
              // case 16:
              //   return _titles[7];
            }
            return '';
          }
        ),
      leftTitles: SideTitles(
        showTitles: true,
          margin: 1,
          getTextStyles: (value)=> TextStyle(
              fontWeight: FontWeight.w300,
              color: color5.withOpacity(0.7),
              fontSize: size
          ),
          getTitles: (value){
            switch (value.toInt()){
              case 0:
                return _titlesY[0].toString();
              case 1:
                return _titlesY[1].toString();
              case 2:
                return _titlesY[2].toString();
              case 3:
                return _titlesY[3].toString();
            }
            return '';
          }
      ),
    );
  }

}