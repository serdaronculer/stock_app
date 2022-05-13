import 'package:intl/intl.dart';

class HelperClass {
  HelperClass._();

  static String dateFormatter(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    String date = formatter.format(dateTime);
    return date;
  }


}
