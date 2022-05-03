import 'package:intl/intl.dart';

class HelperClass {
  static String dateFormatter(DateTime dateTime) {
    //String stringDateTime = dateTime.toString();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(dateTime);
    return date;
  }
}
