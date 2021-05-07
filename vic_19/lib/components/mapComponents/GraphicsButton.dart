import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';

class GraphicsButton extends StatelessWidget {
  double _width;
  double _height;
 bool _activo;
  GraphicsButton(this._width, this._height,this._activo);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height*1.6,
      child: Stack(
        children: [
          Column(
            children: [MaterialButton(
                minWidth: _width,
                height: _height,
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_height*0.2),
                    side: BorderSide(color: color3.withOpacity(0),width: 1)
                ),
                color: color3.withOpacity(0.7),
                child:  Center(
                  child:
                  Icon(
                    Icons.bar_chart,
                    color: color1,
                    size: _width*0.8,
                  ),
                ),


                onPressed: (){
                  if(_activo){

                    BlocProvider.of<MapBloc>(context).add(MapGraphicsEvent(DateTime.now()));
                  }
                }
            ),],
          ),
          Positioned(
            bottom:0,
            left: _width*0.25,
            child: Icon(Icons.keyboard_arrow_down,color: color3,size:_width*0.6),
          )
        ],
      ),
    );
  }
}
