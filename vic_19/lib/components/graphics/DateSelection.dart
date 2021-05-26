import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/bloc/bloc/GraphicsBloc.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/events/GraphicsEvent.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';

import '../../PaletteColor.dart';


class DateSeleccion extends StatelessWidget {
  DateTime _selectedDate;
  Color _backColor;
  Color _color;
  double _width;
  double _height;
  bool _outlined;
  DateSeleccion(this._selectedDate,this._color,this._backColor,this._width,this._height,this._outlined);
  Size size;
  @override
  Widget build(BuildContext context) {
     size = MediaQuery.of(context).size;
    return Container(
      width: _width,
      height: _height,
      child: MaterialButton(
        elevation: 0,
        color: !_outlined?_backColor:Colors.transparent,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: _outlined?_backColor:Colors.transparent)
        ),
        padding: EdgeInsets.all(0),
        onPressed: (){
            _selecDate(context);
        },
        child: _selectedDate==null?Container():Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: _height*0.55,
                width: _width*0.8,
                child:Center(
                  child: AutoSizeText("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",style: TextStyle(color: _color,fontSize: size.height*0.025),),
                )
              ),
              Icon(Icons.arrow_drop_down,color:_color,size: _width*0.1,),
            ],
          ),
        )
      ),
    );
  }

  _selecDate(BuildContext context) async {
    DateTime date;
    date=await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2019), lastDate: DateTime.now(),helpText: "Seleccione una fecha",fieldLabelText: "Fecha",fieldHintText: "Mes/Dia/Año",errorInvalidText: "",errorFormatText: "",
    builder: (BuildContext context, Widget child){
      return Theme(data: ThemeData.dark().copyWith(primaryColor: color5,accentColor: color5,textSelectionColor: color5,cursorColor: color5,backgroundColor: color1,colorScheme: ColorScheme.dark(primary: color5,background: color1,surface: color8,onBackground: color1,),), child: child);
    }
    );
    if(date!=null && date!=_selectedDate){
      BlocProvider.of<GraphicsBloc>(context).add((ChangeDateDataGraphicEvent(date)));
    }
  }
}
