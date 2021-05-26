import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/bloc/bloc/NewsBloc.dart';
import 'package:vic_19/bloc/events/NewsEvent.dart';
import 'package:vic_19/bloc/states/NewsState.dart';
import 'package:vic_19/components/general/Loading.dart';
import 'package:vic_19/components/news/NewsCard.dart';
import 'package:vic_19/components/news/NewsSingleAlert.dart';
import 'package:vic_19/util/MyBehavior.dart';

import '../PaletteColor.dart';
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Size size;
  List<News> _news= List();
  ScrollController scrollController=ScrollController();
  bool loading=true;
  int page=0;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() async{
      if(
      scrollController.position.maxScrollExtent==scrollController.offset&&loading){
        print("pedir");
        BlocProvider.of<NewsBloc>(context).add(NewsGetEvent());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color8,
        body: BlocBuilder<NewsBloc,NewsState>(
          builder: (context, state) {
            if(state is NewsListOkState){
              _news=state.props[0];
              if(_news.length%10!=0){
                loading=false;
              }
            }
            return Stack(
              children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height*0.35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/background.jpg"),
                              fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                  Colors.black
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,

                              )
                            ),
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: size.height*0.07,
                              width: size.width,
                              padding: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText("Noticias COVID-19",style: TextStyle(color: color5,fontSize: 30,fontWeight: FontWeight.w300),maxLines: 1,minFontSize: 1,maxFontSize: 30,),
                            ),
                          ),
                        ),
                        Expanded(
                          child:Stack(
                            children: [
                              Container(
                                child: ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: ListView.separated(
                                    controller: scrollController,

                                      separatorBuilder: (context,index){
                                        return Divider(color: color5.withOpacity(0),);
                                      },

                                      padding: EdgeInsets.symmetric(horizontal:size.width*0.02,vertical: size.height*0.025),
                                      itemCount: _news.length+1,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context,index){
                                        if(index==_news.length){
                                          return Container(
                                              height: size.height*0.13,
                                              padding: EdgeInsets.only(bottom: size.height*0.075),
                                              alignment: Alignment.center,
                                              child: loading||
                                                  state is NewsLoadingState?SizedBox(
                                                child: CircularProgressIndicator(


                                                  backgroundColor: Colors.transparent,
                                                  valueColor: AlwaysStoppedAnimation(color5),
                                                  strokeWidth: 1.5,
                                                  //AlwaysStoppedAnimation<Color>(cargando?PrimaryColor:Colors.transparent),
                                                ),
                                                height: 15,
                                                width: 15,
                                              ):Container(child: Text("Fin de las noticias.",textAlign: TextAlign.center,style: TextStyle(color: color5.withOpacity(0.3),fontSize: 12),),),
                                          );
                                        }
                                        else{

                                          return NewsCard(size.width*0.96, 150, _news[index]);
                                        }
                                      }
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                  height: size.height*0.075,
                                  width: size.width,
                                  child: ClipRRect(

                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), //this determines the blur in the x and y directions best to keep to relitivly low numbers

                                        child: Container(
                                            color: Colors.white.withOpacity(0),
                                          ),
                                    ),
                                  )
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }
        )
      );
  }

  // Widget SpecificNews(int idNews){
  //   return AlertDialog(
  //     title: Text("News",style: TextStyle(color: color5,fontSize: 20),),
  //     content: SingleChildScrollView(
  //       child: Text("loremsafjlafjlasajfldsjalfjlsajfljakfl;jasl;fjklasjfl;asjkfkshafklhajsfkljhaskfhklshfksahfklhjaskd"
  //           "fhaksfhkasfksahfklhsajfhkashfkhsakfhaskjfhkashdfkahsdkfhkaslhdfkashfklhaskdfjhksadjfhkasjhdfjklahfdklsahfkljhsk"
  //           "lfjhkalshdfkashdfklsahfklsahdfklhsdfklhsdjkhfksadhfjkjsahdfjkashfkahskljfhasklfhklsahfklashfjkdlshaklfhjjkslajhfjklsahdf"),
  //     ),
  //     actions: <Widget>[
  //       TextButton(onPressed:(){Navigator.of(context).pop();} , child: Text("Aceptar")),
  //     ],
  //   );
  // }
}


