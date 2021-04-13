

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:vic_19/Model/Country.dart';
import 'package:vic_19/PaletteColor.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/events/MapEvent.dart';
import 'package:vic_19/bloc/repositories/MapRepository.dart';
import 'package:vic_19/bloc/states/MapState.dart';
import 'package:vic_19/components/general/Loading.dart';
import 'package:vic_19/components/mapComponents/ExpandButton.dart';
import 'package:vic_19/components/mapComponents/FilterButton.dart';
import 'package:vic_19/components/mapComponents/GraphicsButton.dart';
import 'package:vic_19/components/mapComponents/TitleMap.dart';
import 'package:vic_19/util/MapUtils.dart';
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
  int tipo=1;
  List<bool> filters=[true,false,false];
  ScrollController _scrollController=ScrollController();
  bool graphics=true;
  String title="";
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

  }
  @override
  Widget build(BuildContext context) {
    size=Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
    return BlocProvider(
        create:(context)=>MapBLoc(MapRepository()),
        child: BlocBuilder<MapBLoc,MapState>(
          builder: (context,state){
            if (state is MapInitialState){
            BlocProvider.of<MapBLoc>(context).add(GetCountriesEvent(context));
            }
            if(state is MaploadCountriesOkState){
              markers=state.props[1];
              mapController.animateCamera(CameraUpdate.zoomTo(state.props[0]));
              tipo=1;
            }
            if(state is MapFilterOkState){
              markers=state.props[0];
              filters=state.props[1];
            }
            if(state is MapSelectCountryState){
              Country country=state.props[0];
              title=country.name;
              graphics=false;
            }
            if(state is MapGraphicsOkState){
                _scrollController.animateTo(_scrollController.position.maxScrollExtent,curve: Curves.decelerate,duration: Duration(milliseconds: 1000));
                graphics=true;
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
                        SizedBox(
                          height: size.height,
                          width:size.width,
                          child:
                                  GoogleMap(
                                      scrollGesturesEnabled: false,
                                      zoomControlsEnabled: false,
                                      zoomGesturesEnabled: false,
                                      initialCameraPosition: _kGooglePlex,
                                      markers: markers,
                                      trafficEnabled: false,
                                      buildingsEnabled: false ,
                                      compassEnabled: false,
                                      indoorViewEnabled: false,
                                      liteModeEnabled: false,
                                      mapToolbarEnabled: false,
                                      myLocationButtonEnabled: false,
                                      myLocationEnabled: false,
                                      rotateGesturesEnabled: false,
                                      tiltGesturesEnabled: false,


                                      onMapCreated: (GoogleMapController controller){
                                        mapController=controller;
                                        mapController.setMapStyle(_mapStyle);
                                      }),
                        ),
                        SizedBox(
                          height: size.height,
                          width:size.width,

                        )
                      ],
                    ),
                  ),
                  !graphics?Positioned(
                      top: MediaQuery.of(context).padding.top+size.height*0.12,
                      child: SizedBox(
                        width: size.width,
                        height: size.height*0.05,
                        child: ScrollConfiguration(
                          behavior: ScrollBehavior(),
                          child: GlowingOverscrollIndicator(
                            color: color1,
                            axisDirection: AxisDirection.left,
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: tipo==1?size.width-size.width*0.1:(size.width*0.35*4-size.width*0.1),
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: tipo==1?[
                                      FilterButton(size.width*0.3, 10,"Ubicación", 0, color4, Icons.location_on,filters[0])]:[
                                      FilterButton(size.width*0.3, 10,"Ubicación", 0, color4, Icons.location_on,filters[0]),
                                      SizedBox(width: size.width*0.05,),

                                      FilterButton(50, 10,"Hospitales", 1, color6, Icons.local_hospital,filters[1]),
                                      SizedBox(width: size.width*0.05,),

                                      FilterButton(50, 10,"Farmacias", 2, color3, Icons.local_pharmacy,filters[2]),
                                      SizedBox(width: size.width*0.05,),

                                      FilterButton(50, 10,"Albergues", 3, color2, Icons.local_hotel,filters[3])],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      )
                  ):Container(),
                  Positioned(
                      top: 0,
                      child: Container(
                          width: size.width,
                          height: size.height*0.2,
                          child: Center(
                            child: TitleMap(size.width*0.6,size.height*0.05,title),
                          )
                      )
                  ),
                  !graphics?Positioned(
                    right: size.width*0.03,
                    bottom: size.height*0.09,
                    child: GraphicsButton(50,50),
                  ):Container(),
                  !graphics?Positioned(
                    left: size.width*0.03,
                    bottom: size.height*0.115,
                    child: ExpandButton(50,50),
                  ):Container(),
                  state is MapLoadingMarkersState?Loading():Container()
                ],
              ),
            );
          },
        ),
    );
  }
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-16.2256651,-65.0455838),
    zoom: 4.5,
  );

}


