
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/LocationDataStatistics.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';

abstract class GraphicsState extends Equatable{
}
class GraphicsInitialState extends GraphicsState{
  @override
  List<Object> get props=>[];
}

class GetDataGraphicsOkState extends GraphicsState{
  final LocationData _locationData;
  final List<bool> _list;
  final List<List<FlSpot>> _listPoints;
  final int _intX;
  final int _intY;
  final int _minY;
  final List<String> _xLabels;
  final LocationDataStatistics _locationDataStatistics;


  GetDataGraphicsOkState(this._locationData,
      this._list, this._listPoints,  this._intX,
      this._intY, this._minY, this._xLabels,this._locationDataStatistics);

  @override
  List<Object> get props=>[this._locationData,
    this._list, this._listPoints, this._intX,
    this._intY, this._minY, this._xLabels,this._locationDataStatistics];

}
class ChangeActiveDataGraphicState extends GraphicsState{
  final List<bool> _list;
  final List<List<FlSpot>> _listPoints;
  final int _intX;
  final int _intY;
  final int _minY;
  final List<String> _xlabels;


  ChangeActiveDataGraphicState(this._list, this._listPoints, this._intX,
      this._intY, this._minY, this._xlabels);

  @override
  List<Object> get props=>[
    this._list, this._listPoints, this._intX,
  this._intY, this._minY, this._xlabels];

}
class LoadingGraphicsState extends GraphicsState{
  @override
  List<Object> get props=>[];

}
class ChangeActiveChartState extends GraphicsState{
  final int _index;

  ChangeActiveChartState(this._index);

  @override
  List<Object> get props => [_index];

}
class ChangeActiveGraphicState extends GraphicsState{
  final int _index;

  ChangeActiveGraphicState(this._index);

  @override
  List<Object> get props => [_index];

}
class SaveFileOkState extends GraphicsState{

  @override
  List<Object> get props => [];

}
class GetPredictDataOkState extends GraphicsState{
  final LocationDataStatistics _locationDataStatistics;

  GetPredictDataOkState(this._locationDataStatistics);

  @override
  List<Object> get props => [_locationDataStatistics];

}