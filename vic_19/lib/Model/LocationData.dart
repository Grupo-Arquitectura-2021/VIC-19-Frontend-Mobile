class LocationData{
  int _idLocation;
  String _name;
  DateTime _dateLocationCovid;
  int _deceased;
  int _confirmed;
  int _vaccinated;
  int _total;
  int _recovered;

  LocationData();


  LocationData.fromLocationData(this._idLocation, this._name, this._dateLocationCovid, this._deceased,this._confirmed,
      this._vaccinated,this._total,this._recovered);

  int get deceased => _deceased;

  set deceased(int value) {
    _deceased = value;
  }



  int get confirmed => _confirmed;

  set confirmed(int value) {
    _confirmed = value;
  }

  int get recovered => _recovered;

  set recovered(int value) {
    _recovered = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get idLocation => _idLocation;

  set idLocation(int value) {
    _idLocation = value;
  }

  int get total => _total;

  set total(int value) {
    _total = value;
  }

  int get vaccinated => _vaccinated;

  set vaccinated(int value) {
    _vaccinated = value;
  }
  LocationData.fromJson(json){
    idLocation=1;
    name=json["nameLocationCovid"];
    deceased=json["deathCases"];
    confirmed=json["confirmedCases"];
    vaccinated=json["vaccinated"];
    total=json["cumulativeCases"];
    recovered=json["recuperated"];
    _dateLocationCovid=DateTime.parse(json["dateLocationCovid"]);

  }

  DateTime get dateLocationCovid => _dateLocationCovid;

  set dateLocationCovid(DateTime value) {
    _dateLocationCovid = value;
  }
}