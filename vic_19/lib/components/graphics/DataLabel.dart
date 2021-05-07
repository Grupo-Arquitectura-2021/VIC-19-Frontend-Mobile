import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/PaletteColor.dart';

class DataLabel extends StatelessWidget {
  double _width;
  double _height;
  String _label;
  int _data;
  Color _color;
  double _widthP;
  double _heightP;
  DataLabel(this._width, this._height,this._label,this._data,this._color){
    _widthP=_width*0.8;
    _heightP=_height-_width*0.2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(

        color: color8.withOpacity(0.3),
        borderRadius: BorderRadius.circular(_width*0.05)
      ),
      padding: EdgeInsets.all(_width*0.1),
      child: Column(
        children: [
          SizedBox(
            width: _widthP,
            height: _heightP*0.32,
            child:
            AutoSizeText(_label,textAlign: TextAlign.center,style: TextStyle(color: _color,fontSize: 50),maxLines: 1,minFontSize: 1,),
          ),
          SizedBox(
            height: _heightP*0.1,

          ),
          SizedBox(
              width: _widthP,
              height: _heightP*0.58,
            child:
            AutoSizeText(_data==null? "-":_data.toString(),textAlign: TextAlign.center,style: TextStyle(height: 1,color: color5,fontSize: 50,fontWeight: FontWeight.w200),maxLines: 1,minFontSize: 1,)
          )
        ],
      ),
    );
  }
}
