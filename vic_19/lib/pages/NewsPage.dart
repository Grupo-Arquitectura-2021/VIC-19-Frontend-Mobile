import 'package:flutter/material.dart';

import '../PaletteColor.dart';
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  List<String> _news=['prueba','prueba2','prueba3','prueba4','prueba5','prueba6'];
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        child: ListView.builder(
          itemCount: _news.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context,index){
              return Card(
                color: color3,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: size.height*0.1,
                  child: Column(
                    children: [
                      Text("Title"),
                      Text("${_news[index]}"),
                    ],
                  ),
                ),
              );
            }
        )
      );
  }
}
