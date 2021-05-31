import 'package:vic_19/Model/Location.dart';

class Hospital extends Location{
  Hospital(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl(String date) {
    return "/country/";
  }
  @override
  getUrlStatistics(String date) {
    return "";
  }
  Hospital.fromJson(json):super.fromJson(json);
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
    return "Hospital";
  }
}