import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/components/graphics/ChangeGraphicButton.dart';
import 'package:vic_19/components/graphics/DataLabel.dart';
import 'package:vic_19/components/graphics/DateSelection.dart';
import 'package:vic_19/components/graphics/DownloadButton.dart';

import '../../PaletteColor.dart';
import 'LineTitles.dart';
class ChartWidget extends StatelessWidget {
  final List<String> _data;
  final DateTime _selectedDate;
  final LocationData _dataLocation;
  // final int x;
  // final int y;
  ChartWidget(this._selectedDate,this._data,this._width, this._height,this._dataLocation);
  final List<Color>gradientColors=[color2,color3,color4];
  final List<Color>lineOne=[color2];
  final List<Color>lineTwo=[Colors.lightGreen];
  final List<Color>lineThree=[color4];
  List<String> _titles=['1\nENE','4\nFEB','6\nABR','19\nJUN','30\nJUL','10\nSEP','15\nOCT','1\nNOV','24\nDIC'];//must be of 5 elements
  List<String> _titlesY=['0k','10k','20k','30k','40k','50k','60k','200k'];//must be of 7 elements
  double _width;
  double _height;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        color: color8,
        borderRadius: BorderRadius.circular(_width*0.03)
      ),
      width: _width,
      height: _height,
      child: Column(
        children: [
          Container(
              width: _width,
              height: _height*0.05,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: color5.withOpacity(0.1),width: 0.5))
              ),
              child: AutoSizeText("Grafica General",style:TextStyle(color: color5,fontSize: 20,fontWeight: FontWeight.w300))
          ),
          Container(
            width: _width,
            height: _height*0.1,
            color: color8,
            padding: EdgeInsets.only(right: _width*0.02,left: _width*0.02,bottom: _height*0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DateSeleccion(_selectedDate, color5,color5.withOpacity(0.1),_width*0.4,_height*0.04),
                SizedBox(width: _width*0.1,),
                ChangeGraphicButton(color5, color5.withOpacity(0.1), Icons.show_chart, _width*0.1, _height*0.04),
                ChangeGraphicButton(color5, color5.withOpacity(0.1), Icons.insert_chart, _width*0.1, _height*0.04),
                ChangeGraphicButton(color5, color5.withOpacity(0.1), Icons.pie_chart, _width*0.1, _height*0.04),
                ChangeGraphicButton(color5, Colors.green.withOpacity(0.7), Icons.access_time, _width*0.1, _height*0.04),
              ],
            )
          ),
          Container(
            width: _width,
            height: _height*0.35,
            child: PageView(
              children: [
                Container(
                  width: _width,
                  height: _height*0.35,
                  decoration: BoxDecoration(
                    color: color8,
                  ),
                  padding: EdgeInsets.only(right: _width*0.05,left: _width*0.01,bottom: _height*0.04),

                  child: LineChart(

                    LineChartData(
                      minX: 0,maxX: 10,

                      minY: 0,maxY: 6,
                      titlesData: LineTitles.getTitleData(_titles,_titlesY,_width*0.02),
                      gridData: FlGridData(
                          show: true,

                          getDrawingHorizontalLine: (value){
                            return FlLine(
                                color: color5.withOpacity(0.05),
                                strokeWidth: 0.5
                            );
                          },
                          // drawVerticalLine: false,
                          drawVerticalLine:true,
                          getDrawingVerticalLine: (value){
                            return FlLine(
                              color: color5.withOpacity(0.05),
                              strokeWidth: 0.5,
                            );
                          }
                      ),
                      borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: color5.withOpacity(0.1),width: 0.5)
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 1),
                            FlSpot(10, 2),
                            // FlSpot(10, 5),
                            // FlSpot(14, 7),
                          ],
                          isCurved: true,
                          colors: lineOne,
                          barWidth: 2,
                          // colors: gradientColors,
                          // belowBarData: BarAreaData(
                          //   show: true,
                          //   colors: lineOne.map((color) => color.withOpacity(0.3)).toList(),
                          // )
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 5),
                            FlSpot(10, 0),
                            // FlSpot(12, 4),
                            // FlSpot(16, 3),
                          ],
                          isCurved: true,
                          colors: lineTwo,
                          barWidth: 2,
                          // belowBarData: BarAreaData(
                          //   show: true,
                          //   colors: lineTwo.map((color) => color.withOpacity(0.3)).toList(),
                          // )
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 0),
                            FlSpot(4.3,4.3),
                            FlSpot(10, 6),
                            // FlSpot(10, 2),
                            // FlSpot(14, 4),
                            // FlSpot(14.4, 5.2),
                            // FlSpot(16, 5),
                          ],
                          isCurved: true,
                          colors: lineThree,
                          barWidth: 2,
                          // belowBarData: BarAreaData(
                          //   show: true,
                          //   colors: lineThree.map((color) => color.withOpacity(0.3)).toList(),
                          // )
                        ),
                      ],
                    ),

                  ),
                ),
                Container(
                  width: _width,
                  height: _height*0.35,
                  decoration: BoxDecoration(
                    color: color8,
                  ),
                  padding: EdgeInsets.only(right: _width*0.05,left: _width*0.01,bottom: _height*0.04),

                  child: LineChart(

                    LineChartData(
                      minX: 0,maxX: 10,

                      minY: 0,maxY: 6,
                      titlesData: LineTitles.getTitleData(_titles,_titlesY,_width*0.02),
                      gridData: FlGridData(
                          show: true,

                          getDrawingHorizontalLine: (value){
                            return FlLine(
                                color: color5.withOpacity(0.05),
                                strokeWidth: 0.5
                            );
                          },
                          // drawVerticalLine: false,
                          drawVerticalLine:true,
                          getDrawingVerticalLine: (value){
                            return FlLine(
                              color: color5.withOpacity(0.05),
                              strokeWidth: 0.5,
                            );
                          }
                      ),
                      borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: color5.withOpacity(0.1),width: 0.5)
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 1),
                            FlSpot(10, 2),
                            // FlSpot(10, 5),
                            // FlSpot(14, 7),
                          ],
                          isCurved: true,
                          colors: lineOne,
                          barWidth: 2,
                          // colors: gradientColors,
                          // belowBarData: BarAreaData(
                          //   show: true,
                          //   colors: lineOne.map((color) => color.withOpacity(0.3)).toList(),
                          // )
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 5),
                            FlSpot(10, 0),
                            // FlSpot(12, 4),
                            // FlSpot(16, 3),
                          ],
                          isCurved: true,
                          colors: lineTwo,
                          barWidth: 2,
                          // belowBarData: BarAreaData(
                          //   show: true,
                          //   colors: lineTwo.map((color) => color.withOpacity(0.3)).toList(),
                          // )
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 0),
                            FlSpot(4.3,4.3),
                            FlSpot(10, 6),
                            // FlSpot(10, 2),
                            // FlSpot(14, 4),
                            // FlSpot(14.4, 5.2),
                            // FlSpot(16, 5),
                          ],
                          isCurved: true,
                          colors: lineThree,
                          barWidth: 2,
                          // belowBarData: BarAreaData(
                          //   show: true,
                          //   colors: lineThree.map((color) => color.withOpacity(0.3)).toList(),
                          // )
                        ),
                      ],
                    ),

                  ),
                ),
              ],

            ),
          ),
          Material(
            elevation: 10,
            child: Container(
              height: _height*0.5,
              width: _width,
              decoration: BoxDecoration(
                color: color8,
              ),
              alignment: Alignment.topCenter,
              child:
                Container(
                  height: _height*0.39,
                  width: _width,
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: _width*0.5,
                          height: _height*0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_width*0.03),
                              color: color5.withOpacity(0.05),
                          ),
                          child:Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DataLabel(_width*0.45, _height*0.05, "Confirmados",_dataLocation!=null?_dataLocation.confirmed:0,color2),
                                DataLabel(_width*0.45, _height*0.05, "Recuperados", _dataLocation!=null?_dataLocation.recovered:0,Colors.lightGreen),
                                DataLabel(_width*0.45, _height*0.05, "Fallecidos",_dataLocation!=null?_dataLocation.deceased:0,color4),
                                DataLabel(_width*0.45, _height*0.05, "Total",_dataLocation!=null?_dataLocation.total:0,color3),
                                DataLabel(_width*0.45, _height*0.05, "Vacunados", _dataLocation!=null?_dataLocation.vaccinated:0,Colors.cyan),
                              ]
                        )
                        ),
                        Container(
                            width: _width*0.4,
                            height: _height*0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(_width*0.03),
                              color: color5.withOpacity(0.05),
                            ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: _width*0.35,
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: color5.withOpacity(0.1),width: 0.5))
                                ),
                                padding: EdgeInsets.all(_width*0.01),
                                child: AutoSizeText(
                                  "Descargar Datos",
                                  maxLines: 1,
                                  style: TextStyle(color: color5),
                                ),
                              ),
                              GestureDetector(
                                  onTap: (){
                                  },
                                  child: DownloadButton(Colors.lightGreen, "EXCEL",Icons.table_chart,_width*0.3,_height*0.04)
                              ),
                              GestureDetector(
                                  onTap: (){
                                  },
                                  child: DownloadButton(Colors.red, "PDF",Icons.picture_as_pdf,_width*0.3,_height*0.04)
                              ),
                              Container(
                                width: _width*0.35,
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: color5.withOpacity(0.1),width: 0.5))
                                ),
                                padding: EdgeInsets.all(_width*0.01),
                                child: AutoSizeText(
                                  "Descargar Gráficas",
                                  maxLines: 1,
                                  style: TextStyle(color: color5),
                                ),
                              ),
                              GestureDetector(
                                  onTap: (){
                                  },
                                  child: DownloadButton(Colors.pinkAccent, "",Icons.insert_chart,_width*0.3,_height*0.04)
                              ),
                            ],
                          ),
                        )
                    ],
                    )
                )
            ),
          )
        ],
      )
    );
  }
}
