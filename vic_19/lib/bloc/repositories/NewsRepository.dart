
import 'dart:convert';

import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/util/ApiUrl.dart';
import 'package:http/http.dart' as http;
class NewsRepository {
   List<News> _news;
   int page;

   List<News> get news{
     return _news;
   }

   set news(List<News> value) {
     _news = value;
   }
   NewsRepository(){
     page=-1;
     news=List();
   }
  Future <void> getNews()async{
     await Future.delayed(Duration(seconds: 2));
      page++;
      String url=ApiUrl+"news?n=10&i=${page*10}";
      var res = await http.get(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if(res.statusCode == 200){
        var body = json.decode(utf8.decode(res.bodyBytes));
        var bodyList=body["newsList"];
        var newsList3=List<News>();
        for(var n in bodyList){
          newsList3.add(News.fromJson(n));
        }
        news.addAll(newsList3);
      }
    }
  }


