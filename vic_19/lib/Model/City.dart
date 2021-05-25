import 'package:vic_19/Model/Location.dart';

class City extends Location{
  City(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl(String date) {
    return "city/allInfo/${this.idLocation}?date=$date";
  }
  City.fromJson(json):super.fromJson(json);

  @override
  getTitle() {
    return "Ciudad";
  }


}