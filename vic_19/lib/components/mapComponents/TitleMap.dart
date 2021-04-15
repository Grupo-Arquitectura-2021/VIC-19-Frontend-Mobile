import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/states/MapState.dart';
class TitleMap extends StatefulWidget {
  double _width;
  double _height;
  TitleMap(this._width, this._height);
  @override
  _TitleMapState createState() => _TitleMapState(this._width, this._height);
}

class _TitleMapState extends State<TitleMap>  with SingleTickerProviderStateMixin {
  double _width;
  double _height;
  String _subTitle="";
  String _title="";
  AnimationController controller;
  _TitleMapState(this._width, this._height);

  @override
  void initState() {

    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
  }
  moveCard()async{
   for(int i=0;i<4;i++){
     await Future.delayed(Duration(milliseconds: 200));
     controller.forward(from: -5.0);
   }
  }
  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation =
    Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOutExpo)).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
    return BlocBuilder<MapBLoc,MapState>(
        builder:(context,state){
          if(state is MapSelectLocationState){
            Location loc=state.props[0];
            if(loc!=null){
              _title=loc.name;
            }
            else _title="-";
            loc=state.props[1];
            if(loc!=null){
              _subTitle=loc.name;
            }
            else _subTitle="";
            moveCard();
          }
          if(state is MaploadMarkersOkState){
            Location loc=state.props[4];
            _title="-";
            if(loc!=null){

              _subTitle=loc.name;
            }
            else _subTitle="";
          }
          return AnimatedBuilder(

              animation: offsetAnimation,
            builder: (context,child){
              return RotationTransition(

                turns: new AlwaysStoppedAnimation( offsetAnimation.status.index==0?0:offsetAnimation.value/360),
                child: Container(

                    width: _width,
                    height: _height,
                    padding: EdgeInsets.symmetric(vertical: _height*0.1,horizontal: _width*0.2),
                    decoration: BoxDecoration(
                        color: color5.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(_height*0.2)
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: _height*0.30,
                          child: AutoSizeText(_subTitle,style: TextStyle(color: color6,fontSize: 50),maxLines: 1,maxFontSize: 50,),
                        ),
                        SizedBox(
                          height: _height*0.50,
                          child: AutoSizeText(_title,style: TextStyle(color: color1,fontSize: 50),maxLines: 1,maxFontSize: 50,),)
                      ],
                    )
                ),
              );
            },
          );
        }
    );
  }
}
