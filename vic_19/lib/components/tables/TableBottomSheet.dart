import 'package:flutter/material.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/components/tables/TableCard.dart';
import 'package:vic_19/util/MyBehavior.dart';

import '../../PaletteColor.dart';
class TableBottomSheet extends StatelessWidget {
  double _radius;
  int _departmentId;
  String _date;
  double _height;
  List<LocationData> _locationData;
  Color _color;
  Color _background;

  TableBottomSheet(this._radius, this._departmentId,this._date,this._height, this._locationData, this._color,
      this._background);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: EdgeInsets.all(_height*0.04),
      decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
          )
      ),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          itemCount: _locationData.length,
          itemBuilder: (context, index){
            return TableCard(_locationData[index],color1,color3,color5,400,_height);
          },

          // children: [
          //   SizedBox(height: 10,),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Text("Municipio:", style: TextStyle(color: _color,
          //           fontSize: _height * 0.05,
          //           fontWeight: FontWeight.w500),),
          //       Text(_locationData[index].name, style: TextStyle(color: color2,
          //           fontSize: _height * 0.05,
          //           fontWeight: FontWeight.w500),),
          //     ],
          //   ),
          //
          //   SizedBox(height: 10,),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Text("Confirmados:",
          //         style: TextStyle(color: color5, fontSize: _height * 0.045),),
          //       Text("Confirmados: ${_locationData.confirmed.toString()}",
          //         style: TextStyle(color: color5, fontSize: _height * 0.045),),
          //     ],
          //   ),
          //
          //
          //   SizedBox(height: 10,),
          //   Text("Recuperados: ${_locationData.recovered.toString()}",
          //     style: TextStyle(color: _color, fontSize: _height * 0.045),),
          //   SizedBox(height: 10,),
          //   Text("Fallecidos ${_locationData.deceased.toString()}",
          //     style: TextStyle(color: _color, fontSize: _height * 0.045),),
          // ],
        ),
      ),
    );
  }
}
