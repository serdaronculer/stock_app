import 'package:hive/hive.dart';
import 'package:stock_app/core/helper/id_helper.dart';
part 'stock_book_model.g.dart';

@HiveType(typeId: 1)
class StockBookModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String bookName;

  @HiveField(2)
  final DateTime creationDate;

  StockBookModel({
    required this.id,
    required this.bookName,
    required this.creationDate,
  });

  factory StockBookModel.create(String bookName) {
    IDHelper idHelper = IDHelper();

    return StockBookModel(id: idHelper.getID()!, bookName: bookName, creationDate: DateTime.now());
  }

  StockBookModel copyWith({int? id, String? bookName, DateTime? creationDate}) {
    return StockBookModel(id: id ?? this.id, bookName: bookName ?? this.bookName, creationDate: creationDate ?? this.creationDate);
  }
}
