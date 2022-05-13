import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/data/abstract_local_storage.dart';
import 'package:stock_app/product/model/stock_model.dart';

import '../../../data/hive/hive_local_storage_stock.dart';
import '../../../main.dart';

class AllStockManager extends StateNotifier<List<StockModel>> {
  AllStockManager({List<StockModel>? initialStock}) : super(initialStock ?? []);

  final LocalStorageStock _localStorage2 = locator<LocalStorageStock>();
  final HiveLocalStorageStock _localStorage = HiveLocalStorageStock();

  Future<bool> addStock(StockModel stockModel) async {
    bool isSuccessful = await _localStorage.addStock(stockModel: stockModel);

    if (isSuccessful) {
      state = [...state, stockModel];
      return true;
    } else {
      return false;
    }
  }

  editStock(StockModel stockModel) async {
    _localStorage.editStock(stockModel: stockModel);

    state = [
      for (var item in state)
        if (item.id == stockModel.id) stockModel else item
    ];
  }

  getAllStocks() async {
    List<StockModel> _allStocks = await _localStorage.getAllStock();

    state = _allStocks;
  }

  Future<bool> deleteStock(StockModel stockModel) async {
    bool isSuccessful = await _localStorage.deleteStock(stockModel: stockModel);
    if (isSuccessful) {
      state = state.where((element) => element.id != stockModel.id).toList();
    }
    return isSuccessful;
  }
}
