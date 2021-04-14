import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/util/MapUtils.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';

class MapRepository {
  double _zoom;
  List<bool> _filters;
  String _title;
  int _idlocation;
  List<Location> _locations;
  Set<Marker> _markers;
  int _type;
  LatLng _centerMap;


  int get type => _type;

  set type(int value) {
    _type = value;
  }


  int get idlocation => _idlocation;

  set idlocation(int value) {
    _idlocation = value;
  }

  MapRepository(){
    locations=[];
    zoom=7;
    filters=[true,false,false,false];
    title="";
    type=0;
    _centerMap=LatLng(-16.2256651,-65.0455838);
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

  Future<void> getMunicipality(context)async {
    await Future.delayed(Duration(seconds: 2));
    List<Location> municipality=[Location(1,"La Paz",-16.08354782509485, -68.06967003644534),
      Location(2,"El Alto",-17.08354782509485, -68.06967003644534),
      Location(3,"Palca",-18.08354782509485, -68.06967003644534),
      Location(4,"Mecapaca",-19.08354782509485, -68.06967003644534),
      Location(5,"Achocalla",-16.08354782509485, -68.06967003644534),
      Location(6,"Viacha",-17.58354782509485, -68.06967003644534),
      Location(7,"Laja",-18.58354782509485, -68.06967003644534),
      Location(8,"Pucarani",-16.58354782509485, -68.06967003644534),];
    locations=municipality;
    zoom=7;
    type=1;
    centerMap=LatLng(-16.08354782509485, -68.06967003644534);
    markers=await addMarkers(municipality, Icons.location_on, color4,context);

  }
  Future<void> getCities(context)async {
    await Future.delayed(Duration(seconds: 2));
    List<Location> cities=[Location(1,"La Paz",-16.08354782509485, -68.06967003644534),
      Location(2,"Oruro",-19.358081865080415, -67.95256482218397),
      Location(3,"Potosi",-21.25680123243468, -67.12895296863799),
      Location(4,"Cochabamba",-17.198275410380212, -65.05790819645144),
      Location(5,"Chuquisaca",-19.79806384524433, -64.37655968335869),
      Location(6,"Tarija",-21.60047499330198, -64.14467146894596),
      Location(7,"Pando",-11.597779067996576, -66.78552003036548),
      Location(8,"Beni",-14.001738953430753, -64.82698706230555),
      Location(9,"Santa Cruz",-17.709650631754297, -61.05660654016773)];
    locations=cities;
    zoom=5.5;
    type=1;
    centerMap=LatLng(-16.2256651,-63.5455838);
    markers=await addMarkers(cities, Icons.location_on, color4,context);

  }

  Future<void> getCountries(context)async {
    await Future.delayed(Duration(seconds: 2));
    List<Location> paises=[Location(1,"Bolivia",-17.4364322,-64.9581047),
      Location(2,"Brasil",-11.6570027,-60.4375673),
      Location(3,"Peru",-14.134636, -70.929510),
      Location(4,"Chile",-23.664653, -69.362242),
      Location(5,"Paraguay",-22.9604184,-59.6220523),
      Location(6,"Argentina",-26.5972821,-63.175)];
    locations=paises;
    zoom=5;
    type=0;
    centerMap=LatLng(-16.2256651,-65.0455838);
    markers=await addMarkers(paises, Icons.location_on, color4,context);

  }
  Future<Set<Marker>> addMarkers(List<Location> list,icon,color,context)async{
    Set<Marker> markerAux=Set();
    var id;
    var name;
    var lat;
    var lon;
    for(var l in list) {
        id=l.idLocation.toString();
        name=l.name;
        lat=l.lat;
        lon=l.lon;

      final marker = await MapUtils.createCustomMarkerBitmap(
          name, color, icon);
      markerAux.add(Marker(markerId: MarkerId(id),
          position: LatLng(lat, lon),
          icon: marker,
          consumeTapEvents: false,
          flat: false,
          draggable: false,
          onTap: () {
              _idlocation=l.idLocation;
              BlocProvider.of<MapBLoc>(context).add(SelectLocationEvent(l));

          }));
    }
    return markerAux;
  }
  Future<void> expandMap(context)async{
    type++;
    switch(type){
      case 0:
        await getCountries(context);
        break;
      case 1:
        await getCities(context);

        break;
      case 2:
        await getMunicipality(context);
        break;
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
                    markers=await addMarkers(locations, Icons.location_on, color4,context);
              break;

          }
        }
    }

  }



}