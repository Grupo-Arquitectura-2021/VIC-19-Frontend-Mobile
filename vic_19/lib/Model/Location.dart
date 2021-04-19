class Location{
  int _idLocation;
  String _locationName;
  double _latitude;
  double _longitude;
  int _type;

  Location(this._idLocation, this._locationName, this._latitude, this._longitude, this._type);

  int get type => _type;

  set type(int value) {
    _type = value;
  }

  double get lon => _longitude;

  set lon(double value) {
    _longitude = value;
  }

  double get lat => _latitude;

  set lat(double value) {
    _latitude = value;
  }

  String get name => _locationName;

  set name(String value) {
    _locationName = value;
  }

  int get idLocation => _idLocation;

  set idLocation(int value) {
    _idLocation = value;
  }
  Location.fromJson(json,type){
    idLocation=json["idLocation"];
    lon=json["longitude"];
    lat=json["latitude"];
    name=json["locationName"];
    this.type=type;
  }
}