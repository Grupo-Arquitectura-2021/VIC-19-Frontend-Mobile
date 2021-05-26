

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
       await _mapR.getCountries(event.props[0]);
       yield MaploadMarkersOkState( _mapR.zoom, _mapR.markers,_mapR.type,_mapR.centerMap,_mapR.locationHistory,_mapR.area);
     }
     catch(e){
       print("Error al obtener paises$e");
     }
   }
   else if(event is SelectLocationEvent){
     try{
       yield MapSelectLocationState(event.props[0],_mapR.locationHistory);
     }
     catch(e){
       print("ERROR AL SELECCIONAR: $e");
     }
   }
   else if(event is SelectFilterEvent){

     try{
       yield MapLoadingState();
       await _mapR.changeFilter(event.props[0], event.props[1]);
       yield MapFilterOkState(_mapR.markers, _mapR.filters);
     }
     catch(e){
       print("ERROR AL CAMBIAR EL FILTRO: $e");
     }
   }
   else if(event is MapGraphicsEvent){
     try{
       yield MapGraphicsOkState();
     }
     catch(e){
       print("ERROR AL CAMBIAR A GRAFICOS: $e");
     }
   }
   else if(event is MapExpandEvent){
     try{
       yield MapLoadingState();
       await _mapR.expandMap(event.props[0],event.props[1]);
       yield MaploadMarkersOkState( _mapR.zoom, _mapR.markers,_mapR.type,_mapR.centerMap,_mapR.locationHistory,_mapR.area);
     }
     catch(e){
       print("ERROR AL EXPANDIR EL MAPA: $e");
     }
   }
   else if (event is MapMainMapEvent){
     try{
       yield MapMainMapOkState();
     }
     catch(e){
       print("ERROR AL VOLVER AL MAPA: $e");
     }
   }

  }
}