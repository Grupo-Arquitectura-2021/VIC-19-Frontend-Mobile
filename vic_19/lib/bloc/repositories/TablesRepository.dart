import 'dart:convert';

import 'package:vic_19/Model/LocationData.dart';
import 'package:vic_19/util/ApiUrl.dart';

import 'package:http/http.dart' as http;

class TablesRepository {
  List<LocationData> _data;
  LocationData _selectData;


  List<LocationData> get data => _data;

  set data(List<LocationData> value) {
    _data = value;
  }

  Future<void> getCities(String dateCity)async{
    String url=ApiUrl+"city?date="+dateCity;
    var res = await http.get(url, //ip for virtualized devices
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    var citiesList2 = json.decode(utf8.decode(res.bodyBytes));

    var citiesList3=List<LocationData>();

    for(var n in citiesList2){
      citiesList3.add(LocationData.fromJson(n));
    }
    print("prueba repository cities");
    print(citiesList3[0].total);
    if(res.statusCode == 200){
      data=citiesList3;
    }
  }

  // Future<void> getMunicipality(LocationData _selectData)async {
  //   await Future.delayed(Duration(seconds: 2));
  //   List<LocationData> municipality=[LocationData.fromLocationData(1,"La Paz",'2021-04-11T00:00:00.000+00:00',123,300,500,120,800),
  //     LocationData.fromLocationData(2,"El Alto",345,345,32,120,800),
  //     LocationData.fromLocationData(3,"Palca",45,132,465,120,800),
  //     LocationData.fromLocationData(4,"Mecapaca",165,465,132,120,800),
  //     LocationData.fromLocationData(5,"Achocalla",498,162,489,120,800),
  //     LocationData.fromLocationData(6,"Viacha",765,768,132,120,800),
  //     LocationData.fromLocationData(7,"Laja",132,465,87,120,800),
  //     LocationData.fromLocationData(8,"Pucarani",456,798,132,120,800),];
  //   data=municipality;
  //
  // }
  // Future<void> getCities()async {
  //   await Future.delayed(Duration(seconds: 2));
  //   List<LocationData> cities=[LocationData.fromLocationData(1,"La Paz",123,300,500,120,800),
  //     LocationData.fromLocationData(2,"Santa Cruz",345,345,32,120,800),
  //     LocationData.fromLocationData(3,"Cochabamba",45,132,465,120,800),
  //     LocationData.fromLocationData(4,"Potosi",165,465,132,120,800),
  //     LocationData.fromLocationData(5,"Oruro",498,162,489,120,800),
  //     LocationData.fromLocationData(6,"Chuquisaca",765,768,132,120,800),
  //     LocationData.fromLocationData(7,"Tarija",132,465,87,120,800),
  //     LocationData.fromLocationData(8,"Pando",456,798,132,120,800),
  //     LocationData.fromLocationData(8,"Beni",132,784,35,120,800),];
  //   data=cities;
  //
  // }




  LocationData get selectData => _selectData;

  set selectData(LocationData value) {
    _selectData = value;
  }
}