import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';

class GraphicsButton extends StatelessWidget {
  double _width;
  double _height;

  GraphicsButton(this._width, this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MaterialButton(
          minWidth: _width,
          height: _height,
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_height*0.2),
              side: BorderSide(color: color3,width: 1)
          ),
          color: color8,
          child:  Center(
            child:
            Icon(
              Icons.bar_chart,
              color: color3,
              size: _width*0.8,
            ),
          ),


          onPressed: (){
            BlocProvider.of<MapBLoc>(context).add(MapGraphicsEvent());
          }
      ),
          Icon(Icons.keyboard_arrow_down,color: color3,),
        ],
      ),
    );
  }
}
