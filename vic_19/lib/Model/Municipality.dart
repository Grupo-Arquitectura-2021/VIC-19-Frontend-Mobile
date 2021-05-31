import 'package:vic_19/Model/Location.dart';

class Municipality extends Location{
  Municipality(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl(String date) {
    return "municipality/allInfo/${this.idLocation}?date=$date";
  }

  @override
  getUrlStatistics(String date) {
    return "municipality/statistics/${this.idLocation}?date=$date";
  }
  Municipality.fromJson(json):super.fromJson(json);
  @override
  getUrlPredictLS(String date) {
    return "municipality/leastSquaresAllInfo/${this.idLocation}/$date";
  }
  @override
  getUrlPredictAI(String date) {
    return "municipality/absoluteIncreaseAllInfo/${this.idLocation}/$date";
  }
  @override
  getUrlPredictPI(String date) {
    return "municipality/percentageIncreaseAllInfo/${this.idLocation}/$date";
  }
  @override
  getTitle() {
    return "Municipio";
  }
}