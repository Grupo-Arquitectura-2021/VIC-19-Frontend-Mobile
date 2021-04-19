import 'package:flutter/material.dart';
import 'package:vic_19/Model/LocationData.dart';

import '../../PaletteColor.dart';
class TableCard extends StatelessWidget {
  LocationData _locationData;
  Color _background;
  Color _color;
  Color _color2;
  double _width;
  double _height;
  TableCard(this._locationData,this._background,this._color,this._color2,this._width,this._height);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      // height: _height,
      color: _background,
      child: Card(
        color: _background,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExpansionTile(
                title: Text(_locationData.name,style: TextStyle(color: _color,fontSize: _height*0.029),),
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text("Confirmados:",style: TextStyle(color: _color,fontSize: _height*0.025),),
                    SizedBox(width: _width*0.01,),
                    Text(_locationData.confirmed.toString(),style: TextStyle(color: _color2,fontSize: _height*0.025),),
                  ],),
                  SizedBox(height: _height*0.007,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text("Recuperados:",style: TextStyle(color: _color,fontSize: _height*0.025),),
                    SizedBox(width: _width*0.01,),
                    Text(_locationData.recovered.toString(),style: TextStyle(color: _color2,fontSize: _height*0.025),),
                  ],),
                  SizedBox(height: _height*0.007,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text("Fallecidos:",style: TextStyle(color: _color,fontSize: _height*0.025),),
                    SizedBox(width: _width*0.01,),
                    Text(_locationData.deceased.toString(),style: TextStyle(color: _color2,fontSize: _height*0.025),),
                  ],),
                  SizedBox(height: _height*0.015,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
