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
  EasyRefreshController _easyRefreshController=EasyRefreshController();
  List<News> _news= List();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color3.withOpacity(0.9),
        title: Text("Noticias",textAlign: TextAlign.center,style: TextStyle(color: color1,fontSize:30,fontWeight: FontWeight.w400),),

      ),
        body: BlocBuilder<NewsBloc,NewsState>(
          builder: (context, state) {
            if(state is NewsListOkState){
              _easyRefreshController.finishRefresh();
              _news=state.props[0];
              print(_news);
            }
            return Stack(
              children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: EasyRefresh(
                        controller: _easyRefreshController,
                        onRefresh: ()async{
                          BlocProvider.of<NewsBloc>(context).add(NewsGetEvent());
                        },

                        header: MaterialHeader(
                          backgroundColor: Colors.transparent,

                            valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),

                        ),
                        child: ListView.separated(

                            separatorBuilder: (context,index){
                              return Divider(color: color3,);
                            },

                            padding: EdgeInsets.all(size.width*0.01),
                            itemCount: _news.length+1,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              if(index==_news.length){
                                return SizedBox(height: size.height*0.08);
                              }
                              else{

                                return NewsCard(size.width*0.98, size.height*0.15, _news[index]);
                              }
                            }
                        ),
                      )
                    ),
                  ),
                state is NewsLoadingState?Loading():Container()
              ],
            );
          }
        )
      );
  }

  Widget SpecificNews(int idNews){
    return AlertDialog(
      title: Text("News",style: TextStyle(color: color5,fontSize: 20),),
      content: SingleChildScrollView(
        child: Text("loremsafjlafjlasajfldsjalfjlsajfljakfl;jasl;fjklasjfl;asjkfkshafklhajsfkljhaskfhklshfksahfklhjaskd"
            "fhaksfhkasfksahfklhsajfhkashfkhsakfhaskjfhkashdfkahsdkfhkaslhdfkashfklhaskdfjhksadjfhkasjhdfjklahfdklsahfkljhsk"
            "lfjhkalshdfkashdfklsahfklsahdfklhsdfklhsdjkhfksadhfjkjsahdfjkashfkahskljfhasklfhklsahfklashfjkdlshaklfhjjkslajhfjklsahdf"),
      ),
      actions: <Widget>[
        TextButton(onPressed:(){Navigator.of(context).pop();} , child: Text("Aceptar")),
      ],
    );
  }
}


