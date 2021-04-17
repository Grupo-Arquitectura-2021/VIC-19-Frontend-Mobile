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
  Location _loc;
  int _type=0;
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
  getTitleType(int layer,int type){
    String title="";
    switch(type){
      case 0:
        switch(layer){
          case 0:
            title="Pais";
            break;
          case 1:
            title="Departamento";
            break;
          case 2:
            title="Municipio";
            break;
        }
        break;
      case 1:
        title="Hospital";
        break;
      case 2:
        title="Farmacias";
        break;
      case 3:
        title="Albergues";
        break;
    }
    return title;
  }
  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation =
    Tween(begin: -0.30, end: 0.30).chain(CurveTween(curve: Curves.easeInOutExpo)).animate(controller)
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
              _loc=loc;
            }
            else _loc=null;
            loc=state.props[1];
            if(loc!=null){
              _subTitle=loc.name;
            }
            else _subTitle="";
            moveCard();
          }
          if(state is MaploadMarkersOkState){
            _type=state.props[2];
            Location loc=state.props[4];
            _loc=null;
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
                    padding: EdgeInsets.symmetric(vertical: _height*0.1,horizontal: _width*0.05),
                    decoration: BoxDecoration(
                        color: color5.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(_height*0.1)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox(
                          height: _height*0.3,
                          width: _width,
                          child: AutoSizeText.rich(

                            TextSpan(

                                children: [
                                  TextSpan(text:_loc!=null?"${getTitleType(_type, _loc.type)}: ":"",style: TextStyle(color: color8,fontSize: 50,fontWeight: FontWeight.w500))
                                  ,
                                  TextSpan(text:_loc!=null?"${_loc.name}":"",style: TextStyle(color: color8,fontSize: 50))
                            ],

                            ),
                            maxLines: 1,maxFontSize: 50,minFontSize: 1,
                            textAlign: TextAlign.start,
                          )
                        ),
                        _type!=0?SizedBox(
                            height: _height*0.20,
                            width: _width,
                            child: AutoSizeText.rich(
                              TextSpan(

                                children: [
                                  TextSpan(text:_loc!=null?"${getTitleType(_type-1,0)}: ":"",style: TextStyle(color: color4,fontSize: 50,fontWeight: FontWeight.w500))
                                  ,
                                  TextSpan(text:_loc!=null&&_subTitle!=""?_subTitle:"",style: TextStyle(color: color1,fontSize: 50))
                                ],

                              ),
                              maxLines: 1,maxFontSize: 50,minFontSize: 1,
                              textAlign: TextAlign.start,
                            )
                        ):Container(),
                          SizedBox(
                          height: _height*0.20,
                          width: _width,
                          child: AutoSizeText.rich(
                            TextSpan(
                              children: [
                                TextSpan(text:_loc!=null?"lat: ":"",style: TextStyle(fontWeight: FontWeight.w500),),
                                TextSpan(text:_loc!=null?"${_loc.lat}":"",style: TextStyle(),),
                                TextSpan(text:_loc!=null?" lon:":"",style: TextStyle(fontWeight: FontWeight.w500),),
                                TextSpan(text:_loc!=null?"${_loc.lon}":"",style: TextStyle(),)
                              ]
                            ),
                            maxLines: 1,maxFontSize: 50,minFontSize: 1,
                            textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 50,color: color1.withOpacity(0.7)),),)
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
