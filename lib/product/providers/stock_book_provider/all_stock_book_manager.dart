import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/data/abstract_local_storage.dart';


import 'package:stock_app/main.dart';
import 'package:stock_app/product/model/stock_book_model.dart';

class AllStockBookManager extends StateNotifier<List<StockBookModel>> {
  AllStockBookManager({List<StockBookModel>? initialStockBook}) : super(initialStockBook ?? []);


  final LocalStorageStockBook _localStorage = locator<LocalStorageStockBook>();
 
  Future<bool> addStockBook(StockBookModel stockBookModel) async {
    bool isSuccessful = await _localStorage.addStockBook(stockBookModel: stockBookModel);

    if (isSuccessful) {
      state = [...state, stockBookModel];
      return true;
    } else {
      return false;
    }
  }

  editStockBook(StockBookModel stockBookModel) async {
    _localStorage.editStockBook(stockBookModel: stockBookModel);

    state = [
      for (var item in state)
        if (item.id == stockBookModel.id) stockBookModel else item
    ];
  }

  getAllStockBook() async {
    List<StockBookModel> _allStockBookModels = await _localStorage.getAllStockBook();

    state = _allStockBookModels;
  }

  Future<bool> deleteStockBook(StockBookModel stockBookModel) async {
    bool isSuccessful = await _localStorage.deleteStockBook(stockBookModel: stockBookModel);
    if (isSuccessful) {
      state = state.where((element) => element.id != stockBookModel.id).toList();
    }
    return isSuccessful;
  }
}
