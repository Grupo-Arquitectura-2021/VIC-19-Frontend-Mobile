
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
class SelectCountryEvent extends MapEvent{
  Location _location;

  SelectCountryEvent(this._location);

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
  MapGraphicsEvent();

  @override
  List<Object> get props => [];
}
class MapMainMapEvent extends MapEvent{

  @override
  List<Object> get props => [];
}
class MapExpandEvent extends MapEvent{
  BuildContext _context;
  MapExpandEvent(this._context);
  @override
  List<Object> get props => [_context];
}