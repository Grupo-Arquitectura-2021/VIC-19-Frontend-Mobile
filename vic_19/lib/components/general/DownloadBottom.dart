import 'package:flutter/material.dart';

import '../../PaletteColor.dart';
class DownloadBottom extends StatelessWidget {
  Color _color;
  String _text;

  DownloadBottom(this._color, this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _color)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.download_rounded, color: color5,),
          Text("${_text}",style: TextStyle(color: color5),),
        ],
      ),
    );
  }
}
