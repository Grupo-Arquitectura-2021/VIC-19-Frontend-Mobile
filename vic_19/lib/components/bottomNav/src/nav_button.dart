import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;

  NavButton({this.onTap, this.position, this.length, this.index, this.child});

  var desiredPosition;
  var difference;
  var verticalAlignment;
  var opacity;
  @override
  Widget build(BuildContext context) {
    desiredPosition = 1.0 / length * index;
    difference = (position - desiredPosition).abs();
    verticalAlignment = 1 - length * difference;
    opacity = length * difference;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: Container(
            height: 75.0,
            child: Transform.translate(
              offset: Offset(
                  0, difference < 1.0 / length ? verticalAlignment * 40 : 0),
              child: Opacity(
                  opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
                  child: child),
            )),
      ),
    );
  }
}
