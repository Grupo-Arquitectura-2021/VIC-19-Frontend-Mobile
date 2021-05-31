import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/LocationDataStatistics.dart';
import 'package:vic_19/bloc/bloc/GraphicsBloc.dart';
import 'package:vic_19/bloc/events/GraphicsEvent.dart';
import 'package:vic_19/bloc/states/GraphicsState.dart';
import 'package:vic_19/components/general/Loading.dart';
import 'package:vic_19/components/graphics/BarChartView.dart';
import 'package:vic_19/components/graphics/ChangeGraphicButton.dart';
import 'package:vic_19/components/graphics/DataLabel.dart';
import 'package:vic_19/components/graphics/DataLabelStatistics.dart';
import 'package:vic_19/components/graphics/DateSelection.dart';
import 'package:vic_19/components/graphics/DateSelectionPredict.dart';
import 'package:vic_19/components/graphics/DownloadButton.dart';
import 'package:vic_19/components/graphics/LinearChart.dart';
import 'package:vic_19/components/graphics/PieChart.dart';
import '../PaletteColor.dart';

class GraphicsPage extends StatelessWidget {
  final activePage;
  final List<Color>gradientColors=[color2,color3,color4];
  DateTime _selectedDate;
  LocationData _dataLocation;
  double _width;
  double _height;
  List<bool> _activeData=[false,false,false,false,false];
  List<String> _titleChart=["Gráfica General","Gráfica de Torta","Gráfica de Barras",""];
  GraphicsPage(this._width,this._height,this.activePage){
    _pageController=new PageController(initialPage: 0);
    _chartPages=getCharts();
  }
  int _intX=0;
  int _intY=0;
  int _minY=0;
  List<String> _titlesX=[];
  List<List<FlSpot>> _dataGraphics=[];
  int _activeChart=0;
  List<Widget> _chartPages=List();
  List<GlobalKey> _keyCharts = [GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey()];
  int _pageGraphic=0;
  PageController _pageController;
  LocationDataStatistics _locationDataStatistics;

