import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_app/business_layer/login_page_layer.dart';
import 'package:stock_app/core/constants/constants.dart';

import 'package:stock_app/product/language/language_items.dart';

import 'package:stock_app/product/widgets/logo_widget.dart';

import '../product/providers/stock_book_provider/all_providers.dart';
import '../product/widgets/login_icon_button.dart';
import '../product/widgets/stock_book_list_widget.dart';

class SelectionPage extends ConsumerStatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectionPageState();
}

class _SelectionPageState extends ConsumerState<SelectionPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final BLLLoginPage _bllLoginPage = BLLLoginPage();
  bool isSelected = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectedStockBooks = ref.watch(selectedStockBooksProivder);
    return Scaffold(
      backgroundColor: AppColors.emerald,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.smallPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 6,
              child: Center(
                child: LogoWidget(),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: AppPadding.smallPadding.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _myStockBooks(context),
                        const Spacer(),
                        selectedStockBooks.isNotEmpty
                            ? Chip(backgroundColor: AppColors.white, label: Text("${selectedStockBooks.length}"))
                            : Container(),
                        LoginIconButtons(
                          icon: const Icon(Icons.add),
                          onPressed: selectedStockBooks.isEmpty
                              ? () {
                                  myAlertDialog(Selection.add);
                                }
                              : null,
                        ),
                        LoginIconButtons(
                          icon: const Icon(Icons.edit),
                          onPressed: selectedStockBooks.length == 1
                              ? () {
                                  myAlertDialog(Selection.edit);
                                }
                              : null,
                        ),
                        LoginIconButtons(
                          icon: const Icon(Icons.delete),
                          onPressed: selectedStockBooks.isNotEmpty
                              ? () {
                                  myAlertDialog(Selection.delete);
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const StockBookListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  myAlertDialog(Selection selection) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: selection == Selection.delete
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: AppPadding.mediumPadding),
                          child: Icon(
                            Icons.warning,
                            color: AppColors.superNova,
                            size: 48.h,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            LanguageItems.cannotBeChanged,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  )
                : null,
            content: selection == Selection.delete
                ? const Text(LanguageItems.shouldDeleteStockBook)
                : TextField(
                    decoration: const InputDecoration(hintText: "Yeni Stok Defteri Ad??"),
                    controller: _textEditingController,
                  ),
            actions: [
              TextButton(
                onPressed: () {
                  if (selection == Selection.edit) {
                    _bllLoginPage.editSelectedStockBook(ref, context, _textEditingController);
                  } else if (selection == Selection.delete) {
                    _bllLoginPage.deleteSelectedStockBooks(ref, context, _textEditingController);
                  } else {
                    _bllLoginPage.addStockBook(ref, context, _textEditingController);
                  }
                },
                child: const Text(LanguageItems.yesMessage),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(LanguageItems.noMessage)),
            ],
          );
        });
  }

  Text _myStockBooks(BuildContext context) {
    return Text(
      LanguageItems.myStockBooks,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: AppSize.mediumSize.sp,
            color: AppColors.white,
            fontWeight: AppFont.semiBold,
          ),
    );
  }
}

enum Selection { add, edit, delete }
