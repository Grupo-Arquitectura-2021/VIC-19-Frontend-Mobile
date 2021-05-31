import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:excel/excel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/LocationDataStatistics.dart';
import 'package:vic_19/Model/Statistics.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/util/ApiUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:vic_19/util/ToastAlert.dart';
class GraphicsRepository {
  LocationData _locationData;
  List<bool> _activeDataGraphic;
  List<List<FlSpot>> _listPointGraphic;
  List<LocationData> _listDataGraphic;
  int _intY;
  int _intX;
  int _minY;
  List<String> _xLabelGraphics;
  Location _selectLocation;
  int _activeChart;
  int _activeGraphic;
  LocationDataStatistics _locationDataStatistics;


  LocationDataStatistics get locationDataStatistics => _locationDataStatistics;

  set locationDataStatistics(LocationDataStatistics value) {
    _locationDataStatistics = value;
  }

  int get activeGraphic => _activeGraphic;

  set activeGraphic(int value) {
    _activeGraphic = value;
  }

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
    _activeDataGraphic=[true,true,true,true];
    locationDataStatistics=new LocationDataStatistics();
  }


  int get intY => _intY;

  set intY(int value) {
    _intY = value;
  }

  Location get selectLocation => _selectLocation;

  set selectLocation(Location value) {
    _selectLocation = value;
  }

  List<bool> get activeDataGraphic => _activeDataGraphic;

  set activeDataGraphic(List<bool> value) {
    _activeDataGraphic = value;
  }
  double functionPredict(x,b,r,k){
    return (r*k*k*exp(r*(x-b))-r*k*exp(r*(x-b)))/pow(k+exp(r*(x-b))-1,2);
  }
  getPredictGraphic(body,min)async{
    try{
      final response = await http.post(apiUrlPython+"gompertz",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body:body
      );
      print("alvin");
      print(response.body);
      if(response.statusCode==200){
        var resJson = json.decode(response.body);
        List<LocationData> list=List();
        var dateN=DateTime.now();
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        formatter.format(dateN);
        var dateNow=DateTime.parse(formatter.format(dateN));
        int dateInt=((dateNow.millisecondsSinceEpoch-min)~/86400000);
        print(DateTime.now().millisecondsSinceEpoch);
        print(functionPredict(dateInt, resJson["deathCases"]["b"],resJson["deathCases"]["r"], resJson["deathCases"]["k"]));
        for(int i=1;i<=300;i++){
          list.add(LocationData.fromLocationData(1, "_name", DateTime.fromMillisecondsSinceEpoch(dateNow.millisecondsSinceEpoch+86400000*i),
              _listPointGraphic[2].length>0?functionPredict(dateInt+i, resJson["deathCases"]["b"],resJson["deathCases"]["r"], resJson["deathCases"]["k"]).toInt():-1,
              _listPointGraphic[0].length>0?functionPredict(dateInt+i, resJson["confirmedCases"]["b"],resJson["confirmedCases"]["r"], resJson["confirmedCases"]["k"]).toInt():-1,
              _listPointGraphic[3].length>0?functionPredict(dateInt+i, resJson["vaccinated"]["b"],resJson["vaccinated"]["r"], resJson["vaccinated"]["k"]).toInt():-1,
              1,
              _listPointGraphic[1].length>0?functionPredict(dateInt+i, resJson["recuperated"]["b"],resJson["recuperated"]["r"], resJson["recuperated"]["k"]).toInt():-1));
        }
        print("list");
        print(list.toString());
        locationDataStatistics.dataList=list;
        transformDataPredict(list);
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      print("error");
      print(e);
    }
  }
  getPredictLS(date)async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    var url=ApiUrl + selectLocation.getUrlPredictLS(formattedDate);
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    if(response.statusCode==200){
      var resJson = json.decode(response.body);
      locationDataStatistics.confirmedPredict.leastSquares=resJson["confForecast"].toString();
      locationDataStatistics.recoveredPredict.leastSquares=resJson["recForecast"].toString();
      locationDataStatistics.deathPredict.leastSquares=resJson["deathForecast"].toString();
      locationDataStatistics.vaccinatedPredict.leastSquares=resJson["vacForecast"].toString();
      return true;
    }
    else{
      return false;
    }
  }
  getPredictAI(date)async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    var url=ApiUrl + selectLocation.getUrlPredictAI(formattedDate);
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    if(response.statusCode==200){
      var resJson = json.decode(response.body);
      locationDataStatistics.confirmedPredict.absolute=resJson["confForecast"].toString();
      locationDataStatistics.recoveredPredict.absolute=resJson["recForecast"].toString();
      locationDataStatistics.deathPredict.absolute=resJson["deathForecast"].toString();
      locationDataStatistics.vaccinatedPredict.absolute=resJson["vacForecast"].toString();
      return true;
    }
    else{
      return false;
    }
  }
  getPredictPI(date)async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    var url=ApiUrl + selectLocation.getUrlPredictPI(formattedDate);
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    if(response.statusCode==200){
      var resJson = json.decode(response.body);
      locationDataStatistics.confirmedPredict.percentage=resJson["confForecast"].toString();
      locationDataStatistics.recoveredPredict.percentage=resJson["recForecast"].toString();
      locationDataStatistics.deathPredict.percentage=resJson["deathForecast"].toString();
      locationDataStatistics.vaccinatedPredict.percentage=resJson["vacForecast"].toString();
      return true;
    }
    else{
      return false;
    }
  }
  getStatistics(DateTime date)async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    var url=ApiUrl + selectLocation.getUrlStatistics(formattedDate);
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    if(response.statusCode==200){
      var resJson = json.decode(response.body);
      locationDataStatistics.confirmedStatistics=new Statistics.fromJson(resJson["confirmedStatistics"]);
      locationDataStatistics.recoveredStatistics=new Statistics.fromJson(resJson["recuperatedStatistics"]);
      locationDataStatistics.deathStatistics=new Statistics.fromJson(resJson["deathStatistics"]);
      locationDataStatistics.vaccinatedStatistics=new Statistics.fromJson(resJson["vaccinatedStatistics"]);
      return true;
    }
    else{
      return false;
    }

  }



  Future<bool> getAllDataLocation(DateTime date)async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    var url=ApiUrl + selectLocation.getUrl(formattedDate);
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );

    if(response.statusCode==200){
      var resJson = json.decode(response.body);
      List<LocationData> locations=List();
      resJson.forEach((element) {
        LocationData newLocation=LocationData.fromJson(element);
        locations.add(newLocation);
      });
      listDataGraphic=locations;
      if(resJson.length>0){
        locationData=locations.last;
        if(verifyactiveData()) tranformDataGraphic(locations);
        await getPredictGraphic(response.body,locations[0].dateLocationCovid.millisecondsSinceEpoch);
        getChartIndex(0);
      }
      return true;
    }
    else{
      return false;
    }

  }
  getChartIndex(int index){
   if(listDataGraphic.length!=0){
     var c=listDataGraphic.last.confirmed;
     var r=listDataGraphic.last.recovered;
     var d=listDataGraphic.last.deceased;
     var v=listDataGraphic.last.vaccinated;
     if((c==null||c==-1||c==0)&&(
         r==null||r==-1||r==0)&&(
         d==null||d==-1||d==0)&&(
         v==null||v==-1||v==0)){
       activeChart=3;
     }
     else{
       activeChart=index;
     }
   }
  }
  changeActiveDataGraphic(int index){
    activeDataGraphic[index]=!activeDataGraphic[index];
    if(verifyactiveData()&&_listDataGraphic.length>0)
      {tranformDataGraphic(_listDataGraphic);
    transformDataPredict(locationDataStatistics.dataList);}
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
  Future<void> capturePng(RenderRepaintBoundary boundary) async {
    try {
      print('inside');
      var imagePDF;
      var pngBytes;
      var im;
      final pdf = pw.Document();
      im=await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
      await im.toByteData(format: ui.ImageByteFormat.png);
      pngBytes = byteData.buffer.asUint8List();
      print("bytes${pngBytes}");
      imagePDF = pw.MemoryImage(pngBytes);
      print("bytes${pngBytes}");
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(
          child: pw.Container(
            color: PdfColors.black,
            child: pw.Image.provider(imagePDF),
          )
        ); // Center
      }));

      print("bytes${pngBytes}");

      if (await Permission.storage.request().isGranted) {
        final file = File(await getFilePath(DateTime.now().millisecondsSinceEpoch.toString()+"graphic.pdf"));
        await file.writeAsBytes(pdf.save());
        ToastAlert.simpleToast("Gráfico guardado en: ${file.path}");
      }
      else{
        print("no permiso");
      }
    } catch (e) {
      print(e);
    }
  }
  saveExcel()async{
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Data'];
    excel.setDefaultSheet("Data");
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    sheetObject.appendRow(["fecha","nombre","confirmados","recuperados","fallecidos","vacunados","acumulado"]);

    for(var data in listDataGraphic){
      sheetObject.appendRow([formatter.format(data.dateLocationCovid),data.name,data.confirmed,data.recovered,data.deceased,data.vaccinated,data.total]);
    }
    if (await Permission.storage.request().isGranted) {
      var exc=await excel.encode();

      final file = File(await getFilePath(DateTime.now().millisecondsSinceEpoch.toString()+selectLocation.getTitle()+"-"+selectLocation.locationName)+".xlsx");
      await file.writeAsBytes(exc);
      ToastAlert.simpleToast("Gráfico guardado en: ${file.path}");
    }
    else{
      print("no permiso");
    }
  }

  Future<String> getFilePath(nombre) async {
    Directory appDocumentsDirectory = await DownloadsPathProvider.downloadsDirectory; // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/$nombre'; // 3
    print(filePath);

    return filePath;
  }

  transformDataPredict(List<LocationData> list)
  {
    int initDate=list[0].dateLocationCovid.millisecondsSinceEpoch;
    locationDataStatistics.minX=initDate;
    int lastDate=list.last.dateLocationCovid.millisecondsSinceEpoch;
    int divDate=((lastDate-initDate)~/9);
    List<String> xLabels=List();
    lastDate=initDate+divDate*9;
    locationDataStatistics.intX=divDate==0?1:divDate;
    DateTime dateLabel;
    for(int i=0;i<10;i++){
      dateLabel=DateTime.fromMillisecondsSinceEpoch(initDate+i*divDate);
      print(dateLabel);
      xLabels.add(getDateGraphic(dateLabel.month, dateLabel.day));
    }
    List<List<FlSpot>> listPoints=List();
    for(int i=0;i<4;i++){
      listPoints.add(List());
    }
    int maxData=0;
    List<int> yLabels=List();
    print(activeDataGraphic);
    for(var l in list){
      int maxD=max(activeDataGraphic[0]?l.confirmed:0, max(max(activeDataGraphic[1]?l.recovered:0,activeDataGraphic[2]?l.deceased:0),activeDataGraphic[3]?l.vaccinated:0));
      if(maxD>maxData){
        maxData=maxD;
      }
    }
    print(maxData);
    int divData=(maxData/5).truncate();
    maxData=divData*5;
    locationDataStatistics.intY=divData==0?1:divData;
    yLabels.add(0);
    for(int i=0;i<7;i++){
      yLabels.add(yLabels[i]+divData);
    }

    double x=0;
    double y1=0;
    double y2=0;
    double y3=0;
    double y4=0;
    for(var l in list) {
      x=9*(l.dateLocationCovid.millisecondsSinceEpoch-initDate)/(lastDate-initDate);
      y1=l.confirmed==-1||l.confirmed==0?null:l.confirmed*5/maxData*1.0;
      y2=l.recovered==-1||l.recovered==0?null:l.recovered*5/maxData*1.0;
      y3=l.deceased==-1||l.deceased==0?null:l.deceased*5/maxData*1.0;
      y4=l.vaccinated==-1||l.vaccinated==0?null:l.vaccinated*5/maxData*1.0;
      if(activeDataGraphic[0]&&y1!=null)listPoints[0].add(FlSpot(x,y1));
      if(activeDataGraphic[1]&&y2!=null)listPoints[1].add(FlSpot(x,y2));
      if(activeDataGraphic[2]&&y3!=null)listPoints[2].add(FlSpot(x,y3));
      if(activeDataGraphic[3]&&y4!=null)listPoints[3].add(FlSpot(x,y4));
    }
    locationDataStatistics.dataPoints=listPoints;


    for(var l in locationDataStatistics.dataPoints){
    }
    locationDataStatistics.labelX=xLabels;

  }
