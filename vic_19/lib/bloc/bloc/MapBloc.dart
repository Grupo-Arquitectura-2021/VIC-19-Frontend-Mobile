

import 'package:bloc/bloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';
import 'package:vic_19/bloc/repositories/MapRepository.dart';
import 'package:vic_19/bloc/states/MapState.dart';

class MapBLoc extends Bloc<MapEvent,MapState>{
  MapRepository _mapR;
  MapBLoc(this._mapR);
 @override
  MapState get initialState => MapInitialState();

 @override
  Stream<MapState> mapEventToState(MapEvent event) async*{
   if(event is GetCountriesEvent){
     try{
       yield MapLoadingMarkersState();
       print(event.props[0]);
       await _mapR.getCountries(event.props[0]);
       yield MaploadCountriesOkState( _mapR.zoom, _mapR.markers);
     }
     catch(e){
       print(e);
     }
   }
   else if(event is SelectCountryEvent){
     try{
       yield MapSelectCountryState( event.props[0]);
     }
     catch(e){
       print(e);
     }
   }
   else if(event is SelectFilterEvent){

     try{
       yield MapLoadingMarkersState();
       await _mapR.changeFilter(event.props[0], event.props[1]);
       yield MapFilterOkState(_mapR.markers, _mapR.filters);
     }
     catch(e){
       print(e);
     }
   }
   else if(event is MapGraphicsEvent){
     try{
       yield MapGraphicsOkState();
     }
     catch(e){
       print(e);
     }
   }
   else if(event is MapExpandEvent){
     try{
       yield MapLoadingMarkersState();
       yield MapGraphicsOkState();
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