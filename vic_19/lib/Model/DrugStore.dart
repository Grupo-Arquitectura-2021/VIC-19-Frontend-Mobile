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
  getUrlPredictLS(String date) {
    return "country/leastSquaresAllInfo/${this.idLocation}/$date";
  }
  @override
  getUrlPredictAI(String date) {
    return "country/absoluteIncreaseAllInfo/${this.idLocation}/$date";
  }
  @override
  getUrlPredictPI(String date) {
    return "country/percentageIncreaseAllInfo/${this.idLocation}/$date";
  }
  @override
  getTitle() {
    return "Farmacia";
  }
}