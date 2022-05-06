import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/product/model/stock_book_model.dart';

class SelectedStockBooksManager extends StateNotifier<List<StockBookModel>> {
  SelectedStockBooksManager({List<StockBookModel>? state}) : super(state ?? []);

  addStockBook(StockBookModel stockBookModel) {
    state = [...state, stockBookModel];
  }

  editStockBook(int id, String bookName) {
    StockBookModel stockBookModel = state.firstWhere((element) => element.id == id);

    state = [
      for (var item in state)
        if (item.id == id) stockBookModel.copyWith(bookName: bookName) else item
    ];
  }

  removeStockBook(StockBookModel stockBookModel) async {
    state = state.where((element) => element.id != stockBookModel.id).toList();
  }

  removeAllStockBook() {
    state = [];
  }
}
