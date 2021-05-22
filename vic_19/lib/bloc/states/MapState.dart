
import 'package:equatable/equatable.dart';
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
  Location _lastLocation;
  Set<Polygon> _area;
  MaploadMarkersOkState(this._zoom, this._markers,this._type,this._centerMap,this._lastLocation,this._area);

  @override
  List<Object> get props=>[_zoom,_markers,_type,_centerMap,_lastLocation,_area];

}
class MapSelectLocationState extends MapState{
  Location _locations;
  Location _lastLocations;

  MapSelectLocationState(this._locations,this._lastLocations);

  @override
  List<Object> get props=>[_locations,_lastLocations];
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
  LocationData _locationData;
  MapGraphicsOkState(this._locationData);
  @override
  List<Object> get props=>[_locationData];
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

  ChangeActiveDataGraphicState(this._list);

  @override
  List<Object> get props=>[_list];

}