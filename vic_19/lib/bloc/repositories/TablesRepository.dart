
import 'package:vic_19/Model/LocationData.dart';

class TablesRepository {
  List<LocationData> _data;
  LocationData _selectData;


  List<LocationData> get data => _data;

  set data(List<LocationData> value) {
    _data = value;
  }

  Future<void> getMunicipality(LocationData _selectData)async {
    await Future.delayed(Duration(seconds: 2));
    List<LocationData> municipality=[LocationData.fromLocationData(1,"La Paz",123,300,500,120,800),
      LocationData.fromLocationData(2,"El Alto",345,345,32,120,800),
      LocationData.fromLocationData(3,"Palca",45,132,465,120,800),
      LocationData.fromLocationData(4,"Mecapaca",165,465,132,120,800),
      LocationData.fromLocationData(5,"Achocalla",498,162,489,120,800),
      LocationData.fromLocationData(6,"Viacha",765,768,132,120,800),
      LocationData.fromLocationData(7,"Laja",132,465,87,120,800),
      LocationData.fromLocationData(8,"Pucarani",456,798,132,120,800),];
    data=municipality;

  }
  Future<void> getCities()async {
    await Future.delayed(Duration(seconds: 2));
    List<LocationData> cities=[LocationData.fromLocationData(1,"La Paz",123,300,500,120,800),
      LocationData.fromLocationData(2,"Santa Cruz",345,345,32,120,800),
      LocationData.fromLocationData(3,"Cochabamba",45,132,465,120,800),
      LocationData.fromLocationData(4,"Potosi",165,465,132,120,800),
      LocationData.fromLocationData(5,"Oruro",498,162,489,120,800),
      LocationData.fromLocationData(6,"Chuquisaca",765,768,132,120,800),
      LocationData.fromLocationData(7,"Tarija",132,465,87,120,800),
      LocationData.fromLocationData(8,"Pando",456,798,132,120,800),
      LocationData.fromLocationData(8,"Beni",132,784,35,120,800),];
    data=cities;

  }




  LocationData get selectData => _selectData;

  set selectData(LocationData value) {
    _selectData = value;
  }
}