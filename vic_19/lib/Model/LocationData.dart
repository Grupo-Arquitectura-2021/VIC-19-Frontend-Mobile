class LocationData{
  int _idLocation;
  String _name;
  int _recovered;
  int _confirmed;
  int _deceased;
  int _vaccinated;
  int _total;

  LocationData();


  LocationData.fromLocationData(this._idLocation, this._name, this._recovered, this._confirmed,
      this._deceased,this._vaccinated,this._total);

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
}