import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/product/model/stock_book_model.dart';

import 'stock_book_manager.dart';

final stockBooksProvider = StateNotifierProvider<AllStockBookManager, List<StockBookModel>>((ref) {
  return AllStockBookManager();
});

final getAllStockBooksProvider = FutureProvider<List<StockBookModel>>((ref) async {
  await ref.read(stockBooksProvider.notifier).getAllStockBook();
  List<StockBookModel> _stockBoooks = await ref.watch(stockBooksProvider);
  return _stockBoooks;
});

final deneme = StateProvider.family<List<StockBookModel>, bool>((ref, isAdd) {
  return [];
});
