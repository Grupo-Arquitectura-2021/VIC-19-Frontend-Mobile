
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vic_19/Model/Location.dart';

abstract class MapEvent extends Equatable{
}
class GetCountriesEvent extends MapEvent{
  BuildContext _context;

  GetCountriesEvent(this._context);

  @override
  List<Object> get props => [_context];

}
class SelectLocationEvent extends MapEvent{
  Location _location;

  SelectLocationEvent(this._location);

  @override
  List<Object> get props => [_location];

}
class SelectFilterEvent extends MapEvent{
  int _idFilter;
  BuildContext _context;
  SelectFilterEvent(this._idFilter,this._context);

  @override
  List<Object> get props => [_idFilter,_context];
}
class MapGraphicsEvent extends MapEvent{
  DateTime _date;
  MapGraphicsEvent(this._date);

  @override
  List<Object> get props => [_date];
}
class MapMainMapEvent extends MapEvent{

  @override
  List<Object> get props => [];
}
class MapExpandEvent extends MapEvent{
  BuildContext _context;
  int _type;
  MapExpandEvent(this._context,this._type);
  @override
  List<Object> get props => [_context,_type];
}
class ChangeActiveDataGraphicEvent extends MapEvent{
  final int _index;

  ChangeActiveDataGraphicEvent(this._index);
  @override
  List<Object> get props => [_index];

}