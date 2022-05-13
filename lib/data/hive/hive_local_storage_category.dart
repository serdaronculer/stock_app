import 'package:hive/hive.dart';
import 'package:stock_app/data/abstract_local_storage.dart';
import 'package:stock_app/product/model/category_model.dart';

class HiveLocalStorageCategory extends LocalStorageCategory {
  late Box<CategoryModel> _categoryBox;
  HiveLocalStorageCategory() {
    _categoryBox = Hive.box<CategoryModel>("categories");
  }

  @override
  Future<bool> addCategory({required CategoryModel categoryModel}) async {
    try {
      await _categoryBox.put(categoryModel.id, categoryModel);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> deleteCategory({required CategoryModel categoryModel}) async {
    try {
      await _categoryBox.delete(categoryModel.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> editCategory({required CategoryModel categoryModel}) async {
    if (_categoryBox.containsKey(categoryModel.id)) {
      await _categoryBox.put(categoryModel.id, categoryModel);
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    var _allCategories = _categoryBox.values.toList();
    if (_allCategories.isNotEmpty) {
      _allCategories.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    }
    return _allCategories;
  }

  @override
  Future<CategoryModel?> getCategory({required int id}) async {
    if (_categoryBox.containsKey(id)) {
      return _categoryBox.get(id);
    }
    return null;
  }
}
