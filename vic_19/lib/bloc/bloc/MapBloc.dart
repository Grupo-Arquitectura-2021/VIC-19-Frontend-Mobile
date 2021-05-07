

import 'package:bloc/bloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';
import 'package:vic_19/bloc/repositories/MapRepository.dart';
import 'package:vic_19/bloc/states/MapState.dart';

class MapBloc extends Bloc<MapEvent,MapState>{
  MapRepository _mapR;
  MapBloc(this._mapR);
 @override
  MapState get initialState => MapInitialState();

 @override
  Stream<MapState> mapEventToState(MapEvent event) async*{
   if(event is GetCountriesEvent){
     try{
       yield MapLoadingState();
       print(event.props[0]);
       await _mapR.getCountries(event.props[0]);
       yield MaploadMarkersOkState( _mapR.zoom, _mapR.markers,_mapR.type,_mapR.centerMap,_mapR.lastLocation,_mapR.area);
     }
     catch(e){
       print(e);
     }
   }
   else if(event is SelectLocationEvent){
     try{
       yield MapSelectLocationState(event.props[0],_mapR.lastLocation);
     }
     catch(e){
       print(e);
     }
   }
   else if(event is SelectFilterEvent){

     try{
       yield MapLoadingState();
       await _mapR.changeFilter(event.props[0], event.props[1]);
       yield MapFilterOkState(_mapR.markers, _mapR.filters);
     }
     catch(e){
       print(e);
     }
   }
   else if(event is MapGraphicsEvent){
     try{
       yield MapLoadingGraphicsState();
       await Future.delayed(Duration(seconds: 2));
       await _mapR.getDataLocationCountry(event.props[0]);
       yield MapGraphicsOkState(_mapR.locationData);
     }
     catch(e){
       print(e);
     }
   }
   else if(event is MapExpandEvent){
     try{
       yield MapLoadingState();
       await _mapR.expandMap(event.props[0],event.props[1]);
       yield MaploadMarkersOkState( _mapR.zoom, _mapR.markers,_mapR.type,_mapR.centerMap,_mapR.lastLocation,_mapR.area);
     }
     catch(e){
       print(e);
     }
   }
   else if (event is MapMainMapEvent){
     try{
       yield MapMainMapOkState();
     }
     catch(e){

     }
   }

  }
}