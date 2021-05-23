import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/bloc/bloc/GraphicsBloc.dart';
import 'package:vic_19/bloc/states/GraphicsState.dart';
import 'package:vic_19/components/general/Loading.dart';
import 'package:vic_19/components/graphics/BarChartView.dart';
import 'package:vic_19/components/graphics/ChangeGraphicButton.dart';
import 'package:vic_19/components/graphics/DataLabel.dart';
import 'package:vic_19/components/graphics/DateSelection.dart';
import 'package:vic_19/components/graphics/DownloadButton.dart';
import 'package:vic_19/components/graphics/LinearChart.dart';
import 'package:vic_19/components/graphics/PieChart.dart';
import '../PaletteColor.dart';
import '../components/graphics/LineTitles.dart';

class GraphicsPage extends StatelessWidget {
  final List<Color>gradientColors=[color2,color3,color4];

  DateTime _selectedDate;
  LocationData _dataLocation;
  double _width;
  double _height;
  List<bool> _activeData=[false,false,false,false];
  GraphicsPage(this._width,this._height);
  int _maxP;
  int _intP;
  List<String> _titlesX=[];
  List<List<FlSpot>> _dataGraphics=[];
  int _activeChart=0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphicsBloc,GraphicsState>(
        builder: (context, state) {
          if(state is GetDataGraphicsOkState){
            _dataLocation=state.props[0];
            _selectedDate=_dataLocation.dateLocationCovid;
            _activeData=state.props[1];
            _dataGraphics=state.props[2];
            _maxP=state.props[3];
            _intP=state.props[4];
            _titlesX=state.props[5];
            print(_dataGraphics.length);
            print("verenmos");
          }
          if(state is ChangeActiveDataGraphicState){
            print("llega graphic");
            _activeData=state.props[0];
            _dataGraphics=state.props[1];
            _maxP=state.props[2];
            _intP=state.props[3];
            _titlesX=state.props[4];
            print(_dataGraphics.length);
            print("verenmos");
          }
          if(state is ChangeActiveChartState){
            _activeChart=state.props[0];
          }
          if(state is LoadingGraphicsState){
            return Container(

                decoration: BoxDecoration(
                color: color8,
            ),
          width:    _width,
          height: _height,
          child:Loading("Cargando Gráficas", 0.8,1));
          }
          else{
            return Container(

                decoration: BoxDecoration(
                  color: color8,
                ),
                width:    _width,
                height: _height,
                child: Column(
                  children: [
                    SizedBox(
                      height:
                      MediaQuery.of(context).padding.top,
                    ),
                    SizedBox(height: _height*0.14,),
                    Container(
                      width: _width,
                      height: _height*0.475,
                      child: PageView(
                        children: [
                          Container(
                              width: _width,
                              height: _height*0.475,
                              child: Column(
                                children: [
                                  Container(
                                      width: _width,
                                      height: _height*0.04,
                                      padding: EdgeInsets.only(right: _width*0.02,left: _width*0.02,top: _height*0.01),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          DateSeleccion(_selectedDate, color5,color5.withOpacity(0.5),_width*0.4,_height*0.03,true),
                                          SizedBox(width: _width*0.1,),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: _width,
                                      height: _height*0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ChangeGraphicButton(color5, color5.withOpacity(0.5), Icons.show_chart, _width*0.3, _height*0.04,0,_activeChart==0?true:false),
                                          ChangeGraphicButton(color5, color5.withOpacity(0.5), Icons.insert_chart, _width*0.3, _height*0.04,1,_activeChart==1?true:false),
                                          ChangeGraphicButton(color5, color5.withOpacity(0.5), Icons.pie_chart, _width*0.3, _height*0.04,2,_activeChart==2?true:false),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: _width,
                                      height: _height*0.03,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child:
                                            AutoSizeText("Grafica General",style:TextStyle(color: color5.withOpacity(0.9),fontSize: 20,fontWeight: FontWeight.w300)),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,


                                            child: IconButton(
                                              onPressed: (){
                                                showMenu(context: context, position: RelativeRect.fromLTRB(_width*0.5, _height*0.3, _width*0.1, _height*0.5), items: [
                                                  PopupMenuItem(

                                                    child: DownloadButton(Color(0xff1d6f42), "Excel",Icons.table_chart,_width*0.2,30),
                                                    height: 30,),
                                                  PopupMenuItem(

                                                    child: DownloadButton(Color(0xffF40F02), "PDF",Icons.picture_as_pdf,_width*0.2,30),
                                                    height: 30,),
                                                  PopupMenuItem(

                                                    child: DownloadButton(Colors.indigo, "Graficos",Icons.pie_chart,_width*0.2,30),
                                                    height: 30,)
                                                ],color: color5.withOpacity(0.9),);
                                              },
                                              icon: Row(
                                                children: [Container(
                                                  width: _height*0.005,
                                                  height: _height*0.005,
                                                  margin: EdgeInsets.symmetric(horizontal: _height*0.0015),
                                                  decoration: BoxDecoration(
                                                    color: color5,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),Container(
                                                  width: _height*0.005,
                                                  height: _height*0.005,
                                                  margin: EdgeInsets.symmetric(horizontal: _height*0.0015),
                                                  decoration: BoxDecoration(
                                                    color: color5,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),Container(
                                                  width: _height*0.005,
                                                  height: _height*0.005,
                                                  margin: EdgeInsets.symmetric(horizontal: _height*0.0015),
                                                  decoration: BoxDecoration(
                                                    color: color5,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  IndexedStack(
                                      index: _activeChart,
                                      children: [LinearChart(_maxP,_intP, _titlesX, _width,_height*0.325, _dataGraphics),
                                      PieChartView( _width, _height*0.325, _dataLocation, _activeData),
                                        BarChartView( _width, _height*0.325, _dataLocation, _activeData)],

                                  ),

                                ],
                              )
                          ),Container(
                              width: _width,
                              height: _height*0.475,
                              child: Column(
                                children: [
                                  Container(
                                      width: _width,
                                      height: _height*0.12,
                                      color: color8,
                                      padding: EdgeInsets.only(right: _width*0.02,left: _width*0.02,bottom: _height*0.03),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ChangeGraphicButton(color5, Colors.green.withOpacity(0.7), Icons.chevron_left, _width*0.1, _height*0.04,0,false),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: _width,
                                      height: _height*0.03,
                                      alignment: Alignment.bottomCenter,
                                      child: AutoSizeText("Grafica de Prediccion",style:TextStyle(color: color5,fontSize: 20,fontWeight: FontWeight.w300))
                                  ),
                                  Container(
                                    width: _width,
                                    height: _height*0.325,
                                    decoration: BoxDecoration(
                                      color: color8,
                                    ),
                                    padding: EdgeInsets.only(right: _width*0.05,left: _width*0.01,bottom: _height*0.04),

                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: _height*0.22,
                        width: _width,
                        decoration: BoxDecoration(
                          color: color8,
                        ),
                        padding: EdgeInsets.only(top: _height*0),
                        alignment: Alignment.topCenter,
                        child:
                        Container(
                            height: _height*0.29,
                            width: _width,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: _width*0.6,
                                    height: _height*0.35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),

                                    ),
                                    child:Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          DataLabel(_width*0.55, _height*0.04, "Confirmados",_dataLocation!=null?_dataLocation.confirmed:0,color2,active: _activeData[0],changeIndex: 0,),
                                          DataLabel(_width*0.55, _height*0.04, "Recuperados", _dataLocation!=null?_dataLocation.recovered:0,Colors.lightGreen,active: _activeData[1],changeIndex: 1,),
                                          DataLabel(_width*0.55, _height*0.04, "Fallecidos",_dataLocation!=null?_dataLocation.deceased:0,color4,active: _activeData[2],changeIndex: 2,),
                                          DataLabel(_width*0.55, _height*0.04, "Vacunados", _dataLocation!=null?_dataLocation.vaccinated:0,Colors.cyan,active: _activeData[3],changeIndex: 3,),
                                          DataLabel(_width*0.55, _height*0.04, "Acumulado",_dataLocation!=null?_dataLocation.total:0,color3,active: true,),
                                        ]
                                    )
                                ),
                              ],
                            )
                        )
                    )
                  ],
                )
            );
          }
        }
    );
  }
}
