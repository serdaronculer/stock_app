import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_app/product/model/category_model.dart';
import 'package:stock_app/product/model/stock_model.dart';

import '../../product/model/stock_book_model.dart';

class SetupHive {
  SetupHive._();

  static Future<void> setupHive() async {
    await Hive.initFlutter("StockBookDatabase");
    Hive.registerAdapter(StockBookModelAdapter());
    Hive.registerAdapter(StockModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());

    var stockBookBox = await Hive.openBox<StockBookModel>("stockBooks");

    await Hive.openBox<StockModel>("stocks");
    var stockName =  Hive.box<StockModel>("stocks");
    //stockName.clear();

    await Hive.openBox<int>("stockID");

     await Hive.openBox<CategoryModel>("categories");
    

     await Hive.openBox<int>("categoryID");
   

    stockBookIDGenerator(stockBookBox);
  }

  static void stockBookIDGenerator(Box<StockBookModel> stockBookBox) async {
    int id = 0;
    var allStockBooks = stockBookBox.values.toList();
    if (allStockBooks.length > 1) {
      for (var i = 0; i < allStockBooks.length - 1; i++) {
        if (allStockBooks[i].id > allStockBooks[i + 1].id) {
          id = allStockBooks[i].id + 1;
        } else {
          id = allStockBooks[i + 1].id + 1;
        }
      }
    } else if (allStockBooks.length == 1) {
      id = allStockBooks[0].id + 1;
    } else {
      id = 0;
    }

    var stockBookBoxID = await Hive.openBox<int>("stockBookID");
    stockBookBoxID.put("id", id);

    int? idsi = stockBookBoxID.get("id");
    print(idsi);
  }
}
