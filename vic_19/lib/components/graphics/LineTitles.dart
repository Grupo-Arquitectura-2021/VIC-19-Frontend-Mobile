import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class LineTitles{
  static getTitleData(){

    return FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          margin: 8,
          getTitles: (value){
            switch (value.toInt()){

            }
            return '';
          }
        )
    );
  }
}