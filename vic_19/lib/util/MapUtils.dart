import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils{
  static Future<BitmapDescriptor> createCustomMarkerBitmap(String title,Color color,icon) async {
    final iconData = icon;
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final iconStr = String.fromCharCode(iconData.codePoint);
    TextSpan span = new TextSpan(
      style: new TextStyle(
        color: color,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
      text: title,
    );

    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.text = TextSpan(
      text: title,
      style: TextStyle(
        fontSize: 35.0,
        color: color,
        letterSpacing: 1.0,
        fontFamily: 'Roboto Bold',
      ),
    );

    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: 48.0,
          fontFamily: iconData.fontFamily,
          color: color,
        )
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(title.length * 4.5, 0));
    tp.layout();
    tp.paint(canvas, Offset(0.0, 50));
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage((tp.width + 5).truncate(), 100);
    final bytes = await image.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }
}