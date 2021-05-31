

import 'package:bloc/bloc.dart';
import 'package:vic_19/Model/City.dart';
import 'package:vic_19/bloc/events/TablesEvent.dart';
import 'package:vic_19/bloc/repositories/TablesRepository.dart';
import 'package:vic_19/bloc/states/TablesState.dart';

class TablesBloc extends Bloc<TablesEvent,TablesState>{
 TablesRepository _tabR;

 TablesBloc(this._tabR);

  @override
  TablesState get initialState => TablesInitState();

 @override
  Stream<TablesState> mapEventToState(TablesEvent event) async*{
   if(event is TablesGetCitiesEvent){
     try{
       yield TablesLoadingState();
       await _tabR.getCities(event.props[0]);
       yield TablesCitiesOkState(_tabR.data,event.props[0]);
     }
     catch(e){
       print(e);
     }
   }else if(event is TablesGetMunicipalityEvent){
     try{
       yield TablesLoadingState();
       City city=event.props[1];
       await _tabR.getMunicipality(event.props[0], city.idLocation);
       // await _tabR.getCities(event.props[0]);
       yield TablesMunicipalityOkState(_tabR.selectData,event.props[0],city.locationName);
       // yield TablesCitiesOkState(_tabR.data,event.props[0]);
     }
     catch(e){
       print(e);
     }
   }

  }
}