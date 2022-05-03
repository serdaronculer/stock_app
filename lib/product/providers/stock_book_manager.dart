import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stock_app/data/hive/hive_local_storage.dart';
import 'package:stock_app/product/model/stock_book_model.dart';

class AllStockBookManager extends StateNotifier<List<StockBookModel>> {
  AllStockBookManager({List<StockBookModel>? initialStockBook}) : super(initialStockBook ?? []);

  final HiveLocalStorage _hiveLocalStorage = HiveLocalStorage();

  Future<bool> addStockBook(StockBookModel stockBookModel) async {
    bool isSuccessful = await _hiveLocalStorage.addStockBook(stockBookModel: stockBookModel);

    if (isSuccessful) {
      state = [...state, stockBookModel];
      return true;
    } else {
      return false;
    }
  }

  /*  Future<StockBookModel?> getStockBook(int id) async {
    StockBookModel? _stockBookModel = await _hiveLocalStorage.getStockBook(id: id);

    return _stockBookModel;
  } */

  getAllStockBook() async {
    List<StockBookModel> _allStockBookModels = await _hiveLocalStorage.getAllStockBook();

    state = _allStockBookModels;
  }

  Future<bool> deleteStockBook(StockBookModel stockBookModel) async {
    bool isSuccessful = await _hiveLocalStorage.deleteStockBook(stockBookModel: stockBookModel);
    if (isSuccessful) {
      state = state.where((element) => element.id != stockBookModel.id).toList();
    }
    return isSuccessful;
  }
}
