
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';

abstract class TablesEvent extends Equatable{
}
class TablesGetCitiesEvent extends TablesEvent{
  TablesGetCitiesEvent();
  @override
  List<Object> get props => [];
}

class TablesGetMunicipalityEvent extends TablesEvent{
  LocationData _location;

  TablesGetMunicipalityEvent(this._location);

  @override
  List<Object> get props => [_location];

}
