import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../product/model/stock_book_model.dart';
import '../product/providers/stock_book_provider/all_providers.dart';

class BLLLoginPage {


  editSelectedStockBook(WidgetRef ref, BuildContext context, TextEditingController textEditingController) {
    var selectedStockBook = ref.watch(selectedStockBooksProivder).first;

    ref.watch(selectedStockBooksProivder.notifier).editStockBook(selectedStockBook.id, textEditingController.text);
    ref.watch(stockBooksProvider.notifier).editStockBook(selectedStockBook.copyWith(bookName: textEditingController.text));
    ref.watch(selectedStockBooksProivder.notifier).removeAllStockBook();
    Navigator.of(context).pop();
    textEditingController.text = "";
  }

    deleteSelectedStockBooks(WidgetRef ref, BuildContext context, TextEditingController textEditingController) {
    var selectedStockBooks = ref.watch(selectedStockBooksProivder);

    for (var item in selectedStockBooks) {
      ref.watch(stockBooksProvider.notifier).deleteStockBook(item);
    }
    ref.watch(selectedStockBooksProivder.notifier).removeAllStockBook();
    Navigator.of(context).pop();
  }

   addStockBook(WidgetRef ref, BuildContext context, TextEditingController textEditingController) {
    ref.read(stockBooksProvider.notifier).addStockBook(StockBookModel.create(textEditingController.text));
    textEditingController.text = "";
    Navigator.of(context).pop();
  }

}
