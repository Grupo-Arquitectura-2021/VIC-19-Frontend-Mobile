import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/util/ApiUrl.dart';
import 'package:vic_19/util/MapUtils.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';
import 'package:http/http.dart' as http;
class GraphicsRepository {
  LocationData _locationData;
  List<bool> _activeDataGraphic;
  List<List<FlSpot>> _listPointGraphic;
  List<LocationData> _listDataGraphic;
  int _maxP;
  int _intP;
  List<String> _xLabelGraphics;
  int _idLocation;
  int _activeChart;


  LocationData get locationData => _locationData;

  set locationData(LocationData value) {
    _locationData = value;
  }


  int get activeChart => _activeChart;

  set activeChart(int value) {
    _activeChart = value;
  }

  List<LocationData> get listDataGraphic => _listDataGraphic;

  set listDataGraphic(List<LocationData> value) {
    _listDataGraphic = value;
  }





  List<List<FlSpot>> get listPointGraphic => _listPointGraphic;

  set listPointGraphic(List<List<FlSpot>> value) {
    _listPointGraphic = value;
  }



  GraphicsRepository(){
    _locationData=LocationData.fromLocationData(1,"",null,0,0, 0, 0,0);
    _activeDataGraphic=[true,false,false,false];
  }


  int get maxP => _maxP;

  set maxP(int value) {
    _maxP = value;
  }

  int get idLocation => _idLocation;

  set idLocation(int value) {
    _idLocation = value;
  }

  List<bool> get activeDataGraphic => _activeDataGraphic;

  set activeDataGraphic(List<bool> value) {
    _activeDataGraphic = value;
  }

  Future<bool> getAllDataLocationCountry(DateTime date)async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    var url=ApiUrl + "country/allInfo/$idLocation?date=$formattedDate";
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );

    if(response.statusCode==200){
      var resJson = json.decode(response.body);
      print("data");
      print(resJson);
      List<LocationData> locations=List();
      resJson.forEach((element) {
        LocationData newLocation=LocationData.fromJson(element);
        locations.add(newLocation);
      });
      listDataGraphic=locations;
      locationData=locations.last;
      if(verifyactiveData()) tranformDataGraphic(locations);
      return true;
    }
    else{
      return false;
    }

  }
  changeActiveDataGraphic(int index){
    activeDataGraphic[index]=!activeDataGraphic[index];
    if(verifyactiveData())
      tranformDataGraphic(_listDataGraphic);
    else
      activeDataGraphic[index]=!activeDataGraphic[index];

  }

getDateGraphic(month,day){
    Map<int,String> monthMap=
    {
      1:"ENE",
      2:"FEB",
      3:"MAR",
      4:"ABR",
      5:"MAY",
      6:"JUN",
      7:"JUL",
      8:"AGO",
      9:"SEP",
      10:"OCT",
      11:"NOV",
      12:"DIC",
    };
    return "$day\n${monthMap[month]}";
}
bool verifyactiveData(){

    for(var a in activeDataGraphic){
        if(a)return true;
    }
    return false;
}
tranformDataGraphic(List<LocationData> list)
{
  print("transform");
  int initDate=list[0].dateLocationCovid.millisecondsSinceEpoch;
  int lastDate=list.last.dateLocationCovid.millisecondsSinceEpoch;
  int divDate=((lastDate-initDate)~/10);
  print(divDate);
  print("divDate");
  List<String> xLabels=List();
  lastDate=initDate+divDate*10;
  DateTime dateLabel;
  for(int i=0;i<10;i++){
    dateLabel=DateTime.fromMillisecondsSinceEpoch(initDate+i*divDate);
    print(dateLabel);
    xLabels.add(getDateGraphic(dateLabel.month, dateLabel.day));
  }
  print(initDate);
  print(lastDate);
  print(xLabels);
  List<List<FlSpot>> listPoints=List();
    for(int i=0;i<4;i++){
      listPoints.add(List());
    }
  int maxData=0;
  List<int> yLabels=List();
  print("divDate");
  print(activeDataGraphic);
  for(var l in list){
    int maxD=max(activeDataGraphic[0]?l.confirmed:0, max(max(activeDataGraphic[1]?l.recovered:0,activeDataGraphic[2]?l.deceased:0),activeDataGraphic[3]?l.vaccinated:0));
    if(maxD>maxData){
      maxData=maxD;
    }
  }
  print("maxDta");
  print(maxData);
  int divData=(maxData/5).truncate();
  maxData=divData*5;
  _maxP=maxData;
  _intP=divData==0?1:divData;
  yLabels.add(0);
  for(int i=0;i<7;i++){
    yLabels.add(yLabels[i]+divData);
  }

  double x=0;
  double y1=0;
  double y2=0;
  double y3=0;
  double y4=0;
  print("termina1");
  for(var l in list) {
      x=9*(l.dateLocationCovid.millisecondsSinceEpoch-initDate)/(lastDate-initDate);
      y1=l.confirmed==-1||l.confirmed==0?listPoints[0].length==0?0:listPoints[0].last.y:l.confirmed*1.0;
      y2=l.recovered==-1||l.confirmed==0?listPoints[1].length==0?0:listPoints[1].last.y:l.recovered*1.0;
      y3=l.deceased==-1||l.confirmed==0?listPoints[2].length==0?0:listPoints[2].last.y:l.deceased*1.0;
      y4=l.vaccinated==-1||l.confirmed==0?listPoints[3].length==0?0:listPoints[3].last.y:l.vaccinated*1.0;
      if(activeDataGraphic[0])listPoints[0].add(FlSpot(x,y1));
      if(activeDataGraphic[1])listPoints[1].add(FlSpot(x,y2));
      if(activeDataGraphic[2])listPoints[2].add(FlSpot(x,y3));
      if(activeDataGraphic[3])listPoints[3].add(FlSpot(x,y4));
  }
  listPointGraphic=listPoints;
  xLabelGraphics=xLabels;
  print(activeDataGraphic);
  print(listPointGraphic);
  print("termina");

}



  List<String> get xLabelGraphics => _xLabelGraphics;

  set xLabelGraphics(List<String> value) {
    _xLabelGraphics = value;
  }

  int get intP => _intP;

  set intP(int value) {
    _intP = value;
  }
}