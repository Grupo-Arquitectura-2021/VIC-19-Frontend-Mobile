
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

import '../PaletteColor.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _mapStyle;
  GoogleMapController mapController;
  List paises=[["Bolivia",-17.4364322,-64.9581047],
                ["Brasil",-11.6570027,-60.4375673],
                ["Peru",-14.134636, -70.929510],
                ["Chile",-23.664653, -69.362242],
                ["Paraguay",-22.9604184,-59.6220523],
                ["Argentina",-28.5972821,-63.175]];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-16.2256651,-65.0455838),
    zoom: 4.5,
  );
  Set<Marker> markers=Set();
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  Future<BitmapDescriptor> createCustomMarkerBitmap(String title,color,icon) async {
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
    textPainter.paint(canvas, Offset(title.length*4.5, 0));
    tp.layout();
    tp.paint(canvas, Offset(0.0, 50));
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage((tp.width+5).truncate(),100);
    final bytes = await image.toByteData(format: ImageByteFormat.png);

    return
      BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }
  addMarkers()async{
    for(var pais in paises){
      final marker=await createCustomMarkerBitmap(pais[0], color4,Icons.gps_fixed);
      markers.add(Marker(markerId: MarkerId(pais[0]),position:LatLng(pais[1],pais[2]),icon: marker,consumeTapEvents: false,flat: false,draggable: false,onTap: (){

      }));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      scrollGesturesEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,

      initialCameraPosition: _kGooglePlex,
      markers: markers,
      trafficEnabled: false,
      buildingsEnabled: false ,
      compassEnabled: false,
      indoorViewEnabled: false,
      liteModeEnabled: false,
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,


      onMapCreated: (GoogleMapController controller){
        mapController=controller;
        print(_mapStyle);
           mapController.setMapStyle(_mapStyle);
        addMarkers();
        });
  }
}


