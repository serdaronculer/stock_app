import 'package:hive/hive.dart';
import 'package:stock_app/product/model/stock_model.dart';

import '../abstract_local_storage.dart';

class HiveLocalStorageStock extends LocalStorageStock {
  late Box<StockModel> _stockBox;

  HiveLocalStorageStock() {
    _stockBox = Hive.box<StockModel>("stocks");
  }

  @override
  Future<bool> addStock({required StockModel stockModel}) async {
    try {
      await _stockBox.put(stockModel.id, stockModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteStock({required StockModel stockModel}) async {
    try {
      await _stockBox.delete(stockModel.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> editStock({required StockModel stockModel}) async {
    if (_stockBox.containsKey(stockModel.id)) {
      await _stockBox.put(stockModel.id, stockModel);
    }
  }

  @override
  Future<List<StockModel>> getAllStock() async{
  var _allStocks = _stockBox.values.toList();
    if (_allStocks.isNotEmpty) {
      _allStocks.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    }
    return _allStocks;
  }

  @override
  Future<StockModel?> getStock({required int id}) async{
   if (_stockBox.containsKey(id)) {
      return _stockBox.get(id);
    } else {
      return null;
    }
  }
}
