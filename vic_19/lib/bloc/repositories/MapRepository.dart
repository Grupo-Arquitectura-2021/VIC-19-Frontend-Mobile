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

  Future<void> getMunicipality(context)async {
    await Future.delayed(Duration(seconds: 2));
    List<Location> municipality=[Location(1,"La Paz",-16.48920066821045, -68.14260226389267),
      Location(2,"El Alto",-16.499388273844996, -68.20500327360526),
      Location(3,"Palca",-16.560703122358806, -67.9523169532082),
      Location(4,"Mecapaca",-16.667937020029967, -68.01828549716129),
      Location(5,"Achocalla",-16.574975300040517, -68.16925482192639),
      Location(6,"Viacha",-16.649509323339043, -68.29731419297877),
      Location(7,"Laja",-16.53326672290246, -68.38563860039085),
      Location(8,"Pucarani",-16.399741665683763, -68.4767678555612),];
    locations=municipality;
    zoom=7.5 ;
    type=2;
    centerMap=LatLng(-14.48920066821045, -68.14260226389267);
    markers=await addMarkers(municipality, Icons.location_on, color4,35,context);

  }
  Future<void> getDrugsStore(context)async {
    List<Location> drugStoreList=[Location(9,"Farmacia Por Ti",-16.48957542357021, -68.20142423123032),
      Location(10,"Super Farmacia Virgen de Copacabana",-16.505852472111464, -68.16305325284088),
      Location(11,"Farmacia Gran Chaco",-16.514967466129153, -68.21714865977809),
      Location(12,"Farmacias Bolivia",-16.493570677055626, -68.13190995115573),
      Location(13,"Farmacias Bolivia",-16.510457299578828, -68.12247191142971),
      Location(14,"Farmacias Bolivia",-16.479017386826108, -68.1212058323144),
      Location(15,"FarmaCorp",-16.53826239478578, -68.06634735456959),];
    drugstores=drugStoreList;
    if(filters[2]){
    markers.addAll(await addMarkers(drugstores, Icons.local_pharmacy, color3,25,context));}

  }
  Future<void> getHospital(context)async {
    List<Location> hospitalList=[Location(16,"Hospital de El Alto Sur",-16.525026864458482, -68.22341050395703),
      Location(17,"Hospital del norte",-16.484208946561754, -68.2055577224549),
      Location(18,"Hospital Arco iris",-16.48409176143849, -68.12036953146652),
      Location(19,"Hospital Pucarani",-16.401320297987237, -68.47573248966475),
      Location(20,"Hospital de Laja",-16.53169992701307, -68.38578191597261),
      Location(21,"Hospital obrero",-16.499186356840237, -68.11818314496122),
      Location(22,"Hospital Boliviano Holandes",-16.52142904552383, -68.15408302126085),
      Location(23,"Hospital Cota Cota",-16.53976095296443, -68.06531729080666),];
    hospital=hospitalList;
    if(filters[1]){
    markers.addAll(await addMarkers(hospital, Icons.local_hospital, color6,25,context));
    }

  }
  Future<void> getShelters(context)async {
    List<Location> _shelterList=[Location(24,"Albergue Transitorio",-16.520983002910345, -68.19755751373685),
      Location(25,"Remar Viacha",-16.49771294090049, -68.13778200949986),
      Location(26,"Hogar Carlos de Villegas",-16.507836752632958, -68.13134040251619),
      Location(27,"Hogar Virgen de Copacabana",-16.536528470964985, -68.18857531889586)];
    shelters=_shelterList;
    if(filters[3]){
      markers.addAll(await addMarkers(shelters, Icons.local_hotel, color2,25,context));}

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
    markers=await addMarkers(cities, Icons.location_on, color4,35,context);

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
    markers=await addMarkers(paises, Icons.location_on, color4,35,context);

  }
  getTitleMarker(title,filter){
    String tit="";
    switch(type){
      case 0:
        tit="Paisdddddddddddddd\n";
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
              BlocProvider.of<MapBLoc>(context).add(SelectLocationEvent(l));

          }));
    }
    return markerAux;
  }
  Future<void> expandMap(context,t)async{
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
          await getDrugsStore(context);
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
                    markers.addAll(await addMarkers(locations, Icons.location_on, color4,type ==0?35:type ==1?35:25,context));
              break;

            case 1:
              markers.addAll(await addMarkers(hospital, Icons.local_hospital, color6,type ==0?35:type ==1?34:25,context));
              break;

            case 2:
              markers.addAll(await addMarkers(drugstores, Icons.local_pharmacy, color3,type ==0?35:type ==1?34:25,context));
              break;

            case 3:
              markers.addAll(await addMarkers(shelters, Icons.local_hotel, color2,type ==0?35:type ==1?35:25,context));
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