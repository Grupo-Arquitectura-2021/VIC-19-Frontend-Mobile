import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vic_19/Model/City.dart';
import 'package:vic_19/Model/Country.dart';
import 'package:vic_19/Model/DrugStore.dart';
import 'package:vic_19/Model/Hospital.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/Municipality.dart';
import 'package:vic_19/Model/Shelter.dart';
import 'package:vic_19/Model/Shelter.dart';
import 'package:vic_19/Model/Shelter.dart';
import 'package:vic_19/Model/Shelter.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/util/ApiUrl.dart';
import 'package:vic_19/util/MapUtils.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';
import 'package:http/http.dart' as http;
class MapRepository {
  double _zoom;
  List<bool> _filters;
  String _title;
  Location _selectLocation;
  Set<Polygon> _area;
  List<Location> _locations;
  List<Location> _hospital;
  List<Location> _drugstores;
  List<Location> _shelters;
  Set<Marker> _markers;
  LatLng _centerMap;
  double _size;
  LocationData _locationData;
  List<bool> _activeDataGraphic;
  List<List<FlSpot>> _listPointGraphic;
  List<LocationData> _listDataGraphic;
  List<int> _yLabelGraphics;
  List<String> _xLabelGraphics;
  List<Location> _locationHistory;
  int _type;


  int get type => _type;

  set type(int value) {
    _type = value;
  }

  List<Location> get locationHistory => _locationHistory;

  set locationHistory(List<Location> value) {
    _locationHistory = value;
  }

  LocationData get locationData => _locationData;

  set locationData(LocationData value) {
    _locationData = value;
  }

  double get size => _size;

  set size(double value) {
    _size = value;
  }



  List<LocationData> get listDataGraphic => _listDataGraphic;

  set listDataGraphic(List<LocationData> value) {
    _listDataGraphic = value;
  }

  List<Location> get hospital => _hospital;

  set hospital(List<Location> value) {
    _hospital = value;
  }


  List<List<FlSpot>> get listPointGraphic => _listPointGraphic;

  set listPointGraphic(List<List<FlSpot>> value) {
    _listPointGraphic = value;
  }

  Location get selectLocation => _selectLocation;

  set selectLocation(Location value) {
    _selectLocation = value;
  }

  Set<Polygon> get area => _area;

  set area(Set<Polygon> value) {
    _area = value;
  }

  MapRepository(){
    locations=[];
    zoom=7;
    filters=[true,false,false,false];
    title="";
    _centerMap=LatLng(-16.2256651,-65.0455838);
    area=Set();
    type=0;
    _locationData=LocationData.fromLocationData(1,"",null,0,0, 0, 0,0);
    _activeDataGraphic=[true,false,false,false];
    _locationHistory=List();
  }

  double get zoom => _zoom;

  set zoom(double value) {
    _zoom = value;
  }

  List<bool> get filters => _filters;

  set filters(List<bool> value) {
    _filters = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }


  List<int> get yLabelGraphics => _yLabelGraphics;

  set yLabelGraphics(List<int> value) {
    _yLabelGraphics = value;
  }

  List<Location> get locations => _locations;

  set locations(List<Location> value) {
    _locations = value;
  }

  Set<Marker> get markers => _markers;

  set markers(Set<Marker> value) {
    _markers = value;
  }

  LatLng get centerMap => _centerMap;

  set centerMap(LatLng value) {
    _centerMap = value;
  }



  List<bool> get activeDataGraphic => _activeDataGraphic;

  set activeDataGraphic(List<bool> value) {
    _activeDataGraphic = value;
  }

