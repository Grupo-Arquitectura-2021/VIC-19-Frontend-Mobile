import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/bloc/bloc/TablesBloc.dart';
import 'package:vic_19/bloc/states/TablesState.dart';
import 'package:vic_19/components/general/Loading.dart';
import 'package:vic_19/components/graphics/DateSelection.dart';
import 'package:vic_19/components/tables/BasicTable.dart';
import 'package:vic_19/components/tables/TableBottomSheet.dart';

import '../PaletteColor.dart';
class TablesPage extends StatefulWidget {
  @override
  _TablesPageState createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  List<LocationData> _dataList=List();
  List<LocationData> _municipalityList=List();
  DateTime _selectedDate=DateTime.now();
  DateTime _selectedDate2=DateTime.now();
  String _locationName;
  LocationData _locationData;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocBuilder<TablesBloc,TablesState>(
      builder: (context,state){
        print(state);
      if(state is TablesCitiesOkState){
        _dataList=state.props[0];
        _selectedDate=state.props[1];
      }
      else if(state is TablesMunicipalityOkState){
        _municipalityList=state.props[0];
        _selectedDate2=state.props[1];
        _locationName=state.props[2];
        _showModalBottomSheet(context, _locationName, "${_selectedDate2.year}-${_selectedDate2.month}-${_selectedDate2.day}",_municipalityList);
      }
      return Stack(
        children: [
                SingleChildScrollView(
                child: Container(
                alignment: Alignment.topCenter,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DateSeleccion(_selectedDate,color3,2),
                      Container(
                        alignment: Alignment.center,
                        width: size.width,
                        child: BasicTableWidget(_dataList,size.width*0.95,size.height*0.7),
                      ),
                      // LineChartWidget(_dataList),
                    ],
                  ),
                )
                ),
          state is TablesLoadingState?Loading(null,0.6,1):Container()
        ],
      );
    },
    )
    );
  }
}
_showModalBottomSheet(context,String cityName,String date,List<LocationData> dataList){
  var size=MediaQuery.of(context).size;
  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    showModalBottomSheet(context: context,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(size.width*0.05),topLeft: Radius.circular(size.width*0.05))),
        isScrollControlled: true,
        builder: (BuildContext context){
          return TableBottomSheet(20,cityName,date,size.height*0.8, dataList, color3,color1);
        }
    );
  });
}
