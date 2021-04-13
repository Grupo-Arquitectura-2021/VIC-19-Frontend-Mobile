import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';

class FilterButton extends StatelessWidget {
  double _width;
  double _height;
  String _text;
  int _filter;
  Color _color;
  IconData _icon;
  bool _active;


  FilterButton(this._width, this._height, this._text, this._filter, this._color,
      this._icon,this._active);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: _width,
        height: _height,
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_height*0.5),
          side: BorderSide(color: _color,width: 1)
        ),
        color: color8,
        child:  Container(
          width: _width,
              decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(_height*0.5),
              color:_active?_color.withOpacity(0.5):color8,
            ),
              padding: EdgeInsets.symmetric(horizontal: _height,vertical: _height*0.5),
            child: Row(
              children: [
                Icon(
                  _icon,
                  color: color5,
                ),
                SizedBox(
                  width: 5,
                ),
                AutoSizeText(
                  _text,
                  style: TextStyle(
                      color: color5,
                  ),
                  maxLines: 1,
                  maxFontSize: 50,
                ),
              ],
            ),
          ),


        onPressed: (){
              BlocProvider.of<MapBLoc>(context).add(SelectFilterEvent(_filter,context));
        }
    );
  }
}

    