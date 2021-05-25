
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';

abstract class MapState extends Equatable{
}
class MapInitialState extends MapState{
  @override
  List<Object> get props=>[];
}
class MapLoadingState extends MapState{
  @override
  List<Object> get props=>[];
}
class MaploadMarkersOkState extends MapState{
  double _zoom;
  var _markers;
  int _type;
  LatLng _centerMap;
  List<Location> _locationsHistory;
  Set<Polygon> _area;
  MaploadMarkersOkState(this._zoom, this._markers,this._type,this._centerMap,this._locationsHistory,this._area);

  @override
  List<Object> get props=>[_zoom,_markers,_type,_centerMap,_locationsHistory,_area];

}
class MapSelectLocationState extends MapState{
  Location _locations;
  List<Location> _locationsHistory;

  MapSelectLocationState(this._locations,this._locationsHistory);

  @override
  List<Object> get props=>[_locations,_locationsHistory];
}
class MapFilterOkState extends MapState{
  Set<Marker> _markers;
  List<bool> _filters;


  MapFilterOkState(this._markers, this._filters);

  @override
  List<Object> get props=>[_markers,_filters];
}
class MapLoadingGraphicsState extends MapState{
  @override
  List<Object> get props=>[];
}
class MapGraphicsOkState extends MapState{

  MapGraphicsOkState();

  @override
  List<Object> get props=>[];
}
class MapMainMapOkState extends MapState{
  @override
  List<Object> get props=>[];
}

class MapCitiesOkState extends MapState{
  double _zoom;
  var _markers;
  MapCitiesOkState(this._zoom, this._markers);

  @override
  List<Object> get props=>[_zoom,_markers];
}
class MapLoadCitiesOkState extends MapState{
  double _zoom;
  var _markers;
  MapLoadCitiesOkState(this._zoom, this._markers);
  @override
  List<Object> get props=>[_zoom,_markers];

}
class ChangeActiveDataGraphicState extends MapState{
  final List<bool> _list;
  final List<List<FlSpot>> _listPoints;
  final List<String> _xlabels;
  final List<int> _ylabels;


  ChangeActiveDataGraphicState(
      this._list, this._listPoints, this._xlabels, this._ylabels);

  @override
  List<Object> get props=>[
    this._list, this._listPoints, this._xlabels, this._ylabels];

}