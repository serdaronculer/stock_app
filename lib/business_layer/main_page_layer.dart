import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../product/model/stock_model.dart';
import '../product/providers/category_provider/all_providers.dart';
import '../product/providers/stock_provider/all_providers.dart';

class BLLMainPage {
  addStock(WidgetRef ref, TextEditingController _stockNameController, TextEditingController _stockQuantityController) {
    var selectedCategoryID = ref.watch(selectedCategoryProvider);
    var categories = ref.watch(categoriesProvider);
    var category = categories.firstWhere((element) => element.id == selectedCategoryID);

    ref.read(stocksProvider.notifier).addStock(StockModel.create(
        ref: ref,
        stockName: _stockNameController.text,
        categoryName: category.categoryName,
        quantity: int.parse(_stockQuantityController.text)));
  }
}
