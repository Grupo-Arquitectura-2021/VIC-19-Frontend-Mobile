import 'package:vic_19/Model/Location.dart';

class Country extends Location{
  Country(int idLocation, String locationName, double latitude, double longitude, int type) : super(idLocation, locationName, latitude, longitude, type);

  @override
  getUrl() {
    return "/country/";
  }

}