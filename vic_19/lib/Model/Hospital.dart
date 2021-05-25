import 'package:vic_19/Model/Location.dart';

class Hospital extends Location{
  Hospital(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl(String date) {
    return "/country/";
  }
  Hospital.fromJson(json):super.fromJson(json);

  @override
  getTitle() {
    return "Hospital";
  }
}