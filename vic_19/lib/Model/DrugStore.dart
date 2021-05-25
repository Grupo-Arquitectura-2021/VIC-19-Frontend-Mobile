import 'package:vic_19/Model/Location.dart';

class DrugStore extends Location{
  DrugStore(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl(String date) {
    return "/country/";
  }
  DrugStore.fromJson(json):super.fromJson(json);

  @override
  getTitle() {
    return "Farmacia";
  }
}