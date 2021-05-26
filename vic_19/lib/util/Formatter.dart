import 'package:intl/intl.dart';

class Formatter{
  static formatDate(DateTime date){
    var dateFormat=DateFormat("dd-MM-yy hh:mm aa");
    return dateFormat.format(date);
  }
}