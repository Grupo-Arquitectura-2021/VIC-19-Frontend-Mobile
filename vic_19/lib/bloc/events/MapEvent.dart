
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vic_19/Model/Country.dart';

abstract class MapEvent extends Equatable{
}
class GetCountriesEvent extends MapEvent{
  BuildContext _context;

  GetCountriesEvent(this._context);

  @override
  List<Object> get props => [_context];

}
class SelectCountryEvent extends MapEvent{
  Country _country;

  SelectCountryEvent(this._country);

  @override
  List<Object> get props => [_country];

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
  MapExpandEvent();
  @override
  List<Object> get props => [];
}