  getCharts(){
    return [
      RepaintBoundary(key: _keyCharts[0],child: LinearChart(_intX,_intY,_minY, _titlesX, _width,_height*0.325, _dataGraphics)),
      RepaintBoundary(key: _keyCharts[1],child: PieChartView( _width, _height*0.325, _dataLocation, _activeData)),
      RepaintBoundary(key: _keyCharts[2],child: BarChartView( _width, _height*0.325, _dataLocation, _activeData)),
      Container(width: _width, height:_height*0.325,alignment:Alignment.center,child: Text("Sin gráficos",style: TextStyle(color: color5.withOpacity(0.7)),),)];
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphicsBloc,GraphicsState>(
        builder: (context, state) {
          if(state is GetDataGraphicsOkState){
            print("llega Aqui");
            _dataLocation=state.props[0];
            _selectedDate=_dataLocation.dateLocationCovid;
            _activeData=state.props[1];
            _dataGraphics=state.props[2];
            _intX=state.props[3];
            _intY=state.props[4];
            _minY=state.props[5];
            _titlesX=state.props[6];
            _locationDataStatistics=state.props[7];
            _chartPages=getCharts();
          }
          if(state is ChangeActiveDataGraphicState){
            print("llega graphic");
            _activeData=state.props[0];
            _dataGraphics=state.props[1];
            _intX=state.props[2];
            _intY=state.props[3];
            _minY=state.props[4];
            _titlesX=state.props[5];
            _chartPages=getCharts();
          }
          if(state is ChangeActiveChartState){
            _activeChart=state.props[0];
          }
          if(state is ChangeActiveGraphicState){
            _pageGraphic=state.props[0];
          }
          if(state is GetPredictDataOkState){
            _locationDataStatistics=state.props[0];
          }
          if(state is LoadingGraphicsState||!activePage){
            return Container(
                decoration: BoxDecoration(
                color: color8,
            ),
            width:    _width,
            height: _height,
            child:Loading("Cargando Gráficas", 0.3,1));
            }
          if(state is LoadingGraphicsState||!activePage){
            return Container(
                decoration: BoxDecoration(
                  color: color8,
                ),
                width:    _width,
                height: _height,
                child:Loading("Cargando Gráficas", 0.3,1));
          }
          else{
            return Container(
              width:    _width,
              height: _height,
              color: color8,
              child: Column(
                children: [
                  SizedBox(
                    width: _width,
                    height: _height*0.14,
                  ),
                  Container(
                    width: _width,
                    height: _height*0.06,
                    child: Row(
                      children: [
                        MaterialButton(
                          minWidth: _width*0.5,
                          height: _height*0.06,
                          padding: EdgeInsets.all(0),
                          elevation: 0,
                          shape: Border(
                            bottom: BorderSide(color:_pageGraphic==0?color5:Colors.transparent)
                          ),
                          onPressed: (){
                            _pageController.jumpToPage(0);
                            BlocProvider.of<GraphicsBloc>(context).add(ChangeActiveGraphicEvent(0));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.show_chart,color: color5,),
                              Text("   General",style: TextStyle(color: color5),)
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: _width*0.5,
                          height: _height*0.06,
                          shape: Border(
                              bottom: BorderSide(color: _pageGraphic==1?color5:Colors.transparent)
                          ),
                          onPressed: (){
                            _pageController.jumpToPage(1);
                            BlocProvider.of<GraphicsBloc>(context).add(ChangeActiveGraphicEvent(1));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.multiline_chart,color: color5,),
                              Text("   Estadistica",style: TextStyle(color: color5),)
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  SizedBox(
                    width:    _width,
                    height: _height*0.775,
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                    Container(

                    decoration: BoxDecoration(
                    color: color8,
                    ),
                      child: Column(
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        DateSeleccion(_selectedDate, color5,color5.withOpacity(0.5),_width*0.4,_height*0.03,true),
                                      ],
                                    )
                                ),
                                Container(
                                    width: _width,
                                    height: _height*0.08,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ChangeGraphicButton(color5, color5.withOpacity(0.3), Icons.show_chart, _width*0.3, _height*0.04,0,_activeChart==0?true:false),
                                        ChangeGraphicButton(color5, color5.withOpacity(0.3), Icons.pie_chart, _width*0.3, _height*0.04,1,_activeChart==1?true:false),
                                        ChangeGraphicButton(color5, color5.withOpacity(0.3), Icons.insert_chart, _width*0.3, _height*0.04,2,_activeChart==2?true:false),
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
                                          AutoSizeText(_titleChart[_activeChart],style:TextStyle(color: color5.withOpacity(0.9),fontSize: 20,fontWeight: FontWeight.w300)),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: _width*0.01),


                                          child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: (){
                                                showMenu(
                                                  context: context,
                                                  position: RelativeRect.fromLTRB(_width*0.5, _height*0.38, _width*0.05, _height*0.5),

                                                  items: [
                                                    PopupMenuItem(
                                                      child: GestureDetector(onTap:(){
                                                        BlocProvider.of<GraphicsBloc>(context).add(DownloadExcelEvent());
                                                        Navigator.pop(context);
                                                      },child: DownloadButton(Color(0xff1d6f42), "Excel",Icons.table_chart,_width*0.2,30)),
                                                      height: 30,),
                                                    PopupMenuItem(

                                                      child: GestureDetector(
                                                          onTap:(){
                                                            BlocProvider.of<GraphicsBloc>(context).add(DownloadChartsEvent(_keyCharts[_activeChart].currentContext.findRenderObject()));
                                                            Navigator.pop(context);
                                                            },
                                                          child:DownloadButton(Colors.indigo, "Graficos",Icons.pie_chart,_width*0.2,30)
                                                      ),

                                                      height: 30,)
                                                  ],color: color5.withOpacity(0.9),
                                                );
                                              },
                                              icon:Icon(Icons.file_download,color: color5,size: _height*0.025,)
                                          ),
                                        )
                                      ],
                                    )
                                ),
                                IndexedStack(
                                    index: _activeChart,
                                    children: _chartPages

                                ),

                              ],
                            ),
                          ),
                          Container(
                              height: _height*0.2,
                              width: _width,
                              decoration: BoxDecoration(
                                color: color8,
                              ),
                              padding: EdgeInsets.only(top: _height*0),
                              alignment: Alignment.topCenter,
                              child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          width: _width*0.6,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),

                                          ),
                                          child:Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                DataLabel(_width*0.55, _height*0.032, "Confirmados",_dataLocation!=null?_dataLocation.confirmed:0,color2,active: _activeData[0],changeIndex: 0,),
                                                DataLabel(_width*0.55, _height*0.032, "Recuperados", _dataLocation!=null?_dataLocation.recovered:0,Colors.lightGreen,active: _activeData[1],changeIndex: 1,),
                                                DataLabel(_width*0.55, _height*0.032, "Fallecidos",_dataLocation!=null?_dataLocation.deceased:0,color4,active: _activeData[2],changeIndex: 2,),
                                                DataLabel(_width*0.55, _height*0.032, "Vacunados", _dataLocation!=null?_dataLocation.vaccinated:0,Colors.cyan,active: _activeData[3],changeIndex: 3,),
                                                DataLabel(_width*0.55, _height*0.032, "Acumulado",_dataLocation!=null?_dataLocation.total:0,color3,active: true,),
                                              ]
                                          )
                                      ),
                                    ],
                                  )
                          )
                        ],
                      )
                    ),
                        Container(

                            decoration: BoxDecoration(
                              color: color8,
                            ),
                            width:    _width,
                            height: _height*0.775,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: _height*0.03  ,
                                ),

                                Container(
                                  width: _width,
                                  height: _height*0.375,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: _height*0.01,
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
                                                AutoSizeText("Gráfica de predicción",style:TextStyle(color: color5.withOpacity(0.9),fontSize: 20,fontWeight: FontWeight.w300)),
                                              ),
                                              Container(
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.only(right: _width*0.01),


                                                child: IconButton(
                                                    padding: EdgeInsets.all(0),
                                                    onPressed: (){
                                                      showMenu(
                                                        context: context,
                                                        position: RelativeRect.fromLTRB(_width*0.5, _height*0.27, _width*0.05, _height*0.5),

                                                        items: [
                                                          PopupMenuItem(

                                                            child: GestureDetector(
                                                                onTap:(){
                                                                  BlocProvider.of<GraphicsBloc>(context).add(DownloadChartsEvent(_keyCharts[3].currentContext.findRenderObject()));
                                                                  Navigator.pop(context);
                                                                  },
                                                                child:DownloadButton(Colors.indigo, "Graficos",Icons.pie_chart,_width*0.2,30)
                                                            ),

                                                            height: 30,)
                                                        ],color: color5.withOpacity(0.9),
                                                      );
                                                    },
                                                    icon:Icon(Icons.file_download,color: color5,size: _height*0.025,)
                                                ),
                                              )
                                            ],
                                          )
                                      ),

                                      RepaintBoundary(key: _keyCharts[3],child: LinearChart(_locationDataStatistics.intX,_locationDataStatistics.intY,_locationDataStatistics.minX,_locationDataStatistics.labelX, _width,_height*0.325, _locationDataStatistics.dataPoints)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: _height*0.01,
                                ),
                                Container(
                                  height: _height*0.2,
                                  width: _width,
                                  child: PageView(
                                    children: [
                                      Container(
                                          height: _height*0.2,
                                          width: _width,
                                          decoration: BoxDecoration(
                                            color: color8,
                                          ),
                                          padding: EdgeInsets.only(top: _height*0),
                                          alignment: Alignment.topCenter,
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  width: _width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),

                                                  ),
                                                  child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "","Media","Varianza","Confianza",color5,active: false,),
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "Confirmados",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.confirmedStatistics.media}":"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.confirmedStatistics.variance}":"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.confirmedStatistics.confidenceInterval}":"-",
                                                          color2,active: _activeData[0],changeIndex: 0,),
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "Recuperados",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.recoveredStatistics.media}":"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.recoveredStatistics.variance}":"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.recoveredStatistics.confidenceInterval}":"-",
                                                          Colors.lightGreen,active: _activeData[1],changeIndex: 1,),
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "Fallecidos",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.deathStatistics.media}":"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.deathStatistics.variance}":"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.deathStatistics.confidenceInterval}":"-",
                                                          color4,active: _activeData[2],changeIndex: 2,),
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "Vacunados",
                                                            _locationDataStatistics!=null?"${_locationDataStatistics.vaccinatedStatistics.media}":"-",
                                                            _locationDataStatistics!=null?"${_locationDataStatistics.vaccinatedStatistics.variance}":"-",
                                                            _locationDataStatistics!=null?"${_locationDataStatistics.vaccinatedStatistics.confidenceInterval}":"-",
                                                            Colors.cyan,active: _activeData[3]),
                                                      ]
                                                  )
                                              ),
                                            ],
                                          )
                                      ),
                                      Container(
                                          height: _height*0.2,
                                          width: _width,
                                          decoration: BoxDecoration(
                                            color: color8,
                                          ),
                                          padding: EdgeInsets.only(top: _height*0),
                                          alignment: Alignment.topCenter,
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  width: _width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),

                                                  ),
                                                  child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [

                                                        Container(
                                                            width: _width,
                                                            height: _height*0.04,
                                                            padding: EdgeInsets.only(right: _width*0.02,left: _width*0.02,top: _height*0.01),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                DateSeleccionPredict(_locationDataStatistics!=null?_locationDataStatistics.selectedDate:DateTime.now(), color5,color5.withOpacity(0.5),_width*0.4,_height*0.03,true),
                                                              ],
                                                            )
                                                        ),
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "","LS","PI","AI",color5,active: false,),
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "Confirmados",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.confirmedPredict.leastSquares}":"-",
                                                          /*_locationDataStatistics!=null?"${_locationDataStatistics.confirmedPredict.percentage}":*/"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.confirmedPredict.absolute}":"-",
                                                          color2,active: _activeData[0],changeIndex: 0,),
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "Recuperados",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.recoveredPredict.leastSquares}":"-",
                                                          /*_locationDataStatistics!=null?"${_locationDataStatistics.recoveredPredict.percentage}":*/"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.recoveredPredict.absolute}":"-",
                                                          Colors.lightGreen,active: _activeData[1],changeIndex: 1,),
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "Fallecidos",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.deathPredict.leastSquares}":"-",
                                                         /* _locationDataStatistics!=null?"${_locationDataStatistics.deathPredict.percentage}":*/"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.deathPredict.absolute}":"-",
                                                          color4,active: _activeData[2],changeIndex: 2,),
                                                        DataLabelStatistics(_width*0.9, _height*0.032, "Vacunados",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.vaccinatedPredict.leastSquares}":"-",
                                                          /*_locationDataStatistics!=null?"${_locationDataStatistics.vaccinatedPredict.percentage}":*/"-",
                                                          _locationDataStatistics!=null?"${_locationDataStatistics.vaccinatedPredict.absolute}":"-",
                                                          Colors.cyan,active: _activeData[3]),
                                                      ]
                                                  )
                                              ),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }
    );
  }

}
