import 'package:vic_19/Model/Location.dart';

class DrugStore extends Location{
  DrugStore(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl(String date) {
    return "/country/";
  }
  @override
  getUrlStatistics(String date) {
    return "country/statistics/${this.idLocation}?date=$date";
  }
  DrugStore.fromJson(json):super.fromJson(json);

  @override
  getTitle() {
    return "Farmacia";
  }
}