import 'package:flutter/material.dart';

import '../../PaletteColor.dart';

class BasicTableWidget extends StatefulWidget {

  @override
  _BasicTableWidgetState createState() => _BasicTableWidgetState();
}

class _BasicTableWidgetState extends State<BasicTableWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(

          columns: [
            DataColumn(label: Text("Departamentos",style: TextStyle(color: color3,fontSize: 15),)),
            DataColumn(label: Text("Confirmados",style: TextStyle(color: color3,fontSize: 15),)),
            DataColumn(label: Text("Recuperados",style: TextStyle(color: color3,fontSize: 15),)),
            DataColumn(label: Text("Fallecidos",style: TextStyle(color: color3,fontSize: 15),)),
            // DataColumn(label: Text("Fallecidos"),numeric:true,),
          ],
          rows: [
            DataRow(
              selected: true,
                cells:[
                  DataCell(Text("La Paz",style: TextStyle(color: color5,fontSize: 12),)),
                  DataCell(Text("283.084",style: TextStyle(color: color5,fontSize: 12),)),
                  DataCell(Text("232.422",style: TextStyle(color: color5,fontSize: 12),)),
                  DataCell(Text("12.469",style: TextStyle(color: color5,fontSize: 12),)),
                ]
            ),
            DataRow(
              selected: true,
                cells:[
                  DataCell(Text("Sucre",style: TextStyle(color: color5,fontSize: 12),)),
                  DataCell(Text("283.084",style: TextStyle(color: color5,fontSize: 12),)),
                  DataCell(Text("232.422",style: TextStyle(color: color5,fontSize: 12),)),
                  DataCell(Text("12.469",style: TextStyle(color: color5,fontSize: 12),)),
                ]
            ),
            DataRow(
                selected: true,
                cells:[
                  DataCell(Text("Tarija",style: TextStyle(color: color5,fontSize: 12),)),
                  DataCell(Text("283.084",style: TextStyle(color: color5,fontSize: 12),)),
                  DataCell(Text("232.422",style: TextStyle(color: color5,fontSize: 12),)),
                  DataCell(Text("12.469",style: TextStyle(color: color5,fontSize: 12),)),
                ]
            ),
          ],
      ),
    );
  }
}
