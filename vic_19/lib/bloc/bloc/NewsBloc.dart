

import 'package:bloc/bloc.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/bloc/events/NewsEvent.dart';
import 'package:vic_19/bloc/repositories/NewsRepository.dart';
import 'package:vic_19/bloc/states/NewsState.dart';

class NewsBloc extends Bloc<NewsEvent,NewsState>{
 NewsRepository _newsR;

 NewsBloc(this._newsR);

  @override
  NewsState get initialState => NewsInitState();

 @override
  Stream<NewsState> mapEventToState(NewsEvent event) async*{
   if(event is NewsGetEvent){
     try{
       yield NewsLoadingState();
       await _newsR.getNews();
       yield NewsListOkState(_newsR.news);
       // yield NewsListOkState(_newsR.news);
     }
     catch(e){
       print("entra");
       print(e);
     }
   }

  }
}