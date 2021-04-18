
import 'package:equatable/equatable.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/News.dart';

abstract class NewsState extends Equatable{
}
class NewsListOkState extends NewsState{
  List<News> _news;

  NewsListOkState(this._news);

  @override
  List<Object> get props=>[_news];
}
class NewsInitState extends NewsState{

  @override
  List<Object> get props=>[];
}
class NewsLoadingState extends NewsState{

  @override
  List<Object> get props=>[];
}