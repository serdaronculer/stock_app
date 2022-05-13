import 'package:hive/hive.dart';

class StockBookIDHelper {
  late Box<int> _stockBookBoxID;
  StockBookIDHelper() {
    _stockBookBoxID = Hive.box<int>("stockBookID");
  }

  int? getID() {
    int? id = _stockBookBoxID.get("id");
    _setID(id);
    return id;
  }

  _setID(int? id) async {
    int newID = id! + 1;
    await _stockBookBoxID.put("id", newID);
  }
}

