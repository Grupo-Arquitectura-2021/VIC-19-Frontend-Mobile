import 'package:fl_chart/fl_chart.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/Predict.dart';
import 'package:vic_19/Model/Statistics.dart';

class LocationDataStatistics{
  Statistics _confirmedStatistics;
  Statistics _recoveredStatistics;
  Statistics _deathStatistics;
  Statistics _vaccinatedStatistics;
  Predict _confirmedPredict;
  Predict _recoveredPredict;
  Predict _deathPredict;
  Predict _vaccinatedPredict;
  List<List<FlSpot>> _dataPoints;
  List<LocationData> _dataList;
  List<String> _labelX;
  int _minX;
  int _intY;
  int _intX;
  DateTime _selectedDate;

  int get minX => _minX;


  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
  }

  set minX(int value) {
    _minX = value;
  }

  Predict get confirmedPredict => _confirmedPredict;

  set confirmedPredict(Predict value) {
    _confirmedPredict = value;
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

  Predict get recoveredPredict => _recoveredPredict;

  set recoveredPredict(Predict value) {
    _recoveredPredict = value;
  }

  Predict get deathPredict => _deathPredict;

  set deathPredict(Predict value) {
    _deathPredict = value;
  }

  Predict get vaccinatedPredict => _vaccinatedPredict;

  set vaccinatedPredict(Predict value) {
    _vaccinatedPredict = value;
  }
  LocationDataStatistics(){
    confirmedPredict=Predict();
    recoveredPredict=Predict();
    deathPredict=Predict();
    vaccinatedPredict=Predict();
  }
}