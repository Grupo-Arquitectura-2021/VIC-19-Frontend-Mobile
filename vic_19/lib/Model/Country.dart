import 'package:vic_19/Model/Location.dart';

class Country extends Location{
  Country(int idLocation, String locationName, double latitude, double longitude) : super(idLocation, locationName, latitude, longitude);
  @override
  getUrl(String date) {
    return "country/allInfo/${this.idLocation}?date=$date";
  }
  @override
  getUrlStatistics(String date) {
    return "country/statistics/${this.idLocation}?date=$date";
  }
  @override
  getUrlPredictBrown(String date) {
    return "country/brownModelAllInfo/${this.idLocation}/$date";
  }
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
  Country.fromJson(json):super.fromJson(json);

  @override
  getTitle() {
    return "Pais";
  }
}