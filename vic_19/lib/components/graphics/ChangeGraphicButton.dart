import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/bloc/bloc/GraphicsBloc.dart';
import 'package:vic_19/bloc/events/GraphicsEvent.dart';

import '../../PaletteColor.dart';
class ChangeGraphicButton extends StatelessWidget {
  Color _color;
  Color _backColor;
 double _width;
 double _height;
 IconData _icon;
 int _index;
 bool active;


  ChangeGraphicButton(this._color, this._backColor,this._icon, this._width, this._height,this._index,this.active);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: _height,
      minWidth: _width,
      color: active?_backColor:_backColor.withOpacity(0.05),
      onPressed: (){
        BlocProvider.of<GraphicsBloc>(context).add(ChangeActiveChartEvent(_index));
      },
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child:
          Icon(_icon, color: _color,),
    );
  }
}
