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
  final TextEditingController textController = TextEditingController();
  AnimationController controller;
  double width;
  double height;

  _MapButtonAnimatedState(this.width, this.height);

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    hilo();
    super.initState();
  }
  hilo()async{
    await Future.delayed(Duration(milliseconds: 200));

    controller.forward(from: 0.0);
    hilo();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation =
    Tween(begin: -5.0, end: 5.0).chain(CurveTween(curve: Curves.easeInOutExpo)).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
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

                      Icon(Icons.keyboard_arrow_up,size: width*0.3,color: color2,),
                    ],
                  ),
                ),
              RotationTransition(
              turns: new AlwaysStoppedAnimation( offsetAnimation.value/ 360),
              child:
              GestureDetector(
                onTap: (){
                  BlocProvider.of<MapBLoc>(context).add(MapMainMapEvent());
                },
                child: Container(
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                      color:color2,
                      borderRadius: BorderRadius.circular(width)
                  ),
                  child:Center(
                    child: Icon(Icons.public_rounded,size: width*0.7,color: color1,),
                  ),
                ),
              )
              )
                ],
          );
        });

  }
}
