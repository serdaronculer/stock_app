import 'package:stock_app/product/model/category_model.dart';
import 'package:stock_app/product/model/stock_book_model.dart';
import 'package:stock_app/product/model/stock_model.dart';

abstract class LocalStorageStockBook {
  Future<bool> addStockBook({required StockBookModel stockBookModel});
  Future<StockBookModel?> getStockBook({required int id});
  Future<List<StockBookModel>> getAllStockBook();
  Future<bool> deleteStockBook({required StockBookModel stockBookModel});
  Future<void> editStockBook({required StockBookModel stockBookModel});
}

abstract class LocalStorageStock {
  Future<bool> addStock({required StockModel stockModel});
  Future<StockModel?> getStock({required int id});
  Future<List<StockModel>> getAllStock();
  Future<bool> deleteStock({required StockModel stockModel});
  Future<void> editStock({required StockModel stockModel});
}

abstract class LocalStorageCategory {
  Future<bool> addCategory({required CategoryModel categoryModel});
  Future<CategoryModel?> getCategory({required int id});
  Future<List<CategoryModel>> getAllCategory();
  Future<bool> deleteCategory({required CategoryModel categoryModel});
  Future<void> editCategory({required CategoryModel categoryModel});
}
