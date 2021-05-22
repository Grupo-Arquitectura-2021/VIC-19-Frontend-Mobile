import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/PaletteColor.dart';

class DataLabel extends StatelessWidget {
  double _width;
  double _height;
  String _label;
  int _data;
  Color _color;
  bool active;
  DataLabel(this._width, this._height,this._label,this._data,this._color,{this.active}){
    active=active==null?false:active;
    _color=active?_color:_color.withOpacity(0.3);
  }

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
              Row(
                children: [
                  Container(
                    width: _height*0.1,
                    height: _height*0.1,
                    decoration: BoxDecoration(
                      color: _color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: _width*0.05,
                    height: _height*0.04,
                    color: _color,
                  ),
                  Container(
                    width: _height*0.1,
                    height: _height*0.1,
                    decoration: BoxDecoration(
                      color: _color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              SizedBox(width: _width*0.03,),
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
                child: AutoSizeText(_data==null? "-":_data.toString(),textAlign: TextAlign.right,style: TextStyle(color: active?color5:color5.withOpacity(0.3),fontSize: 20,fontWeight: FontWeight.w300),maxLines: 1,minFontSize: 1,)
                ,
              )
             )
        ],
      ),
    );
  }
}
