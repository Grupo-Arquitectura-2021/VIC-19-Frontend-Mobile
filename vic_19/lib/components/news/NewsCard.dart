import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/components/news/NewsSingleAlert.dart';

class NewsCard extends StatelessWidget {
  double _width;
  double _height;
  News _news;

  NewsCard(this._width, this._height, this._news);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
        color: color1,

        elevation: 0,
        onPressed: (){
          _showMyDialog(context);
        },
        child: Container(
          width: _width,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: _width*0.6,
                      height: _height*0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          AutoSizeText(_news.title,style: TextStyle(color: color5,fontSize: 50),maxLines: 3,minFontSize: 10,maxFontSize: 18)
                        ],
                      )
                  ),
                  SizedBox(
                      width: _width*0.6,
                      height: _height*0.1,
                      child:
                            AutoSizeText("${_news.dateTime.day}-${_news.dateTime.month}-${_news.dateTime.year} ${_news.dateTime.hour}:${_news.dateTime.minute}",style: TextStyle(color: color3,fontSize: 50),maxLines: 1,minFontSize: 1,maxFontSize: 14)

                  ),
                ],
              ),

              Container(
                width: _width*0.4,
                height: _height,
                padding: EdgeInsets.all(_width*0.03),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_width*0.01),
                      image: DecorationImage(
                          image: NetworkImage(_news.urlImage),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
            ],
          )
        ),
      );
  }
  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return NewsSingleAlert(_width, _height*2,color3, _news);
      },
    );
  }
}
