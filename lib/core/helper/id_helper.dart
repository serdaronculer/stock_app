import 'package:hive/hive.dart';

class IDHelper {
  late Box<int> _stockBookBoxID;
  IDHelper() {
    _stockBookBoxID = Hive.box<int>("stockBooksID");
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
