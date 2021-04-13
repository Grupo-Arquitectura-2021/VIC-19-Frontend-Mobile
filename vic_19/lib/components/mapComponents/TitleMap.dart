import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/Model/Country.dart';
import 'package:vic_19/PaletteColor.dart';
class TitleMap extends StatelessWidget {
  double _width;
  double _height;
  String _country;

  TitleMap(this._width, this._height, this._country);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: _width,
      height: _height,
      padding: EdgeInsets.symmetric(vertical: _height*0.18,horizontal: _width*0.2),
      decoration: BoxDecoration(
        color: color5.withOpacity(0.7),
        borderRadius: BorderRadius.circular(_height*0.2)
      ),
      child: Center(
        child: AutoSizeText(_country,style: TextStyle(color: color1,fontSize: 50),maxLines: 1,maxFontSize: 50,),
      )
    );
  }
}
