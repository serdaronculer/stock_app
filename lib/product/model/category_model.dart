import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/core/helper/category_id_helper.dart';
import 'package:stock_app/product/model/stock_book_model.dart';

import '../providers/stock_book_provider/all_providers.dart';

part 'category_model.g.dart';

@HiveType(typeId: 3)
class CategoryModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int stockBookID;

  @HiveField(2)
  final String categoryName;

  @HiveField(3)
  final DateTime creationDate;

  CategoryModel({required this.stockBookID, required this.id, required this.categoryName, required this.creationDate});

  CategoryModel copyWith({String? categoryName}) {
    return CategoryModel(id: id, stockBookID: stockBookID, categoryName: categoryName ?? this.categoryName, creationDate: creationDate);
  }

  factory CategoryModel.create({required WidgetRef ref, required String categoryName}) {
    StockBookModel stockBook = ref.watch(selectedStockBookProvider);
    CategoryIDHelper idHelper = CategoryIDHelper();
    return CategoryModel(stockBookID: stockBook.id, id: idHelper.getID(), categoryName: categoryName, creationDate: DateTime.now());
  }
}
