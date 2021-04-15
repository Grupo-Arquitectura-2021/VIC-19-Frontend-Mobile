import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/util/BoliviaMap.dart';

class MapUtils{
  var point=List<LatLng>();
  var polygon=Set<Polygon>();

  final geo = GeoJson();
  static Future<BitmapDescriptor> createCustomMarkerBitmap1(String title,Color color,icon,double size) async {
    final iconData = icon;
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final iconStr = String.fromCharCode(iconData.codePoint);

    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: size*1.5,
          fontFamily: iconData.fontFamily,
          color: color,
        )
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(0, 0));
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage((size*1.5).truncate(), (size*1.5).truncate());
    final bytes = await image.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }
  static Future<BitmapDescriptor> createCustomMarkerBitmap2(String title,Color color,icon,double size) async {
    final iconData = icon;
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final iconStr = String.fromCharCode(iconData.codePoint);
    TextSpan span = new TextSpan(
      style: new TextStyle(
        color: color,
        fontSize: size,
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
        fontSize: size,
        color: color,
        letterSpacing: 1.0,
        fontFamily: 'Roboto Bold',
      ),
    );

    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: size*1.5,
          fontFamily: iconData.fontFamily,
          color: color,
        )
    );
    tp.layout();
    tp.paint(canvas, Offset(0.0, size*1.6));
    textPainter.layout();
    textPainter.paint(canvas, Offset(tp.width*0.5-size, 0));
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage((tp.width + 5).truncate(), (size*4).truncate());
    final bytes = await image.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }
  lattoother(List<GeoJsonMultiPolygon> a,nombre){
    int id=0;
    for(var l0 in a){
      if(nombre==l0.name){
        print("npm"+l0.name);
        print("npm2"+nombre);
        for( var l1 in l0.polygons){
          for(var l2 in l1.geoSeries){
            List<LatLng> latlongAux=List();
            for(var l3 in l2.toLatLng()){

              latlongAux.add(LatLng(l3.latitude, l3.longitude));
            }

            polygon.add(Polygon(
                fillColor: color5.withOpacity(0.1), visible: true,zIndex: 0,strokeColor: Colors.transparent, strokeWidth: 0,points: latlongAux,polygonId: PolygonId(id.toString())));
            id++;
            break;
          }
        }
      }
    }
    print("alvin");
    print(polygon);
  }
  Future<Set<Polygon>> geoAdd(nombre)async{
    final data = await rootBundle
        .loadString('assets/cities.geojson');
    await geo.parse(data, verbose: true, nameProperty: "NOMBRE");
    await lattoother(geo.multipolygons,nombre);
    return polygon;
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