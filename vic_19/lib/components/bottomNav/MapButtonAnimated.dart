import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';

class MapButtonAnimated extends StatefulWidget {
  double width;
  double height;

  MapButtonAnimated(this.width, this.height);

  @override
  _MapButtonAnimatedState createState() => _MapButtonAnimatedState(width,height);
}

class _MapButtonAnimatedState extends State<MapButtonAnimated> with SingleTickerProviderStateMixin  {
  AnimationController _controller;
  double _width;
  double _height;
  bool _active=true;

  _MapButtonAnimatedState(this._width, this._height);

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation =
    Tween(begin: -5.0, end: 5.0).chain(CurveTween(curve: Curves.easeInOutExpo)).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });

    return
        AnimatedBuilder(
        animation: offsetAnimation,
        builder: (buildContext, child) {
          return Column(
              children: [
                SizedBox(
                  child: Column(
                    children: [

                      Icon(Icons.keyboard_arrow_up,size: _width*0.3,color: color2,),
                    ],
                  ),
                ),
              RotationTransition(
              turns: new AlwaysStoppedAnimation( offsetAnimation.value/ 360),
              child:
              GestureDetector(
                onTap: (){
                  _controller.dispose();

                  BlocProvider.of<MapBLoc>(context).add(MapMainMapEvent());
                },
                child: Container(
                  width: _width,
                  height: _width,
                  decoration: BoxDecoration(
                      color:color2,
                      borderRadius: BorderRadius.circular(_width)
                  ),
                  child:Center(
                    child: Icon(Icons.public_rounded,size: _width*0.7,color: color1,),
                  ),
                ),
              )
              )
                ],
          );
        });

  }
}
