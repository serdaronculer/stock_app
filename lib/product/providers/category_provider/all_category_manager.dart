import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stock_app/product/model/category_model.dart';

import '../../../data/abstract_local_storage.dart';
import '../../../main.dart';

class AllCategoryManager extends StateNotifier<List<CategoryModel>> {
  AllCategoryManager({List<CategoryModel>? initialCategory}) : super(initialCategory ?? []);

  final LocalStorageCategory _localStorage = locator<LocalStorageCategory>();
  //final HiveLocalStorageCategory _localStorage = HiveLocalStorageCategory();

  addCategory(CategoryModel categoryModel) async {
    bool isSuccesful = await _localStorage.addCategory(categoryModel: categoryModel);
    print(isSuccesful);
    if (isSuccesful) {
      state = [...state, categoryModel];
      return true;
    } else {
      return false;
    }
  }

  editCategory(CategoryModel categoryModel) async {
    _localStorage.editCategory(categoryModel: categoryModel);

    state = [
      for (var item in state)
        if (item.id == categoryModel.id) categoryModel else item
    ];
  }

   getAllCategory() async {
    List<CategoryModel> _allCategoryModels = await _localStorage.getAllCategory();

    state = _allCategoryModels;
  }

  Future<bool> deleteCategory(CategoryModel categoryModel) async {
    bool isSuccessful = await _localStorage.deleteCategory(categoryModel: categoryModel);
    if (isSuccessful) {
      state = state.where((element) => element.id != categoryModel.id).toList();
    }
    return isSuccessful;
  }
}
