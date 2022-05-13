import 'package:hive/hive.dart';

class StockIDHelper{
  late Box<int> _stockBoxID;

  StockIDHelper() {
    _stockBoxID = Hive.box<int>("stockID");
  }

    int getID() {
    int id = _stockBoxID.get("id") ?? 0;
     _setID(id);
    return id;
  }


  _setID(int id) async {
    int newID = id + 1;
    await _stockBoxID.put("id", newID);
  }
}