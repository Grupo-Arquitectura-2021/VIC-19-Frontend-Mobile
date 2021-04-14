import 'package:flutter/material.dart';

import '../PaletteColor.dart';
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int idNews;
  Future<void> _showMyDialog(int idNews) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('News',style: TextStyle(color: color3),),
          backgroundColor: color1,
          content: SingleChildScrollView(
            child: Text("loremsafjlafjlasajfldsjalfjlsajfljakfl;jasl;fjklasjfl;asjkfkshafklhajsfkljhaskfhklshfksahfklhjaskd"
                "fhaksfhkasfksahfklhsajfhkashfkhsakfhaskjfhkashdfkahsdkfhkaslhdfkashfklhaskdfjhksadjfhkasjhdfjklahfdklsahfkljhsk"
                "lfjhkalshdfkashdfklsahfklsahdfklhsdfklhsdjkhfksadhfjkjsahdfjkashfkahskljfhasklfhklsahfklashfjkdlshaklfhjjkslajhfjklsahdf"
                "fhaksfhkasfksahfklhsajfhkashfkhsakfhaskjfhkashdfkahsdkfhkaslhdfkashfklhaskdfjhksadjfhkasjhdfjklahfdklsahfkljhsk"
                "fhaksfhkasfksahfklhsajfhkashfkhsakfhaskjfhkashdfkahsdkfhkaslhdfkashfklhaskdfjhksadjfhkasjhdfjklahfdklsahfkljhsk",style: TextStyle(color: color5),),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar',style: TextStyle(color: color4),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  List<String> _news=['breve descripcion','breve descripcion 2','breve descripcion 3','breve descripcion 4','breve descripcion 5','breve descripcion 6'];
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        child: ListView.builder(
          itemCount: _news.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  _showMyDialog(idNews);
                  // print("touch");
                  // setState(() {
                  //   SpecificNews(idNews);
                  // });
                  // SpecificNews(idNews);
                },
                child: Card(
                  color: color1,
                  elevation: 5,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: size.height*0.12,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10.0),
                    //   border: Border.all(color: color2)
                    // ),
                    // child: Center(child: Text("Title",style: TextStyle(color: color3,fontSize: size.height*0.035),)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Title",style: TextStyle(color: color3,fontSize: size.height*0.035),),
                        Text("${_news[index]}",style: TextStyle(color: color5,fontSize: size.height*0.02),),
                      ],
                    ),
                  ),
                ),
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


