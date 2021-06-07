abstract class Location{
  int _idLocation;
  String _locationName;
  double _latitude;
  double _longitude;


  Location(this._idLocation, this._locationName, this._latitude, this._longitude);




  int get idLocation => _idLocation;

  set idLocation(int value) {
    _idLocation = value;
  }
  Location.fromJson(json){
    idLocation=json["idLocation"];
    longitude=json["longitude"];
    latitude=json["latitude"];
    locationName=json["locationName"];
  }

  String get locationName => _locationName;

  set locationName(String value) {
    _locationName = value;
  }
  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  String getUrl(String date);
  String getUrlStatistics(String date);
  String getTitle();
  String getUrlPredictLS(String date);
  String getUrlPredictAI(String date);
  String getUrlPredictPI(String date);
  String getUrlPredictBrown(String date);
}