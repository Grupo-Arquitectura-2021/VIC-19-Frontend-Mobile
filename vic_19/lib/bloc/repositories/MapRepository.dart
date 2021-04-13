import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vic_19/Model/Country.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/util/MapUtils.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';

class MapRepository {
  double _zoom;
  List<bool> _filters;
  String _title;
  int _idCountry;
  int _idCity;
  List<Country> _countries;
  Set<Marker> _markers;
  int _type;


  int get type => _type;

  set type(int value) {
    _type = value;
  }

  int get idCountry => _idCountry;

  set idCountry(int value) {
    _idCountry = value;
  }

  MapRepository(){
    countries=[];
    zoom=7;
    filters=[true,false,false,false];
    title="";
    type=0;
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


  List<Country> get countries => _countries;

  set countries(List<Country> value) {
    _countries = value;
  }

  Set<Marker> get markers => _markers;

  set markers(Set<Marker> value) {
    _markers = value;
  }

  Future<void> getCountries(context)async {
    await Future.delayed(Duration(seconds: 2));
    List<Country> paises=[Country(1,"Bolivia",-17.4364322,-64.9581047),
      Country(2,"Brasil",-11.6570027,-60.4375673),
      Country(3,"Peru",-14.134636, -70.929510),
      Country(4,"Chile",-23.664653, -69.362242),
      Country(5,"Paraguay",-22.9604184,-59.6220523),
      Country(6,"Argentina",-26.5972821,-63.175)];
    countries=paises;
    zoom=5;
    markers=await addMarkers(paises, Icons.location_on, color4,context);

  }
  Future<Set<Marker>> addMarkers(List list,icon,color,context)async{
    Set<Marker> markerAux=Set();
    var id;
    var name;
    var lat;
    var lon;
    for(var l in list) {
      if(l is Country){
        id=l.idCountry.toString();
        name=l.name;
        lat=l.lat;
        lon=l.lon;
      }

      final marker = await MapUtils.createCustomMarkerBitmap(
          name, color, icon);
      markerAux.add(Marker(markerId: MarkerId(id),
          position: LatLng(lat, lon),
          icon: marker,
          consumeTapEvents: false,
          flat: false,
          draggable: false,
          onTap: () {
            if(l is Country){
              _idCountry=l.idCountry;
              print(context);
              BlocProvider.of<MapBLoc>(context).add(SelectCountryEvent(l));
            }
          }));
    }
    return markerAux;
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
              switch(type){
                case 0:
                    markers=await addMarkers(countries, Icons.location_on, color4,context);
                  break;
              }
              break;

          }
        }
    }

  }

  int get idCity => _idCity;

  set idCity(int value) {
    _idCity = value;
  }


}