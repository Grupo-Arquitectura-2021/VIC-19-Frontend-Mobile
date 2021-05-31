import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/GraphicsBloc.dart';
import 'package:vic_19/bloc/events/GraphicsEvent.dart';

class DataLabelStatistics extends StatelessWidget {
  double _width;
  double _height;
  String _label;
  String _media;
  String _variance;
  String _intervalConfidence;
  Color _color;
  bool active;
  int changeIndex;
  DataLabelStatistics(this._width, this._height,this._label,this._media,this._variance,this._intervalConfidence,this._color,{this.changeIndex,this.active}){
    active=active==null?false:active;
    _color=active?_color:_color.withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(changeIndex!=null){
          BlocProvider.of<GraphicsBloc>(context).add(ChangeActiveDataGraphicEvent(changeIndex));
        }
      },
      child: Container(
        width: _width,
        height: _height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                Container(
                  width: _width*0.3,
                  height: _height,
                  alignment: Alignment.centerLeft,
                  child:
                      AutoSizeText(_label,textAlign: TextAlign.left,style: TextStyle(color: _color,fontSize: 14),maxLines: 1,minFontSize: 1,)
                ),
            Container(
                width: _width*0.15,
                height: _height,
              alignment: Alignment.center,
              child:AutoSizeText(_media==null||_media=="-1"? "-":_media,textAlign: TextAlign.right,style: TextStyle(color: active?color5:color5.withOpacity(0.3),fontSize: 20,fontWeight: FontWeight.w300),maxLines: 1,minFontSize: 1,maxFontSize:12,)

               ),
            Container(
                width: _width*0.15,
                height: _height,
                alignment: Alignment.center,
                child:AutoSizeText(_variance==null||_variance=="-1"? "-":_variance,textAlign: TextAlign.right,style: TextStyle(color: active?color5:color5.withOpacity(0.3),fontSize: 20,fontWeight: FontWeight.w300),maxLines: 1,minFontSize: 1,maxFontSize: 12)

            ),
            Container(
                width: _width*0.3,
                height: _height,
                alignment: Alignment.center,
                child:AutoSizeText(_intervalConfidence==null||_intervalConfidence=="-1"? "-":_intervalConfidence,textAlign: TextAlign.right,style: TextStyle(color: active?color5:color5.withOpacity(0.3),fontSize: 20,fontWeight: FontWeight.w300),maxLines: 1,minFontSize: 1,maxFontSize: 12)

            )
          ],
        ),
      ),
    );
  }
}
