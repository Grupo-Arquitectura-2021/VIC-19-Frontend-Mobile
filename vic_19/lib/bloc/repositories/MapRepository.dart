import 'dart:convert';

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
class MapRepository {
  double _zoom;
  List<bool> _filters;
  String _title;
  Location _selectLocation;
  Location _lastLocation;
  Location _lastLastLocation;
  Set<Polygon> _area;
  List<Location> _locations;
  List<Location> _hospital;
  List<Location> _drugstores;
  List<Location> _shelters;
  Set<Marker> _markers;
  int _type;
  LatLng _centerMap;
  double _size;
  LocationData _locationData;
  List<bool> _activeDataGraphic;


  LocationData get locationData => _locationData;

  set locationData(LocationData value) {
    _locationData = value;
  }

  double get size => _size;

  set size(double value) {
    _size = value;
  }

  int get type => _type;

  set type(int value) {
    _type = value;
  }


  Location get lastLastLocation => _lastLastLocation;

  set lastLastLocation(Location value) {
    _lastLastLocation = value;
  }

  List<Location> get hospital => _hospital;

  set hospital(List<Location> value) {
    _hospital = value;
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
    type=0;
    _centerMap=LatLng(-16.2256651,-65.0455838);
    area=Set();
    _locationData=LocationData.fromLocationData(1,"",null,0,0, 0, 0,0);
    _activeDataGraphic=[true,false,false,false,false];
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


  Location get lastLocation => _lastLocation;

  set lastLocation(Location value) {
    _lastLocation = value;
  }


  List<bool> get activeDataGraphic => _activeDataGraphic;

  set activeDataGraphic(List<bool> value) {
    _activeDataGraphic = value;
  }

  Future<void> getMunicipality(context)async {
    List<Location> municipality=List();
    var url=ApiUrl + "municipality/location/${lastLocation.idLocation}";
    final response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );
    if(response.statusCode==200){

      List resJson = json.decode(utf8.decode(response.bodyBytes));
      resJson.forEach((element) {
        Location newLocation=Location.fromJson(element, 0);
        municipality.add(newLocation);
      });
      if(response.statusCode==200){
        locations=municipality;
        zoom=6;
        type=2;
        centerMap=LatLng(municipality[0].lat,municipality[0].lon);
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
    var url = ApiUrl + "drugstore/location/city/${lastLocation.idLocation}";
    final response = await http.get(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );
    List resJson = json.decode(utf8.decode(response.bodyBytes));
    resJson.forEach((element) {
      Location newLocation=Location.fromJson(element, 0);
      drugstoreList.add(newLocation);
    });
    print("Drugstores");
    drugstores=drugstoreList;
    if(filters[2]) {
      markers.addAll(await addMarkers(
          drugstores, Icons.local_pharmacy, color3, size * 0.035, context));
    }
  }
  changeActiveDataGraphic(int index){
    activeDataGraphic[index]=!activeDataGraphic[index];
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
      hospitalList.add(newLocation);
    });
    hospital=hospitalList;
    if(filters[1]){
    markers.addAll(await addMarkers(hospital, Icons.local_hospital, color6,size*0.035,context));
    }


  }
  Future<void> getShelters(context)async {
    List<Location> _shelterList=[Location(24,"Albergue Transitorio",-16.520983002910345, -68.19755751373685,3),
      Location(25,"Remar Viacha",-16.49771294090049, -68.13778200949986,3),
      Location(26,"Hogar Carlos de Villegas",-16.507836752632958, -68.13134040251619,3),
      Location(27,"Hogar Virgen de Copacabana",-16.536528470964985, -68.18857531889586,3)];
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
      Location newLocation=Location.fromJson(element, 0);
      cities.add(newLocation);
    });
    print("cities");
    if(response.statusCode==200){
      print(cities);
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
    print("data");
    print(resJson);
    LocationData country=LocationData.fromJson(resJson);
    if(response.statusCode==200){
      locationData=country;
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
        Location newLocation=Location.fromJson(element, 0);
        paises.add(newLocation);
      });
      print(paises[0]);
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
  getTitleMarker(title,filter){
    String tit="";
    switch(type){
      case 0:
        tit="Pais\n";
        break;
      case 1:
        tit="Departamento\n";
        break;
      case 2:
        switch(filter){
          case 0:
            tit="Municipio\n";
            break;
          case 1:
            tit="Hospital\n";
            break;
          case 2:
            tit="Farmacia\n";
            break;
          case 3:
            tit="Albergue\n";
            break;
        }
    }
    tit+=title;
    return tit;
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
        name=l.name;
        lat=l.lat;
        lon=l.lon;

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

    size=MediaQuery.of(context).size.height;
    if(type<2||(type<3&&t==2&&type>=0)){
      t==1?type++:type--;
      switch(type){
        case 0:
          if(t==2){
            selectLocation=lastLocation;
            print(lastLocation);
            lastLocation=null;
          }
          else{
            lastLocation=selectLocation;
            selectLocation=null;}
          await getCountries(context);
          break;
        case 1:
          if(t==2){
           lastLocation=lastLastLocation;
          }
          else{
            lastLocation=selectLocation;
            selectLocation=null;

          }
          await getCities(context);
          break;
        case 2:
          if(t==2){
            lastLastLocation=lastLocation;

          }
          else{
            lastLastLocation=lastLocation;
            lastLocation=selectLocation;
            print(lastLocation);
          }
          await getMunicipality(context);
          await getHospital(context);
          await getDrugstore(context);
          await getShelters(context);
          break;
      }
    }

}
  Future<void> changeFilter(idFilter,context)async{
    print("filte");
    filters[idFilter]=!filters[idFilter];
    markers.clear();
    print(filters);
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
}