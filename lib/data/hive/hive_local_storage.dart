

import 'package:hive/hive.dart';
import 'package:stock_app/data/abstract_local_storage.dart';
import 'package:stock_app/product/model/stock_book_model.dart';

class HiveLocalStorage extends LocalStorage {
  late Box<StockBookModel> _stockBookBox;

  HiveLocalStorage() {
    _stockBookBox = Hive.box<StockBookModel>("stockBooks");
  }
  @override
  Future<bool> addStockBook({required StockBookModel stockBookModel}) async {
    try {
      await _stockBookBox.put(stockBookModel.id, stockBookModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteStockBook({required StockBookModel stockBookModel}) async {
    try {
      await stockBookModel.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<StockBookModel>> getAllStockBook() async {
    var _allStockBook = _stockBookBox.values.toList();
    if (_allStockBook.isNotEmpty) {
      _allStockBook.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    }
    return _allStockBook;
  }

  @override
  Future<StockBookModel?> getStockBook({required int id}) async {
    if (_stockBookBox.containsKey(id)) {
      return _stockBookBox.get(id);
    } else {
      return null;
    }
  }

  @override
  Future<void> editStockBook({required StockBookModel stockBookModel}) async {
    if (_stockBookBox.containsKey(stockBookModel.id)) {
      await _stockBookBox.put(stockBookModel.id, stockBookModel);
    }
  }
}
