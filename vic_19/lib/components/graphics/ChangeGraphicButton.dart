import 'package:flutter/material.dart';

import '../../PaletteColor.dart';
class ChangeGraphicButton extends StatelessWidget {
  Color _color;
  Color _backColor;
 double _width;
 double _height;
 IconData _icon;


  ChangeGraphicButton(this._color, this._backColor,this._icon, this._width, this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: _backColor,
          borderRadius: BorderRadius.circular(10),
      ),
      child:
          Icon(_icon, color: color5,),
    );
  }
}
