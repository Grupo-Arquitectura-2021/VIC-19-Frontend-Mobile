import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/PaletteColor.dart';

class DataLabel extends StatelessWidget {
  double _width;
  double _height;
  String _label;
  int _data;
  Color _color;
  DataLabel(this._width, this._height,this._label,this._data,this._color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(Icons.show_chart_outlined,size: _width*0.1,color: _color,),
              SizedBox(width: _width*0.05,),
              Container(
                width: _width*0.5,
                height: _height,
                alignment: Alignment.centerLeft,
                child:
                    AutoSizeText(_label,textAlign: TextAlign.left,style: TextStyle(color: _color,fontSize: 14),maxLines: 1,minFontSize: 1,)
              ),
            ],
          ),
          SizedBox(
              width: _width*0.35,
              height: _height,
            child:
              Center(
                child: AutoSizeText(_data==null? "-":_data.toString(),textAlign: TextAlign.right,style: TextStyle(color: color5,fontSize: 20,fontWeight: FontWeight.w300),maxLines: 1,minFontSize: 1,)
                ,
              )
             )
        ],
      ),
    );
  }
}
