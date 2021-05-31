class Statistics {
  double _media;
  double _variance;
  List _confidenceInterval;

  Statistics();

  Statistics.fromStatistics(this._media,this._variance,this._confidenceInterval);




  Statistics.fromJson(Map<String, dynamic> json) {
    media= json['media'];
    variance = json['variance'];
    _confidenceInterval = [json['confidenceInterval'][0],json['confidenceInterval'][1]];
  }

  List get confidenceInterval {

    double v1=_confidenceInterval[0];
    double v2=_confidenceInterval[1];
    return[v1.toStringAsFixed(2),v2.toStringAsFixed(2)];}

  set confidenceInterval(List value) {
    _confidenceInterval = value;
  }

  double get variance => double.parse(_variance.toStringAsFixed(2));

  set variance(double value) {
    _variance = value;
  }

  double get media => double.parse(_media.toStringAsFixed(2));

  set media(double value) {
    _media = value;
  }


}