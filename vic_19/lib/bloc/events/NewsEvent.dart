
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/News.dart';

abstract class NewsEvent extends Equatable{
}
class NewsGetEvent extends NewsEvent{

  NewsGetEvent();

  @override
  List<Object> get props => [];
}

