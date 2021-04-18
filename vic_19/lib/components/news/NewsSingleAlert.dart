import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/util/MyBehavior.dart';

class NewsSingleAlert extends StatelessWidget {
  double _width;
  double _height;
  Color _color;
  News _news;

  NewsSingleAlert(this._width, this._height, this._color, this._news);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_width*0.05)
      ),
      titlePadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.only(top: 0),
      contentPadding: EdgeInsets.only(top: _height*0.05,left: _width*0.05,right: _width*0.05),
      title: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(_width*0.05),topLeft:  Radius.circular(_width*0.05)),
          image: DecorationImage(
            image: NetworkImage(_news.urlImage),
            fit: BoxFit.cover
          )
        ),
      ),
      backgroundColor: color8,
      content: Container(
        width: _width,
        height: _height*0.8,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              Text(_news.title,style: TextStyle(color: _color,fontSize: 20,fontWeight: FontWeight.w500),),
              Text(_news.content,style: TextStyle(color: color5),),
            ],
          ),
        )
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Aceptar',style: TextStyle(color: _color),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
