import 'package:vic_19/Model/Location.dart';

class City extends Location{
  City(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl(String date) {
    return "city/allInfo/${this.idLocation}?date=$date";
  }
  @override
  getUrlStatistics(String date) {
    return "city/statistics/${this.idLocation}?date=$date";
  }
  City.fromJson(json):super.fromJson(json);
  @override
  getUrlPredictLS(String date) {
    return "city/leastSquaresAllInfo/${this.idLocation}/$date";
  }
  @override
  getUrlPredictAI(String date) {
    return "city/absoluteIncreaseAllInfo/${this.idLocation}/$date";
  }
  @override
  getUrlPredictPI(String date) {
    return "city/percentageIncreaseAllInfo/${this.idLocation}/$date";
  }
  @override
  getTitle() {
    return "Ciudad";
  }


}