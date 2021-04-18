import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../PaletteColor.dart';

class DateSeleccion extends StatefulWidget {
  DateTime _selectedDate;
  Color _color;
  DateSeleccion(this._selectedDate,this._color);
  @override
  _DateSeleccionState createState() => _DateSeleccionState(this._selectedDate,this._color);
}

class _DateSeleccionState extends State<DateSeleccion> {
  DateTime _selectedDate;
  Color _color;
  _DateSeleccionState(this._selectedDate,this._color);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal:size.width*0.25,),
      child: MaterialButton(
        height: size.height*0.04,
        color: _color.withOpacity(0.7),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(0),
        onPressed: (){
            _selecDate(context);
        },
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

  _selecDate(BuildContext context) async {
    DateTime date;
    date=await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2019), lastDate: DateTime(2222),helpText: "Seleccione una fecha",fieldLabelText: "Fecha",fieldHintText: "Mes/Dia/Año",errorInvalidText: "",errorFormatText: "",
    builder: (BuildContext context, Widget child){
      return Theme(data: ThemeData.dark().copyWith(primaryColor: _color.withOpacity(0.8),accentColor: _color.withOpacity(0.8),textSelectionColor: color5,cursorColor: _color,colorScheme: ColorScheme.dark(primary: _color,background: color1,surface: _color.withOpacity(0.7)),), child: child);
    }
    );
    if(date!=null && date!=_selectedDate){
      setState(() {
        _selectedDate=date;
      });
    }
  }
}
