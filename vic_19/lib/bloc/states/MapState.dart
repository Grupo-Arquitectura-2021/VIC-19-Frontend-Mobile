
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vic_19/Model/Country.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';

abstract class MapState extends Equatable{
}
class MapInitialState extends MapState{
  @override
  List<Object> get props=>[];
}
class MapLoadingMarkersState extends MapState{
  @override
  List<Object> get props=>[];
}
class MaploadCountriesOkState extends MapState{
  double _zoom;
  var _markers;
  MaploadCountriesOkState(this._zoom, this._markers);

  @override
  List<Object> get props=>[_zoom,_markers];

}
class MapSelectCountryState extends MapState{
  Country _country;

  MapSelectCountryState(this._country);

  @override
  List<Object> get props=>[_country];
}
class MapFilterOkState extends MapState{
  Set<Marker> _markers;
  List<bool> _filters;


  MapFilterOkState(this._markers, this._filters);

  @override
  List<Object> get props=>[_markers,_filters];
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