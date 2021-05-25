import 'package:vic_19/Model/Location.dart';

class Shelter extends Location{
  Shelter(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl() {
    return "/country/";
  }
  Shelter.fromJson(json):super.fromJson(json);

  @override
  getTitle() {
    return "Albergue";
  }
}