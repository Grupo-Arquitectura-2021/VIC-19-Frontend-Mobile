import 'package:fl_chart/fl_chart.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/Statistics.dart';

class LocationDataStatistics{
  Statistics _confirmedStatistics;
  Statistics _recoveredStatistics;
  Statistics _deathStatistics;
  Statistics _vaccinatedStatistics;
  List<List<FlSpot>> _dataPoints;
  List<LocationData> _dataList;
  List<String> _labelX;
  int _minX;
  int _intY;
  int _intX;

  int get minX => _minX;

  set minX(int value) {
    _minX = value;
  }

  List<LocationData> get dataList => _dataList;

  set dataList(List<LocationData> value) {
    _dataList = value;
  }

  Statistics get confirmedStatistics => _confirmedStatistics;

  set confirmedStatistics(Statistics value) {
    _confirmedStatistics = value;
  }

  Statistics get recoveredStatistics => _recoveredStatistics;

  set recoveredStatistics(Statistics value) {
    _recoveredStatistics = value;
  }

  Statistics get vaccinatedStatistics => _vaccinatedStatistics;

  set vaccinatedStatistics(Statistics value) {
    _vaccinatedStatistics = value;
  }

  Statistics get deathStatistics => _deathStatistics;

  set deathStatistics(Statistics value) {
    _deathStatistics = value;
  }


  List<List<FlSpot>> get dataPoints => _dataPoints;

  set dataPoints(List<List<FlSpot>> value) {
    _dataPoints = value;
  }

  int get intY => _intY;

  set intY(int value) {
    _intY = value;
  }

  List<String> get labelX => _labelX;

  set labelX(List<String> value) {
    _labelX = value;
  }

  int get intX => _intX;

  set intX(int value) {
    _intX = value;
  }
}