import 'package:hive/hive.dart';

class CategoryIDHelper {
  late Box<int> _categoryBoxID;

  CategoryIDHelper() {
    _categoryBoxID = Hive.box<int>("categoryID");
  }

  int getID() {
    int id = _categoryBoxID.get("id") ?? 0;
    _setID(id);
    return id;
  }

  _setID(int id) async {
    int newID = id + 1;
    await _categoryBoxID.put("id", newID);
  }
}
