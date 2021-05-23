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
      height: _height,
      width: _width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Icon(_icon, color: _color,size: _width*0.2,),
          SizedBox(
            width: _width*0.7,
            child:
          AutoSizeText("${_text}",style: TextStyle(color: _color),maxLines: 1,),)
      ],
      ),
    );
  }
}
