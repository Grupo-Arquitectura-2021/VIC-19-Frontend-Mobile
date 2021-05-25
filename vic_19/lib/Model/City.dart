import 'package:vic_19/Model/Location.dart';

class City extends Location{
  City(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl() {
    return "/country/";
  }
  City.fromJson(json):super.fromJson(json);

  @override
  getTitle() {
    return "Ciudad";
  }


}