tranformDataGraphic(List<LocationData> list)
{
  int initDate=list[0].dateLocationCovid.millisecondsSinceEpoch;
  minY=initDate;
  int lastDate=list.last.dateLocationCovid.millisecondsSinceEpoch;
  int divDate=((lastDate-initDate)~/9);
  print(divDate);
  List<String> xLabels=List();
  lastDate=initDate+divDate*9;
  intX=divDate==0?1:divDate;
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
  print(activeDataGraphic);
  for(var l in list){
    int maxD=max(activeDataGraphic[0]?l.confirmed:0, max(max(activeDataGraphic[1]?l.recovered:0,activeDataGraphic[2]?l.deceased:0),activeDataGraphic[3]?l.vaccinated:0));
    if(maxD>maxData){
      maxData=maxD;
    }
  }
  print(maxData);
  int divData=(maxData/5).truncate();
  maxData=divData*5;
  _intY=divData==0?1:divData;
  yLabels.add(0);
  for(int i=0;i<7;i++){
    yLabels.add(yLabels[i]+divData);
  }

  double x=0;
  double y1=0;
  double y2=0;
  double y3=0;
  double y4=0;
  for(var l in list) {
      x=9*(l.dateLocationCovid.millisecondsSinceEpoch-initDate)/(lastDate-initDate);
      y1=l.confirmed==-1||l.confirmed==0?null:l.confirmed*5/maxData*1.0;
      y2=l.recovered==-1||l.recovered==0?null:l.recovered*5/maxData*1.0;
      y3=l.deceased==-1||l.deceased==0?null:l.deceased*5/maxData*1.0;
      y4=l.vaccinated==-1||l.vaccinated==0?null:l.vaccinated*5/maxData*1.0;
      if(activeDataGraphic[0]&&y1!=null)listPoints[0].add(FlSpot(x,y1));
      if(activeDataGraphic[1]&&y2!=null)listPoints[1].add(FlSpot(x,y2));
      if(activeDataGraphic[2]&&y3!=null)listPoints[2].add(FlSpot(x,y3));
      if(activeDataGraphic[3]&&y4!=null)listPoints[3].add(FlSpot(x,y4));
  }
  listPointGraphic=listPoints;
  xLabelGraphics=xLabels;
  print(activeDataGraphic);
  print(listPointGraphic);

}



  List<String> get xLabelGraphics => _xLabelGraphics;

  set xLabelGraphics(List<String> value) {
    _xLabelGraphics = value;
  }



  int get intX => _intX;

  set intX(int value) {
    _intX = value;
  }

  int get minY => _minY;

  set minY(int value) {
    _minY = value;
  }
}