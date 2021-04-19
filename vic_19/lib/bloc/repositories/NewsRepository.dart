
import 'dart:convert';

import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/Model/News.dart';
import 'package:vic_19/util/ApiUrl.dart';
import 'package:http/http.dart' as http;
class NewsRepository {
  // List<News> _news;
  //
  // List<News> get news => _news;
  //
  // set news(List<News> value) {
  //   _news = value;
  // }
  Future <List<News>> getNews()async{
    try{
      // print(userId.toString());
      String url=ApiUrl+"news/list";
      // List<News> newsList;
      var res = await http.get(url, //ip for virtualized devices
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      var newsList2 = json.decode(utf8.decode(res.bodyBytes));

      var newsList3=List<News>();

      for(newsList2 in newsList2){
        newsList3.add(News.fromJson(newsList2));
      }
      print("prueba repository");
      print(newsList3[0].title);
      if(res.statusCode == 200){
        // print("DoneListaNews");
        return newsList3;
      }else{
        return null;
      }
    }
    catch(error){
      print(error);
      return null;
    }
  }

  // Future<void> getNews()async {
  //   await Future.delayed(Duration(seconds: 2));
  //   List<News> newsList=[News.fromNews(
  //       1,
  //       "Polémica por retraso en la vacunación masiva contra Covid-19 en Bolivia",
  //       """La vacunación masiva contra el Covid-19 debía despegar esta semana en Bolivia con los mayores de 60 años,pero afronta dificultades de coordinación, con polémicas sobre si hay o no suficientes vacunas, en medio de una huelga médica parcial que cumple 53 días y la frustración de mucha gente convocada a inmunizarse sin lograrlo."""
  //       , DateTime.now(), "https://s.france24.com/media/display/bb75a678-973a-11eb-867f-005056bff430/w:980/p:16x9/vacunas%20bolivia.webp"
  //       ,"https://www.france24.com/es/am%C3%A9rica-latina/20210407-vacunacion-bolivia-retraso-suministros-arce"),
  //     News.fromNews(
  //         2,
  //         "Boliviano de 101 años sobrevive al COVID-19",
  //         """Un hombre de 101 años de edad recibió el alta médica este sábado tras haber superado el COVID-19 y permanecer ingresado durante 22 días en un hospital de la ciudad boliviana de Cochabamba. El paciente, identificado como Daniel Jaldín, es cochabambino, vive en el asilo de ancianos El Buen Pastor y fue ingresado en el Hospital del Norte tras dar positivo en una prueba PCR, explicó a la agencia efe el director del centro de salud, José Luis Hidalgo."""
  //         , DateTime.now(), "https://static.dw.com/image/55542575_303.jpg"
  //         ,"https://www.dw.com/es/boliviano-de-101-a%C3%B1os-sobrevive-al-covid-19/a-57029135"),
  //     News.fromNews(
  //         3,
  //         "Brasil, Colombia, Venezuela, Perú y áreas de Bolivia sufren un fuerte aumento de casos de COVID-19",
  //         """América del Sur sigue siendo el epicentro de la pandemia en el continente americano y    se corre el riesgo de sufrir un repunte de casos más importante que durante el año pasado, advirtió este miércoles la Organización Panamericana de la Salud durante su rueda de prensa semanal donde analiza la evolución de la enfermedad La directora de la Organización, la doctora Carissa Etienne explicó que “el reciente incremento de casos en la Amazonía también se observa en los estados vecinos, y actualmente Brasil, Colombia, Venezuela, Perú y algunas áreas de Bolivia están experimentando un fuerte aumento en los casos de COVID”."""
  //         , DateTime.now()
  //         , "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/08-04-2021-UNICEF-UN0433280-Peru-vaccine.jpg/image1170x530cropped.jpg"
  //         ,"https://news.un.org/es/story/2021/04/1490852"),
  //     News.fromNews(
  //         4,
  //         "Polémica por retraso en la vacunación masiva contra Covid-19 en Bolivia",
  //         """Luego de realizar 9.818 pruebas este viernes, el Ministerio de Salud y Deportes detectó 1.246 nuevos contagios por Covid-19, lo que hizo ascender la cifra de positivos acumulados a 287.360, de los cuales 38.280 continúan activos en todo el país. Según el informe de la Dirección Nacional de Epidemiología, Santa Cruz es el epicentro de los nuevos infectados, pues registró 525 casos. Luego está La Paz con 218 nuevos enfermos, Cochabamba con 187, Tarija con 106 y Pando con 61. Mientras que en Beni se detectaron 52 casos, 50 en Chuquisaca, 29 en Oruro, y 18 en Potosí."""
  //         , DateTime.now(), "https://static.eldeber.com.bo//Files/Sizes/2021/4/17/foto-abi-personas-esperando-pruebas-de-coronavirus-en-bolivia_930384531_1140x520.jpeg"
  //         ,"https://eldeber.com.bo/pais/bolivia-reporta-1246-nuevos-contagios-de-covid-19-y-suman-38280-los-casos-activos_228360"),
  //     News.fromNews(
  //         1,
  //         "Polémica por retraso en la vacunación masiva contra Covid-19 en Bolivia",
  //         """La vacunación masiva contra el Covid-19 debía despegar esta semana en Bolivia con los mayores de 60 años,pero afronta dificultades de coordinación, con polémicas sobre si hay o no suficientes vacunas, en medio de una huelga médica parcial que cumple 53 días y la frustración de mucha gente convocada a inmunizarse sin lograrlo."""
  //         , DateTime.now(), "https://s.france24.com/media/display/bb75a678-973a-11eb-867f-005056bff430/w:980/p:16x9/vacunas%20bolivia.webp"
  //         ,"https://www.france24.com/es/am%C3%A9rica-latina/20210407-vacunacion-bolivia-retraso-suministros-arce"),
  //     News.fromNews(
  //         2,
  //         "Boliviano de 101 años sobrevive al COVID-19",
  //         """Un hombre de 101 años de edad recibió el alta médica este sábado tras haber superado el COVID-19 y permanecer ingresado durante 22 días en un hospital de la ciudad boliviana de Cochabamba. El paciente, identificado como Daniel Jaldín, es cochabambino, vive en el asilo de ancianos El Buen Pastor y fue ingresado en el Hospital del Norte tras dar positivo en una prueba PCR, explicó a la agencia efe el director del centro de salud, José Luis Hidalgo."""
  //         , DateTime.now(), "https://static.dw.com/image/55542575_303.jpg"
  //         ,"https://www.dw.com/es/boliviano-de-101-a%C3%B1os-sobrevive-al-covid-19/a-57029135"),
  //     News.fromNews(
  //         3,
  //         "Brasil, Colombia, Venezuela, Perú y áreas de Bolivia sufren un fuerte aumento de casos de COVID-19",
  //         """América del Sur sigue siendo el epicentro de la pandemia en el continente americano y    se corre el riesgo de sufrir un repunte de casos más importante que durante el año pasado, advirtió este miércoles la Organización Panamericana de la Salud durante su rueda de prensa semanal donde analiza la evolución de la enfermedad La directora de la Organización, la doctora Carissa Etienne explicó que “el reciente incremento de casos en la Amazonía también se observa en los estados vecinos, y actualmente Brasil, Colombia, Venezuela, Perú y algunas áreas de Bolivia están experimentando un fuerte aumento en los casos de COVID”."""
  //         , DateTime.now()
  //         , "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/08-04-2021-UNICEF-UN0433280-Peru-vaccine.jpg/image1170x530cropped.jpg"
  //         ,"https://news.un.org/es/story/2021/04/1490852"),
  //     News.fromNews(
  //         4,
  //         "Polémica por retraso en la vacunación masiva contra Covid-19 en Bolivia",
  //         """Luego de realizar 9.818 pruebas este viernes, el Ministerio de Salud y Deportes detectó 1.246 nuevos contagios por Covid-19, lo que hizo ascender la cifra de positivos acumulados a 287.360, de los cuales 38.280 continúan activos en todo el país. Según el informe de la Dirección Nacional de Epidemiología, Santa Cruz es el epicentro de los nuevos infectados, pues registró 525 casos. Luego está La Paz con 218 nuevos enfermos, Cochabamba con 187, Tarija con 106 y Pando con 61. Mientras que en Beni se detectaron 52 casos, 50 en Chuquisaca, 29 en Oruro, y 18 en Potosí."""
  //         , DateTime.now(), "https://static.eldeber.com.bo//Files/Sizes/2021/4/17/foto-abi-personas-esperando-pruebas-de-coronavirus-en-bolivia_930384531_1140x520.jpeg"
  //         ,"https://eldeber.com.bo/pais/bolivia-reporta-1246-nuevos-contagios-de-covid-19-y-suman-38280-los-casos-activos_228360")
  //   ];
  //   _news=newsList;
  //
  // }


}