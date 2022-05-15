import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/product/model/stock_model.dart';

import '../pages/table_page.dart';
import '../product/providers/category_provider/all_providers.dart';
import '../product/providers/stock_provider/all_providers.dart';

class BLLTablePage {
  editStock(TextEditingController _stockNameController, TextEditingController _quantityController, WidgetRef ref,
      StockProcessStatus addRemove, StockModel stockModel) {
    var stockName = _stockNameController.text;
    int stockQuantity;
    var j = ref.watch(selectedCategoryProvider);

    var selectedCategory = ref.watch(categoriesProvider).firstWhere((element) => element.id == j);

    _quantityController.text.isEmpty ? _quantityController.text = "0" : _quantityController.text;
    if (addRemove == StockProcessStatus.add) {
      stockQuantity = (stockModel.quantity + int.parse(_quantityController.text));
    } else {
      stockQuantity = (stockModel.quantity - int.parse(_quantityController.text));
    }
    ref
        .read(stocksProvider.notifier)
        .addStock(stockModel.copyWith(stockName: stockName, quantity: stockQuantity, categoryName: selectedCategory.categoryName));
  }
}
