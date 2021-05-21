import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../PaletteColor.dart';
class DownloadButton extends StatelessWidget {
  Color _color;
  String _text;
 double _width;
 double _height;
 IconData _icon;


  DownloadButton(this._color, this._text,this._icon, this._width, this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: _height,
      width: _width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _color)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _text!=null&&_text!=""?[
          Icon(_icon, color: color5,size: _height*0.6,),
          AutoSizeText("${_text}",style: TextStyle(color: color5),),
        ]: [
        Icon(_icon, color: color5,size: _height*0.6,),
      ],
      ),
    );
  }
}
