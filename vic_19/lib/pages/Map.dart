

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geojson/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';
import 'package:vic_19/bloc/states/MapState.dart';
import 'package:vic_19/components/graphics/DateSelection.dart';
import 'package:vic_19/components/graphics/DownloadButton.dart';
import 'package:vic_19/components/general/Loading.dart';
import 'package:vic_19/components/graphics/DataLabel.dart';
import 'package:vic_19/components/graphics/LinearChart.dart';
import 'package:vic_19/components/mapComponents/ExpandButton.dart';
import 'package:vic_19/components/mapComponents/FilterButton.dart';
import 'package:vic_19/components/mapComponents/GraphicsButton.dart';
import 'package:vic_19/components/mapComponents/TitleMap.dart';
import 'package:vic_19/util/MyBehavior.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _mapStyle;
  GoogleMapController mapController;
  Size size;
  Set <Marker> markers;
  int type=0;
  List<bool> filters=[true,false,false,false];
  ScrollController _scrollController;
  bool graphics=false;
  bool select=false;
  double zoom=5;
  LatLng center=LatLng(-16.2256651,-65.0455838);
  Set<Polygon> geo=Set();
  LocationData dataLocation;

  List<String> _data=['p','p1','p2','p3','p4','p5'];
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    _scrollController=ScrollController();
    super.initState();
  }

  masGrandepolygon(Set<Polygon>pol){
    Set<Polygon> polAux=Set();
    if(pol.length>0){
      var maxPol=pol.elementAt(0);
      for(int i=1;i<pol.length;i++){
        if(pol.elementAt(i).points.length>maxPol.points.length){
          maxPol=pol.elementAt(i);
        }
      }
      polAux.add(maxPol);
    }
    return polAux;
  }
  @override
  Widget build(BuildContext context) {
    size=Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
    return BlocBuilder<MapBloc,MapState>(
          builder: (context,state){
            print(state);
            if(state is MaploadMarkersOkState){
              select=false;

              markers=state.props[1];
              zoom=state.props[0];
              center=state.props[3];
              mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: state.props[3],
                zoom: state.props[0],
              )));
              type=state.props[2];
              if(type==2){
                geo=state.props[5];
              }
            }
            if(state is MapFilterOkState){
              markers=state.props[0];
              filters=state.props[1];
            }
            if(state is MapSelectLocationState){
              select=true;
            }
            if(state is MapLoadingGraphicsState){
              _scrollController.animateTo(_scrollController.position.maxScrollExtent,curve: Curves.decelerate,duration: Duration(milliseconds: 1000));
              graphics=true;
            }
            if(state is MapGraphicsOkState){
                dataLocation=state.props[0];



            }
            if(state is MapMainMapOkState){
              _scrollController.animateTo(_scrollController.position.minScrollExtent,curve: Curves.decelerate,duration: Duration(milliseconds: 1000));
              dataLocation=null;
              graphics=false;

            }
            return Container(
              child: Stack(
                children: [
                  ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      controller: _scrollController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: size.height,
                              width:size.width,
                              child:
                                     Stack(
                                       children: [GoogleMap(
                                           zoomControlsEnabled: false,
                                           initialCameraPosition: _kGooglePlex,
                                           markers: markers,
                                           polygons: masGrandepolygon(geo),
                                            scrollGesturesEnabled: true,
                                           buildingsEnabled: false,
                                           tiltGesturesEnabled: false,
                                           rotateGesturesEnabled: false
                                           ,
                                           myLocationEnabled: true,
                                           myLocationButtonEnabled: true,
                                           mapToolbarEnabled: false,
                                           liteModeEnabled: false,
                                           indoorViewEnabled: false,
                                           compassEnabled: false,
                                           trafficEnabled: false
                                           ,
                                           zoomGesturesEnabled: true,






                                           onMapCreated: (GoogleMapController controller){
                                             mapController=controller;
                                             mapController.setMapStyle(_mapStyle);
                                             BlocProvider.of<MapBloc>(context).add(GetCountriesEvent(context));
                                           }),mapController==null?Container(width: size.width,height: size.height,color:color1):Container()
                                       ,
                                         Positioned(
                                           top: MediaQuery.of(context).padding.top+size.height*0.02,
                                           child: SizedBox(
                                                   width: size.width,
                                                   height: size.height*0.05,
                                                   child: ScrollConfiguration(
                                                     behavior: MyBehavior(),
                                                     child: ListView(
                                                       padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                                                       scrollDirection: Axis.horizontal,
                                                       children: [
                                                         Container(
                                                           width: type==0||type==1?size.width-size.width*0.1:(size.width*0.35*4-size.width*0.05),
                                                           child:
                                                           Row(
                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                             children: type==0||type==1?[
                                                               FilterButton(size.width*0.3, 10,"Ubicación", 0, color4, Icons.location_on,filters[0],!graphics?true:false)]:[
                                                               FilterButton(size.width*0.3, 10,"Ubicación", 0, color4, Icons.location_on,filters[0],!graphics?true:false),
                                                               SizedBox(width: size.width*0.05,),

                                                               FilterButton(size.width*0.3, 10,"Hospitales", 1, color6, Icons.local_hospital,filters[1],!graphics?true:false),
                                                               SizedBox(width: size.width*0.05,),

                                                               FilterButton(size.width*0.3, 10,"Farmacias", 2, color3, Icons.local_pharmacy,filters[2],!graphics?true:false),
                                                               SizedBox(width: size.width*0.05,),

                                                               FilterButton(size.width*0.3, 10,"Albergues", 3, color2, Icons.local_hotel,filters[3],!graphics?true:false)],
                                                           ),
                                                         )
                                                       ],
                                                     ),
                                                   )
                                               )
                                         ),
                                         Positioned(
                                           right: size.width*0.03,
                                           bottom: size.height*0.085,
                                           child: AnimatedOpacity(
                                               opacity: select&&!graphics?1:0,

                                               duration: Duration(milliseconds: 300),
                                               child: GraphicsButton(size.height*0.05,size.height*0.05,select&&!graphics?true:false)),
                                         ),
                                         Positioned(
                                           left: size.width*0.03,
                                           bottom: size.height*0.115,
                                           child: AnimatedOpacity(
                                               opacity: select&&!graphics&&type!=2?1:0,
                                               duration: Duration(milliseconds: 300),
                                               child: ExpandButton(size.height*0.05,size.height*0.05,1,select&&!graphics&&type!=2?true:false)),
                                         ),
                                         Positioned(
                                           left: size.width*0.03,
                                           bottom: size.width*0.03+size.height*0.115+size.height*0.05,
                                           child: AnimatedOpacity(
                                               opacity: !graphics&&type!=0?1:0,
                                               duration: Duration(milliseconds: 300),
                                               child: ExpandButton(size.height*0.05,size.height*0.05,2,!graphics&&type!=0?true:false)),
                                         ),
                                       ],
                                     ),
                            ),
                          ],
                        ),
                        Container(
                          height: size.height,
                          width:size.width,

                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                color8,color1
                              ],
                              stops: [0,0],
                              begin: Alignment.topCenter, end:  Alignment.bottomCenter
                            )
                          ),
                          child: Column(
                            children: [
                              // SizedBox(height: size.height*0.16,),
                              SizedBox(height: MediaQuery.of(context).padding.top+size.height*0.15,),
                              DateSeleccion(dataLocation!=null?dataLocation.dateLocationCovid:DateTime.now(),color2),
                              SizedBox(height: size.height*0.02,),
                              LineChartWidget(_data,size.width*0.9,size.height*0.3),
                              SizedBox(height: size.height*0.02,),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      DataLabel(size.width*0.3, size.height*0.09, "CONFIRMADOS",dataLocation!=null?dataLocation.confirmed:0,color2),
                                      DataLabel(size.width*0.3, size.height*0.09, "RECUPERADOS", dataLocation!=null?dataLocation.recovered:0,color3),
                                      DataLabel(size.width*0.3, size.height*0.09, "FALLECIDOS",dataLocation!=null?dataLocation.deceased:0,color4)
                                    ],
                                  ),
                                  SizedBox(height: size.height*0.01,)
                                  ,Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DataLabel(size.width*0.3, size.height*0.09, "TOTAL",dataLocation!=null?dataLocation.total:0,color6),
                                    DataLabel(size.width*0.3, size.height*0.09, "VACUNADOS", dataLocation!=null?dataLocation.vaccinated:0,color5),
                                  ],
                                ),],
                              ),
                              SizedBox(height: size.height*0.01,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: size.width*0.05)
                                ,child: Divider(

                                color: color2.withOpacity(0.5),

                              ),),
                              SizedBox(height: size.height*0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  GestureDetector(
                                      onTap: (){

                                      },
                                      child: DownloadButton(Colors.lightGreen, "EXCEL",size.width*0.3,size.height*0.05)
                                  ),
                                  SizedBox(height: size.height*0.012,),
                                  GestureDetector(
                                      onTap: (){

                                      },
                                      child: DownloadButton(Colors.red, "PDF",size.width*0.3,size.height*0.05)
                                  ),
                                ],
                              )


                            ]
                        )
                        )
                      ],
                    ),
                  ),

                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1000),
                      top: MediaQuery.of(context).padding.top+(!graphics?size.height*0.1:size.height*0.035),
                      child: AnimatedOpacity(
                          opacity: select?1:0,

                          duration: Duration(milliseconds: 300),

                          child:Container(
                              width: size.width,
                              height: size.height*0.09,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TitleMap(size.width*0.8,size.height*0.09),
                                ],
                              )
                          )
                      )
                  ),


                ],
              ),
            );
          },
        );
  }
  static final CameraPosition _kGooglePlex = CameraPosition(

    target:LatLng(-16.2256651,-58.0455838),
    zoom: 2,
  );

}


