import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/core/constants/constants.dart';

import 'package:stock_app/core/scroll.dart';
import 'package:stock_app/product/language/language_items.dart';

import '../../core/helper/all_helper.dart';

import '../model/stock_book_model.dart';
import '../model/stock_model.dart';
import '../providers/stock_book_provider/all_providers.dart';

class StockBookListWidget extends ConsumerStatefulWidget {
  const StockBookListWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StockBookListWidgetState();
}

class _StockBookListWidgetState extends ConsumerState<StockBookListWidget> {
  late Box<int> _selectedStockBook;
  @override
  void initState() {
    super.initState();
    Hive.box<StockModel>("stocks");
    _selectedStockBook = Hive.box<int>("selectedStockBookID");
  }

  @override
  Widget build(BuildContext context) {
    final _allStockBooks = ref.watch(getAllStockBooksProvider);

    return Expanded(
      child: _allStockBooks.when(data: (allStockBooks) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            itemCount: allStockBooks.length,
            itemBuilder: (context, index) {
              StockBookModel _stockBook = allStockBooks[index];
              return listItem(_stockBook);
            },
          ),
        );
      }, error: (err, stackTree) {
        return Center(child: Text(err.toString()));
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  Padding listItem(StockBookModel _stockBook) {
    final selectedStockBooks = ref.watch(selectedStockBooksProivder);
    bool isSelected = selectedStockBooks.any((element) => element.id == _stockBook.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.smallPadding),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          isSelected ? Colors.green.withOpacity(0.7) : Colors.transparent,
          BlendMode.hardLight,
        ),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          child: Theme(
            data: ThemeData().copyWith(splashColor: Colors.transparent),
            child: ListTile(
              onLongPress: () {
                changeStatus(_stockBook, false);
              },
              onTap: () {
                if (selectedStockBooks.isEmpty) {
                  Navigator.of(context).pushNamed('/home');
                  ref.watch(setStockBookSelectedProvider.state).state = _stockBook;

                  saveSelectedStockBook(_stockBook);
                } else {
                  changeStatus(_stockBook, true);
                }
              },
              leading: const Icon(Icons.book),
              trailing: const Icon(
                Icons.chevron_right_outlined,
                size: AppSize.largeSize,
              ),
              title: Text(_stockBook.bookName),
              subtitle: Text("${LanguageItems.creationDate} ${HelperClass.dateFormatter(_stockBook.creationDate)}"),
            ),
          ),
        ),
      ),
    );
  }

  saveSelectedStockBook(StockBookModel _stockBook) async {
    await _selectedStockBook.clear();
    await _selectedStockBook.put(_stockBook.id, _stockBook.id);
  
  }

  changeStatus(StockBookModel stockBookModel, bool onTap) {
    final selectedStockBooks = ref.watch(selectedStockBooksProivder);
    bool isSelected = selectedStockBooks.any((element) => element.id == stockBookModel.id);
    if (onTap) {
      if (!isSelected && selectedStockBooks.isNotEmpty) {
        ref.read(selectedStockBooksProivder.notifier).addStockBook(stockBookModel);
      } else if (isSelected && selectedStockBooks.isNotEmpty) {
        ref.read(selectedStockBooksProivder.notifier).removeStockBook(stockBookModel);
      }
    } else {
      if (!isSelected) {
        ref.read(selectedStockBooksProivder.notifier).addStockBook(stockBookModel);
      }
    }
  }
}
