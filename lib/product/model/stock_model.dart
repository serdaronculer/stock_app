import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/product/model/stock_book_model.dart';

import '../../core/helper/stock_id_helper.dart';
import '../providers/stock_book_provider/all_providers.dart';

part 'stock_model.g.dart';

@HiveType(typeId: 2)
class StockModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int stockBookID;

  @HiveField(2)
  final String stockName;

  @HiveField(3)
  final String categoryName;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final DateTime creationDate;

  StockModel(
      {required this.id,
      required this.stockBookID,
      required this.stockName,
      required this.categoryName,
      required this.creationDate,
      required this.quantity});

  StockModel copyWith({
    String? stockName,
    String? categoryName,
    int? quantity,
    DateTime? creationDate,
  }) {
    return StockModel(
      id: id,
      stockBookID: stockBookID,
      stockName: stockName ?? this.stockName,
      quantity: quantity ?? this.quantity,
      categoryName: categoryName ?? this.categoryName,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  factory StockModel.create({required WidgetRef ref, required String stockName, required String categoryName, required int quantity}) {
    StockBookModel stockBook = ref.watch(selectedStockBookProvider);
    StockIDHelper idHelper = StockIDHelper();
    return StockModel(
        id: idHelper.getID(),
        stockBookID: stockBook.id,
        stockName: stockName,
        categoryName: categoryName,
        quantity: quantity,
        creationDate: DateTime.now());
  }
}
