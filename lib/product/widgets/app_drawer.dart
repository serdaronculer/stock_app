import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/padding_constants.dart';
import '../../core/constants/size_constants.dart';
import '../../core/scroll.dart';
import '../language/language_items.dart';
import '../model/stock_book_model.dart';
import '../providers/all_providers.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final selectedStockBook = ref.watch(selectedStockBookProvider);
    final allStockBooks = ref.watch(stockBooksProvider);

    return Drawer(
      elevation: 8,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: AppPadding.largePadding, left: AppPadding.mediumPadding, right: AppPadding.mediumPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        LanguageItems.myStockBooks,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(flex: 1, child: Text(LanguageItems.activeStockBook)),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Chip(
                                padding: const EdgeInsets.all(AppSize.smallSize),
                                backgroundColor: AppColors.emerald,
                                avatar: const Icon(Icons.book),
                                label: Text(
                                  selectedStockBook.bookName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Chip(label: Text(allStockBooks.length.toString())),
                ],
              ),
              const Divider(),
              Expanded(
                flex: 10,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    children: stockBookItems(allStockBooks),
                  ),
                ),
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(LanguageItems.signOut),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ListTile> stockBookItems(List<StockBookModel> allStockBooks) {
    List<ListTile> widgetList = [];

    for (var i = 0; i < allStockBooks.length; i++) {
      var listTile = ListTile(
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        title: Text(
          allStockBooks[i].bookName,
          style: Theme.of(context).textTheme.headline6,
        ),
      );
      widgetList.add(listTile);
    }
    return widgetList;
  }
}
