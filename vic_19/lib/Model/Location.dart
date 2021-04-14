class Location{
  int _idLocation;
  String _name;
  double _lat;
  double _lon;


  Location(this._idLocation,this._name, this._lat, this._lon);

  double get lon => _lon;

  set lon(double value) {
    _lon = value;
  }

  double get lat => _lat;

  set lat(double value) {
    _lat = value;
  }

  int get idLocation => _idLocation;

  set idLocation(int value) {
    _idLocation = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}