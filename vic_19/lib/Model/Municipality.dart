import 'package:vic_19/Model/Location.dart';

class Municipality extends Location{
  Municipality(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl() {
    return "/country/";
  }
  Municipality.fromJson(json):super.fromJson(json);

  @override
  getTitle() {
    return "Municipio";
  }
}