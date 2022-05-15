import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/product/model/category_model.dart';
import 'package:stock_app/product/providers/category_provider/all_category_manager.dart';

final categoriesProvider = StateNotifierProvider<AllCategoryManager, List<CategoryModel>>((ref) {
  return AllCategoryManager();
});

final getAllCategoryProvider = FutureProvider.autoDispose<List<CategoryModel>>((ref) async {
  await ref.read(categoriesProvider.notifier).getAllCategory();
  List<CategoryModel> _categories = await ref.watch(categoriesProvider);
  return _categories;
});

final setCategoryProvider = StateProvider((ref) {
  return 0;
});

final selectedCategoryProvider = Provider((ref) {
  return ref.watch(setCategoryProvider);
});

final setCategoryFilteredProvider = StateProvider((ref) {
  return 0;
});

final selectedCategoryFilteredProvider = Provider((ref) {
 return ref.watch(setCategoryFilteredProvider);

});
