

import 'package:bloc/bloc.dart';
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
       await _tabR.getCities();
       yield TablesCitiesOkState(_tabR.data);
     }
     catch(e){
       print(e);
     }
   }

  }
}