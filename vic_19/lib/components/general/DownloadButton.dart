import 'package:flutter/material.dart';

import '../../PaletteColor.dart';
class DownloadButton extends StatelessWidget {
  Color _color;
  String _text;
 double _width;
 double _height;


  DownloadButton(this._color, this._text, this._width, this._height);

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
        children: [
          Icon(Icons.download_rounded, color: color5,),
          Text("${_text}",style: TextStyle(color: color5),),
        ],
      ),
    );
  }
}
