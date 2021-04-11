import 'package:flutter/material.dart';
import 'package:vic_19/Pages/BottomMenu.dart';
import 'PaletteColor.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vic-19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: color1, primaryColor: Colors.black
      ),
      home: BottomMenu(),
    );
  }
}

