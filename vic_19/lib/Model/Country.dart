import 'package:vic_19/Model/Location.dart';

class Country extends Location{
  Country(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl(String date) {
    return "country/allInfo/${this.idLocation}?date=$date";
  }
  Country.fromJson(json):super.fromJson(json);

  @override
  getTitle() {
    return "Pais";
  }
}