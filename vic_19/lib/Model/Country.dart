class Country{
  int _idCountry;
  String _name;
  double _lat;
  double _lon;


  Country(this._idCountry,this._name, this._lat, this._lon);

  double get lon => _lon;

  set lon(double value) {
    _lon = value;
  }

  double get lat => _lat;

  set lat(double value) {
    _lat = value;
  }

  int get idCountry => _idCountry;

  set idCountry(int value) {
    _idCountry = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}