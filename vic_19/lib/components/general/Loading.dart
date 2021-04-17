import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vic_19/PaletteColor.dart';
class Loading extends StatelessWidget {
  Size size;
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Container(
      color: color7.withOpacity(0.6),
      child: Center(
        child: SpinKitFadingCube(
          color: color5,
          size: size.width*0.07,
        ),
      ),
    );
  }
}
