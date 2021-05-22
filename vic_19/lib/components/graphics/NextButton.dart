import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../PaletteColor.dart';
class NextButton extends StatelessWidget {
  Color _color;
  String _text;
  double _width;
  double _height;
  IconData _icon;


  NextButton(this._color, this._text,this._icon, this._width, this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: _height,
      width: _width,
      padding: EdgeInsets.all(_width*0.05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        color: _color.withOpacity(0.1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          AutoSizeText("${_text}",style: TextStyle(color: color5),),
          Icon(_icon, color: color5,size: _height*0.6,),
        ]
      ),
    );
  }
}