  Future<void> getMunicipality(context)async {
    List<Location> municipality=List();
    var url=ApiUrl + "municipality/location/${_locationHistory.last.idLocation}";
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    if(response.statusCode==200){
      List resJson = json.decode(utf8.decode(response.bodyBytes));
      resJson.forEach((element) {
        Location newLocation=Municipality.fromJson(element);
        municipality.add(newLocation);
      });
      if(response.statusCode==200){
        locations=municipality;
        zoom=6;
        type=2;
        centerMap=LatLng(municipality[0].latitude,municipality[0].longitude);
        markers=await addMarkers(locations, Icons.location_on, color4,size*0.035,context);
        return true;
      }
      else{
        return false;
      }

    }
    else{
      return false;
    }
  }
  Future<void> getDrugstore(context)async {
    List<Location> drugstoreList=List();
    var url = ApiUrl + "drugstore/locations?cityId=${_locationHistory.last.idLocation}";
    final response = await http.get(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );
    List resJson = json.decode(utf8.decode(response.bodyBytes));
    resJson.forEach((element) {
      Location newLocation=DrugStore.fromJson(element);
      drugstoreList.add(newLocation);
    });
    drugstores=drugstoreList;
    if(filters[2]) {
      markers.addAll(await addMarkers(
          drugstores, Icons.local_pharmacy, color3, size * 0.035, context));
    }
  }
  changeActiveDataGraphic(int index){
    activeDataGraphic[index]=!activeDataGraphic[index];
    tranformDataGraphic(_listDataGraphic);
  }
  Future<void> getHospital(context)async {
    /*
    List<Location> hospitalList=List();
    var url=ApiUrl + "hospital/locationsByCity/${lastLocation.idLocation}";
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    List resJson = json.decode(utf8.decode(response.bodyBytes));
    resJson.forEach((element) {
      Location newLocation=Location.fromJson(element, 0);

      print(newLocation);
      print("ggg");

      hospitalList.add(newLocation);
    });
    print("hospital");
    print(hospitalList[0].lat);
    print(hospitalList[0].lon);
    print(hospitalList[0].idLocation);
    print(hospitalList[0].name);
    print(hospitalList[0].type);

    if(response.statusCode==200){
      locations=hospitalList;
      zoom=6;
      type=1;
      centerMap=LatLng(hospitalList[0].lat,hospitalList[0].lon);
      hospital=hospitalList;
      if(filters[1]){
        markers.addAll(await addMarkers(hospital, Icons.local_hospital, color6,size*0.035,context));
      }
      return true;

    }
    else{
      return false;
    }

*/
    try{
      List<Location> hospitalList=List();
      var url=ApiUrl + "hospital/locations?cityId${_locationHistory.last.idLocation}";
      final response = await http.get(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          }
      );
      if(response.statusCode==200){
        List resJson = json.decode(utf8.decode(response.bodyBytes));
        resJson.forEach((element) {
          Location newLocation=Hospital.fromJson(element);
          hospitalList.add(newLocation);
        });
        hospital=hospitalList;
        if(filters[1]){
          markers.addAll(await addMarkers(hospital, Icons.local_hospital, color6,size*0.035,context));
        }
      }
    }
    catch(e){
      print("ERROR EN LOS HOSPITALES: "+e.toString());
    }


  }
  Future<void> getShelters(context)async {
    List<Location> _shelterList=[Shelter(24,"Albergue Transitorio",-16.520983002910345, -68.19755751373685),
      Shelter(25,"Remar Viacha",-16.49771294090049, -68.13778200949986),
      Shelter(26,"Hogar Carlos de Villegas",-16.507836752632958, -68.13134040251619),
      Shelter(27,"Hogar Virgen de Copacabana",-16.536528470964985, -68.18857531889586)];
    shelters=_shelterList;
    if(filters[3]){
      markers.addAll(await addMarkers(shelters, Icons.local_hotel, color2,size*0.035,context));}

  }
  Future<void> getCities(context)async {
    List<Location> cities=List();
    var url=ApiUrl + "city/location";
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    List resJson = json.decode(utf8.decode(response.bodyBytes));
    resJson.forEach((element) {
      Location newLocation=City .fromJson(element);
      cities.add(newLocation);
    });
    if(response.statusCode==200){
      locations=cities;
      zoom=5.5;
      type=1;
      centerMap=LatLng(-16.2256651,-63.5455838);
      markers=await addMarkers(cities, Icons.location_on, color4,size*0.035,context);
      return true;
    }
    else{
      return false;
    }

  }
  Future<bool> getDataLocationCountry(DateTime date)async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    var url=ApiUrl + "country/${selectLocation.idLocation}?date=$formattedDate";
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    var resJson = json.decode(response.body);
    LocationData country=LocationData.fromJson(resJson);
    if(response.statusCode==200){
      locationData=country;
      return true;
    }
    else{
      return false;
    }

  }
  Future<bool> getAllDataLocationCountry(DateTime date)async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    var url=ApiUrl + "country/allInfo/${selectLocation.idLocation}?date=$formattedDate";
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
      tranformDataGraphic(locations);
      return true;
    }
    else{
      return false;
    }

  }
  Future<bool> getCountries(context)async {
    List<Location> paises=List();
    var url=ApiUrl + "country/location";
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    if(response.statusCode==200){
      List resJson = json.decode(utf8.decode(response.bodyBytes));
      resJson.forEach((element) {
        Location newLocation=Country.fromJson(element);
        paises.add(newLocation);
      });
      locations=paises;
      zoom=3.5;
      type=0;
      centerMap=LatLng(-16.2256651,-58.0455838);
      size=MediaQuery.of(context).size.height;
      markers=await addMarkers(paises, Icons.location_on, color4,size*0.035,context);
      return true;
    }
    else{
      return false;
    }

  }

  Future<Set<Marker>> addMarkers(List<Location> list,icon,color,double size,context)async{
    Set<Marker> markerAux=Set();
    var id;
    var name;
    var lat;
    var lon;
    int i=0;
    for(var l in list) {
      i++;
      id=l.idLocation.toString();
        name=l.locationName;
        lat=l.latitude;
        lon=l.longitude;

      final marker = await MapUtils.createCustomMarkerBitmap1(
          name, color, icon,size);
      markerAux.add(Marker(markerId: MarkerId(id),
          position: LatLng(lat, lon),
          icon: marker,
          draggable: false,
          visible: true,
          zIndex: i%2==0?1:0,
          onTap: () {
              selectLocation=l;
              BlocProvider.of<MapBloc>(context).add(SelectLocationEvent(l));

          }));
    }
    return markerAux;
  }
  Future<void> expandMap(context,t)async{
    if((selectLocation!=null&&selectLocation.locationName=="Bolivia")||type!=0){
      size=MediaQuery.of(context).size.height;
      if(type<2||(type<3&&t==2&&type>=0)){
        t==1?type++:type--;
        switch(type){
          case 0:
            if(t==2){
              selectLocation=locationHistory.last;
              locationHistory.removeLast();
            }
            else{
              locationHistory.add(selectLocation);
              selectLocation=null;}
            await getCountries(context);
            break;
          case 1:
            if(t==2){
              _locationHistory.removeLast();
            }
            else{
              _locationHistory.add(selectLocation);
              selectLocation=null;

            }
            await getCities(context);
            break;
          case 2:
            if(t==2){
            }
            else{
              _locationHistory.add(selectLocation);
              await getMunicipality(context);
              await getHospital(context);
              await getDrugstore(context);
              await getShelters(context);

            }
            break;
        }
      }
    }

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
tranformDataGraphic(List<LocationData> list)
{
  int initDate=list[0].dateLocationCovid.millisecondsSinceEpoch;
  int lastDate=list.last.dateLocationCovid.millisecondsSinceEpoch;
  int divDate=((lastDate-initDate)~/10);
  List<String> xLabels=List();
  lastDate=initDate+divDate*10;
  DateTime dateLabel;
  for(int i=0;i<10;i++){
    dateLabel=DateTime.fromMillisecondsSinceEpoch(initDate+i*divDate);
    xLabels.add(getDateGraphic(dateLabel.month, dateLabel.day));
  }
  List<List<FlSpot>> listPoints=List();
    for(int i=0;i<4;i++){
      listPoints.add(List());
    }
  int maxData=0;
  List<int> yLabels=List();
  for(var l in list){
    int maxD=max(activeDataGraphic[0]?l.confirmed:0, max(max(activeDataGraphic[1]?l.recovered:0,activeDataGraphic[2]?l.deceased:0),activeDataGraphic[3]?l.vaccinated:0));
    if(maxD>maxData){
      maxData=maxD;
    }
  }
  int divData=(maxData/5).truncate();
  maxData=divData*5;
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
      y1=l.confirmed==-1||l.confirmed==0?listPoints[0].length==0?0:listPoints[0].last.y:5*l.confirmed/maxData;
      y2=l.recovered==-1||l.confirmed==0?listPoints[1].length==0?0:listPoints[1].last.y:5*l.recovered/maxData;
      y3=l.deceased==-1||l.confirmed==0?listPoints[2].length==0?0:listPoints[2].last.y:5*l.deceased/maxData;
      y4=l.vaccinated==-1||l.confirmed==0?listPoints[3].length==0?0:listPoints[3].last.y:5*l.vaccinated/maxData;
      if(activeDataGraphic[0])listPoints[0].add(FlSpot(x,y1));
      if(activeDataGraphic[1])listPoints[1].add(FlSpot(x,y2));
      if(activeDataGraphic[2])listPoints[2].add(FlSpot(x,y3));
      if(activeDataGraphic[3])listPoints[3].add(FlSpot(x,y4));
  }
  listPointGraphic=listPoints;
  xLabelGraphics=xLabels;
  yLabelGraphics=yLabels;

}

Future<void> changeFilter(idFilter,context)async{
    filters[idFilter]=!filters[idFilter];
    markers.clear();
    for(var i=0;i<filters.length;i++){
        if(filters[i]==true){
          switch(i){
            case 0:
                    markers.addAll(await addMarkers(locations, Icons.location_on, color4,size*0.035,context));
              break;

            case 1:
              markers.addAll(await addMarkers(hospital, Icons.local_hospital, color6,size*0.035,context));
              break;

            case 2:
              markers.addAll(await addMarkers(drugstores, Icons.local_pharmacy, color3,size*0.035,context));
              break;

            case 3:
              markers.addAll(await addMarkers(shelters, Icons.local_hotel, color2,size*0.035,context));
              break;
          }
        }
    }

  }

  List<Location> get drugstores => _drugstores;

  set drugstores(List<Location> value) {
    _drugstores = value;
  }

  List<Location> get shelters => _shelters;

  set shelters(List<Location> value) {
    _shelters = value;
  }

  List<String> get xLabelGraphics => _xLabelGraphics;

  set xLabelGraphics(List<String> value) {
    _xLabelGraphics = value;
  }
}