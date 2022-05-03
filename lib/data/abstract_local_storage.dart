import 'package:stock_app/product/model/stock_book_model.dart';

abstract class LocalStorage {
  Future<bool> addStockBook({required StockBookModel stockBookModel});
  Future<StockBookModel?> getStockBook({required int id});
  Future<List<StockBookModel>> getAllStockBook();
  Future<bool> deleteStockBook({required StockBookModel stockBookModel});
}
