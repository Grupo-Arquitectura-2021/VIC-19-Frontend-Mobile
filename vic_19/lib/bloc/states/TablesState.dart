
import 'package:equatable/equatable.dart';
import 'package:vic_19/Model/LocationData.dart';

abstract class TablesState extends Equatable{
}
class TablesCitiesOkState extends TablesState{
  List<LocationData> _data;

  TablesCitiesOkState(this._data);

  @override
  List<Object> get props=>[_data];
}
class TablesMunicipalityOkState extends TablesState{
  List<LocationData> _data;


  TablesMunicipalityOkState(this._data);

  @override
  List<Object> get props=>[_data];
}
class TablesInitState extends TablesState{

  @override
  List<Object> get props=>[];
}
class TablesLoadingState extends TablesState{

  @override
  List<Object> get props=>[];
}