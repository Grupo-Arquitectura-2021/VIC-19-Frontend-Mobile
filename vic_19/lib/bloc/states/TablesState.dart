
import 'package:equatable/equatable.dart';
import 'package:vic_19/Model/LocationData.dart';

abstract class TablesState extends Equatable{
}
class TablesCitiesOkState extends TablesState{
  List<LocationData> _data;
  DateTime _dateTime;
  TablesCitiesOkState(this._data,this._dateTime);

  @override
  List<Object> get props=>[_data,_dateTime];
}
class TablesMunicipalityOkState extends TablesState{
  List<LocationData> _data;
  DateTime _dateTime;
  // int _cityId;
  String _cityName;
  TablesMunicipalityOkState(this._data,this._dateTime,this._cityName);

  @override
  List<Object> get props=>[_data,_dateTime,_cityName];
}
class TablesInitState extends TablesState{

  @override
  List<Object> get props=>[];
}
class TablesLoadingState extends TablesState{

  @override
  List<Object> get props=>[];
}