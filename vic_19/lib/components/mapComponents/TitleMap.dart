import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/states/MapState.dart';
import 'package:vic_19/util/MyBehavior.dart';
class TitleMap extends StatefulWidget {
  double _width;
  double _height;
  Color _backColor;
  Color _color;
  TitleMap(this._width, this._height,this._backColor,this._color);
  @override
  _TitleMapState createState() => _TitleMapState(this._width, this._height,_backColor,_color);
}

class _TitleMapState extends State<TitleMap>  with SingleTickerProviderStateMixin {
  double _width;
  double _height;
  List<Location> _locHistory=List();
  Location _loc;
  Color _backColor;
  Color _color;
  AnimationController controller;
  _TitleMapState(this._width, this._height,this._backColor,this._color);

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


  getTitleWidgets(){
    List<Widget> list=List();
    list.addAll([

      SizedBox(
          height: _height*0.25,
          width: _width,
          child: AutoSizeText.rich(

            TextSpan(

              children: [
                TextSpan(text:_loc!=null?"${_loc.getTitle()}: ":"",style: TextStyle(color: color8,fontSize: 50,fontWeight: FontWeight.w500))
                ,
                TextSpan(text:_loc!=null?"${_loc.locationName}":"",style: TextStyle(color: color8,fontSize: 50))
              ],

            ),
            maxLines: 1,maxFontSize: 50,minFontSize: 1,
            textAlign: TextAlign.start,
          )
      ),]);
    for(var location in _locHistory){
      list.add(
          SizedBox(
              height: _height*0.20,
              width: _width,
              child: AutoSizeText.rich(
                TextSpan(

                  children: [
                    TextSpan(text:"${location.getTitle()}: ",style: TextStyle(color: _color,fontSize: 50,fontWeight: FontWeight.w500))
                    ,
                    TextSpan(text:location.locationName,style: TextStyle(color: _color,fontSize: 50))
                  ],

                ),
                maxLines: 1,maxFontSize: 50,minFontSize: 1,
                textAlign: TextAlign.start,
              )
          )
      );
    }
    list.add(
      SizedBox(
        height: _height*0.20,
        width: _width,
        child: AutoSizeText.rich(
          TextSpan(
              children: [
                TextSpan(text:_loc!=null?"lat: ":"",style: TextStyle(fontWeight: FontWeight.w500),),
                TextSpan(text:_loc!=null?"${_loc.latitude}":"",style: TextStyle(),),
                TextSpan(text:_loc!=null?" lon:":"",style: TextStyle(fontWeight: FontWeight.w500),),
                TextSpan(text:_loc!=null?"${_loc.longitude}":"",style: TextStyle(),)
              ]
          ),
          maxLines: 1,maxFontSize: 50,minFontSize: 1,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 50,color: _color.withOpacity(0.7)),),),);
    return list;
  }
  Animation<double> offsetAnimation;
  @override
  Widget build(BuildContext context) {
    offsetAnimation=
    Tween(begin: -0.30, end: 0.30).chain(CurveTween(curve: Curves.easeInOutExpo)).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
    return BlocBuilder<MapBloc,MapState>(
        builder:(context,state){
          if(state is MapSelectLocationState){
            Location loc=state.props[0];
            if(loc!=null){
              _loc=loc;
            }
            else _loc=null;
            _locHistory=state.props[1];
            moveCard();
          }
          if(state is MaploadMarkersOkState){
            var loc=state.props[4];
            _loc=null;
           _locHistory=loc;
          }
          return AnimatedBuilder(

              animation: offsetAnimation,
            builder: (context,child){
              return RotationTransition(

                turns: new AlwaysStoppedAnimation( offsetAnimation.status.index==0?0:offsetAnimation.value/360),
                child: Container(

                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                        color: _backColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(_height*0.1)
                    ),
                    child: Center(
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: _height*0.1,horizontal: _width*0.05),
                          children: getTitleWidgets(),
                        ),
                      ),
                    )
                ),
              );
            },
          );
        }
    );
  }
}
