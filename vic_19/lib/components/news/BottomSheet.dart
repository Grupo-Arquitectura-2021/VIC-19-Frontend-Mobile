import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/util/Formatter.dart';
import 'package:vic_19/util/MyBehavior.dart';

import '../../PaletteColor.dart';
class CardBottomSheet extends StatelessWidget {
  double _width;
  double _height;
  News _news;
  Color _color;
  Color _background;
  CardBottomSheet(this._width, this._height, this._news, this._color,this._background);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(15)
      ),
      padding:EdgeInsets.only(left:_width*0.07,right:_width*0.07,top: _width*0.07),
      child: Column(
        children: [
          Container(

            height: _height*0.1-_width*0.07,
            alignment: Alignment.centerLeft,
            child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,color: color5)),
          ),
          Container(
            height: _height*0.3,
            child: Container(
              decoration: BoxDecoration(
                  // color: color2,
                  image: DecorationImage(
                      image: NetworkImage(_news.newsImages),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
          Container(
            height: _height*0.6,
            padding: EdgeInsets.only(top: _height*0.02),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                children: [
                  Text(Formatter.formatDate(_news.dateNews),style: TextStyle(color: color5.withOpacity(0.5),fontSize: 12,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,),
                  SizedBox(height: 10,),
                  Text(_news.title,style: TextStyle(color: color5,fontSize: 22,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,),
                  SizedBox(height: 10,),
                  Text(_news.content,style: TextStyle(color: color5.withOpacity(0.5),fontSize:16),textAlign: TextAlign.justify,),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      // print("url seleccionada");
                      // _launchInBrowser(_news.source);
                      openUrl(_news.newsUrl);
                    },
                      child: Center(child: Row(children: [Text("Ir a la fuente ",style: TextStyle(color: _color,fontSize: 14),),Icon(Icons.keyboard_arrow_right,color: _color,size: 14,)],))),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}


Future <void> openUrl(String source) async =>
  await canLaunch(source)?await launch(source):throw 'could not launch $source';

// Future<void> _launchInBrowser(String url) async {
//   if (await canLaunch(url)) {
//     await launch(
//       url,
//       forceSafariVC: false,
//       forceWebView: false,
//       headers: <String, String>{'my_header_key': 'my_header_value'},
//     );
//   } else {
//     throw 'Could not launch $url';
//   }
// }


