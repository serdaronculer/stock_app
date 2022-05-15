import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/product/model/stock_model.dart';

import 'all_stock_manager.dart';

final stocksProvider = StateNotifierProvider<AllStockManager, List<StockModel>>((ref) {
  return AllStockManager();
});

final allStocksProvider = FutureProvider<List<StockModel>>((ref) async {
  await ref.read(stocksProvider.notifier).getAllStocks();
  List<StockModel> _stocks = await ref.watch(stocksProvider);
  return _stocks;
});

final getFilteredStocksProvider = StateProvider<AsyncValue<List<StockModel>>>((ref) {
  var _stocks = ref.watch(allStocksProvider);

  return _stocks;
});
