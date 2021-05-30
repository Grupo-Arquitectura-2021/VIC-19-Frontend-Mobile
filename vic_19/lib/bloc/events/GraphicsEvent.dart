
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:vic_19/Model/Location.dart';

abstract class GraphicsEvent extends Equatable{
}
class ChangeActiveDataGraphicEvent extends GraphicsEvent{
  final int _index;

  ChangeActiveDataGraphicEvent(this._index);
  @override
  List<Object> get props => [_index];

}
class GetDataGraphicEvent extends GraphicsEvent{
  final Location _location;
  final DateTime _dateTime;

  GetDataGraphicEvent(this._dateTime,this._location);
  @override
  List<Object> get props => [_dateTime,_location];

}
class ChangeDateDataGraphicEvent extends GraphicsEvent{
  final DateTime _dateTime;

  ChangeDateDataGraphicEvent(this._dateTime);
  @override
  List<Object> get props => [_dateTime];

}
class ChangeActiveChartEvent extends GraphicsEvent{
  final int _index;

  ChangeActiveChartEvent(this._index);

  @override
  List<Object> get props => [_index];

}
class ChangeActiveGraphicEvent extends GraphicsEvent{
  final int _index;

  ChangeActiveGraphicEvent(this._index);

  @override
  List<Object> get props => [_index];

}
class DownloadChartsEvent extends GraphicsEvent{
  final RenderRepaintBoundary _render;

  DownloadChartsEvent(this._render);

  @override
  List<Object> get props => [_render];

}