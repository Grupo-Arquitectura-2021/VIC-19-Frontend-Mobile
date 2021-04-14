import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vic_19/util/BoliviaMap.dart';

class MapUtils{
  var point=List<LatLng>();
  var polygon=Set<Polyline>();

  final geo = GeoJson();
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
  lattoother(List<GeoJsonMultiPolygon> a){
    int id=0;
    for(var l0 in a){
      for( var l1 in l0.polygons){
        for(var l2 in l1.geoSeries){
          List<LatLng> latlongAux=List();
          for(var l3 in l2.toLatLng()){

            latlongAux.add(LatLng(l3.latitude, l3.longitude));
          }

          polygon.add(Polyline(
              width: 1, color: Colors.blue, points: latlongAux,polylineId: PolylineId(id.toString())));
          id++;
          break;
        }
      }
    }
    print("alvin");
    print(polygon);
  }
  void geoAdd()async{
    final data = await rootBundle
        .loadString('assets/cities.geojson');
    await geo.parse(data, verbose: true);
    lattoother(geo.multipolygons);
  }
  void addPoints()
  {
    for( var i=0 ; i < BoliviaMap.CHUQ.length ; i++ )
    {
      var ltlng= LatLng(
          double.parse(BoliviaMap.CHUQ[ i ][ 1 ].toStringAsFixed(5)), double.parse(BoliviaMap.CHUQ[ i ][ 0].toStringAsFixed(5)) );
      point.add( ltlng );
    }
    print(point);
  }

}