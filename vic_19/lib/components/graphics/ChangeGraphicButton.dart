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
    return MaterialButton(
      height: _height,
      minWidth: _width,
      color: _backColor,
      onPressed: (){

      },
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child:
          Icon(_icon, color: _color,),
    );
  }
}
