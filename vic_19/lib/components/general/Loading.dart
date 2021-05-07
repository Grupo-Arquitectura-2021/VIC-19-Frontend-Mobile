import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vic_19/PaletteColor.dart';
class Loading extends StatelessWidget {
  Size size;
  double _opacity;
  String _title;
  int _type;
  Loading(this._title,this._opacity,this._type);
  _getTypeGraphic(){
    switch(_type){
      case 1:
        return SpinKitFadingCube(
          color: color5,
          size: size.width*0.07,
        );
      case 2:
        return SpinKitWave(
          color: color5,
          size: size.width*0.07,
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Container(
      color: color7.withOpacity(_opacity),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          _getTypeGraphic(),
          SizedBox(height: size.height*0.03,),
          _title==null?Container():SizedBox(
            width: size.width,
            child: Center(
              child: AutoSizeText(_title,style: TextStyle(color: color5.withOpacity(0.8)),maxLines: 1,maxFontSize: 14,minFontSize: 1,),
            ),
          )
        ]
      ),
    );
  }
}
