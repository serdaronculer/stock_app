import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/product/model/stock_book_model.dart';
import 'package:stock_app/product/providers/selected_stock_books_manager.dart';

import 'all_stock_book_manager.dart';

final stockBooksProvider = StateNotifierProvider<AllStockBookManager, List<StockBookModel>>((ref) {
  return AllStockBookManager();
});

final getAllStockBooksProvider = FutureProvider.autoDispose<List<StockBookModel>>((ref) async {
  await ref.read(stockBooksProvider.notifier).getAllStockBook();
  List<StockBookModel> _stockBoooks = await ref.watch(stockBooksProvider);
  return _stockBoooks;
});

final selectedStockBooksProivder = StateNotifierProvider.autoDispose<SelectedStockBooksManager, List<StockBookModel>>((ref) {
  return SelectedStockBooksManager();
});

final setStockBookSelectedProvider = StateProvider<StockBookModel>((ref) {
  return StockBookModel(id: 999, bookName: "", creationDate: DateTime.now());
});

final selectedStockBookProvider = Provider<StockBookModel>((ref) {
  StockBookModel stockBook = ref.watch((setStockBookSelectedProvider));
  return stockBook;
});


