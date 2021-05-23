import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vic_19/Pages/Map.dart';
import 'package:vic_19/bloc/bloc/GraphicsBloc.dart';
import 'package:vic_19/bloc/bloc/MapBloc.dart';
import 'package:vic_19/bloc/bloc/NewsBloc.dart';
import 'package:vic_19/bloc/bloc/TablesBloc.dart';
import 'package:vic_19/bloc/events/NewsEvent.dart';
import 'package:vic_19/bloc/events/TablesEvent.dart';
import 'package:vic_19/bloc/repositories/GraphicsRepository.dart';
import 'package:vic_19/bloc/repositories/MapRepository.dart';
import 'package:vic_19/bloc/repositories/NewsRepository.dart';
import 'package:vic_19/bloc/repositories/TablesRepository.dart';
import 'package:vic_19/bloc/states/MapState.dart';
import 'package:vic_19/components/bottomNav/MapButtonAnimated.dart';
import 'package:vic_19/components/bottomNav/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vic_19/components/general/Loading.dart';
import 'package:vic_19/pages/NewsPage.dart';
import 'package:vic_19/pages/TablesPage.dart';

import '../PaletteColor.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  static List<Widget> pages;

  DateTime _datetable=DateTime.now();

  int _selectedIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pages=[TablesPage(),MapPage(),NewsPage()];
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MapBloc>(create: (context)=>MapBloc(MapRepository())),
          BlocProvider<GraphicsBloc>(create: (context)=>GraphicsBloc(GraphicsRepository())),
          BlocProvider<TablesBloc>(create: (context)=>TablesBloc(TablesRepository())..add(TablesGetCitiesEvent(_datetable))),
          BlocProvider<NewsBloc>(create: (context)=>NewsBloc(NewsRepository())..add(NewsGetEvent()))
        ],
    child: BlocBuilder<MapBloc,MapState>(
        builder: (context, state)
        {
          return Stack(
              children: [
                IndexedStack(
                index:_selectedIndex,
                children: pages
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height*0.075,
                width: size.width,
                child: CurvedNavigationBar(
                        index: _selectedIndex,
                        items: [Icon(
                          Icons.table_chart_rounded,
                          size: size.height*0.04,
                          color: state is MapGraphicsOkState?Colors.transparent:_selectedIndex==0?color1:color5,
                        ),
                          Icon(
                            Icons.public_rounded,
                            size: size.height*0.04,
                            color: state is MapGraphicsOkState&&_selectedIndex==1?Colors.transparent:_selectedIndex==1?color1:color5,
                          ),
                          Icon(
                            Icons.list_alt_rounded,
                            size: size.height*0.04,
                            color: state is MapGraphicsOkState?Colors.transparent:_selectedIndex==2?color1:color5,
                          ),
                        ],
                        onTap: (index){
                          if(index==_selectedIndex){
                            print("no");
                          }
                          else{
                            print("si");
                            setState(() {
                              _selectedIndex = index;
                            });
                          }

                        },

                        buttonBackgroundColor: color2.withOpacity(state is MapGraphicsOkState&&_selectedIndex==1?0:1),
                        lock:  state is MapGraphicsOkState?true:false,

                        backgroundColor: color8,
                        height: size.height*0.075,
                        color: color8,
                        animationDuration: const Duration(milliseconds: 300),
                      ),
              ),
            ),
            state is MapGraphicsOkState&&_selectedIndex==1?Positioned(
                  bottom: size.height*0.034,
                  left: size.width*0.5-size.height*0.03,
                  child: AnimatedOpacity(
                      opacity: state is MapGraphicsOkState&&_selectedIndex==1?1:0,
                      duration: Duration(milliseconds: 300),
                      child: MapButtonAnimated(size.height*0.06,size.height*0.01)),

                ):Container(),
              state is MapLoadingState || state is MapInitialState?Loading(null,0.6,1):Container()


      ],
        );}
    )
    )
    );
  }
}

