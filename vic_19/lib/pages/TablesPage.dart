import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/bloc/bloc/TablesBloc.dart';
import 'package:vic_19/bloc/states/TablesState.dart';
import 'package:vic_19/components/general/Loading.dart';
import 'package:vic_19/components/graphics/DateSelection.dart';
import 'package:vic_19/components/tables/BasicTable.dart';

import '../PaletteColor.dart';
class TablesPage extends StatefulWidget {
  @override
  _TablesPageState createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  List<LocationData> _dataList=List();
  DateTime _selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<TablesBloc,TablesState>(
    builder: (context,state){
      if(state is TablesCitiesOkState){
        _dataList=state.props[0];
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
                      DateSeleccion(_selectedDate,color1,color3,size.width*0.5,size.height*0.05),
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
