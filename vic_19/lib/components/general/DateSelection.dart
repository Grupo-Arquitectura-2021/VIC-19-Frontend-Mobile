import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../PaletteColor.dart';

class DateSeleccion extends StatefulWidget {
  DateTime _selectedDate;
  DateSeleccion(this._selectedDate);
  @override
  _DateSeleccionState createState() => _DateSeleccionState(this._selectedDate);
}

class _DateSeleccionState extends State<DateSeleccion> {
  DateTime _selectedDate;
  _DateSeleccionState(this._selectedDate);
  DateTime _date=DateTime.now();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        // setState(() {
          _selecDate(context);
        // });
      },
      child: Container(
          height: size.height*0.04,
          width: size.width*0.5,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color6),
              color: color6.withOpacity(0.4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("   ${_selectedDate.day}/",style: TextStyle(color: color5,fontSize: size.height*0.025),),
              Text("${_selectedDate.month}/",style: TextStyle(color: color5,fontSize: size.height*0.025),),
              Text("${_selectedDate.year}",style: TextStyle(color: color5,fontSize: size.height*0.025),),
              Icon(Icons.arrow_drop_down,color: color5,),
            ],
          ),
        ),
    );
  }

  Future<Null> _selecDate(BuildContext context) async {
    _selectedDate=await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2019), lastDate: DateTime(2222));
    if(_selectedDate!=null && _selectedDate!=_date){
      setState(() {
        _date=_selectedDate;
      });
    }
  }
}
