import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/components/news/BottomSheet.dart';
import 'package:vic_19/components/news/NewsSingleAlert.dart';
import 'package:vic_19/util/Formatter.dart';

class NewsCard extends StatelessWidget {
  double _width;
  double _height;
  News _news;

  NewsCard(this._width, this._height, this._news);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
        color: color8,

        elevation: 0,
        onPressed: (){
          // _showMyDialog(context);
          _showModalBottomSheet(context);
        },
        child: Container(
          width: _width,
          child: Row(
            children: [

              Container(
                width: _width*0.3,
                height: _height*0.7,
                padding: EdgeInsets.all(_width*0.03),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_width*0.01),
                      image: DecorationImage(
                          image: NetworkImage(_news.newsImages),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: _width*0.7,
                      height: _height*0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SizedBox(
                          width: _width*0.6,
                          child:
                          AutoSizeText(_news.title,textAlign: TextAlign.start,style: TextStyle(color: color5,fontSize: 50,fontWeight: FontWeight.w400),maxLines: 3,minFontSize: 1,maxFontSize: 18),
                        )
                        ],
                      )
                  ),
                  SizedBox(
                      width: _width*0.6,
                      height: _height*0.1,
                      child:
                            AutoSizeText(Formatter.formatDate(_news.dateNews),style: TextStyle(color: color5.withOpacity(0.5),fontSize: 50),maxLines: 1,minFontSize: 1,maxFontSize: 12)

                  ),
                ],
              ),
            ],
          )
        ),
      );
  }
   _showModalBottomSheet(context){
    var size=MediaQuery.of(context).size;
    showModalBottomSheet(context: context,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(size.width*0.05),topLeft: Radius.circular(size.width*0.05))),
        isScrollControlled: true,
        builder: (BuildContext context){
          return CardBottomSheet(size.width, size.height, _news, color3,color8);
        }
    );
   }
}
