import 'package:flutter/material.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/components/tables/TableBottomSheet.dart';
import 'package:vic_19/util/MyBehavior.dart';

import '../../PaletteColor.dart';

class BasicTableWidget extends StatelessWidget {
  List<LocationData> _data;
  double _width;
  double _height;

  BasicTableWidget(this._data, this._width, this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                  dataRowColor:  MaterialStateColor.resolveWith((states) => color8.withOpacity(0.3)),
                  headingRowColor: MaterialStateColor.resolveWith((states) => color8.withOpacity(0.6)),
                  //tile card expansion
                  columns: [
                    DataColumn(label: Text("Departamentos",style: TextStyle(color: color3,fontSize: 15),)),
                    DataColumn(label: Text("Confirmados",style: TextStyle(color: color3,fontSize: 15),)),
                    DataColumn(label: Text("Recuperados",style: TextStyle(color: color3,fontSize: 15),)),
                    DataColumn(label: Text("Fallecidos",style: TextStyle(color: color3,fontSize: 15),)),
                    // DataColumn(label: Text("Fallecidos"),numeric:true,),
                  ],
                  rows:
                  _data.map((data){
                    return DataRow(
                        // selected: false,
                        // onSelectChanged: (value){
                        //   _showModalBottomSheet(context);
                        // },

                        cells:[
                          DataCell(GestureDetector(onTap: (){
                            _showModalBottomSheet(context);},
                              child: Text(data.name,style: TextStyle(color: color5,fontSize: 12),))),
                          DataCell(Text(data.confirmed.toString(),style: TextStyle(color: color5,fontSize: 12),)),
                          DataCell(Text(data.recovered.toString(),style: TextStyle(color: color5,fontSize: 12),)),
                          DataCell(Text(data.deceased.toString(),style: TextStyle(color: color5,fontSize: 12),)),
                        ]
                    );
                  }).toList()
              ),
            ),
        )
      ),
    );
  }

  _showModalBottomSheet(context){
    var size=MediaQuery.of(context).size;
    showModalBottomSheet(context: context,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(size.width*0.05),topLeft: Radius.circular(size.width*0.05))),
        isScrollControlled: true,
        builder: (BuildContext context){
          return TableBottomSheet(20,1,"17-04-21",size.height*0.8, _data, color3,color1);
        }
    );
  }
}
