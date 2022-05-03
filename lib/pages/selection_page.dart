import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_app/core/constants/color_constants.dart';
import 'package:stock_app/core/constants/font_constants.dart';
import 'package:stock_app/core/constants/padding_constants.dart';
import 'package:stock_app/core/constants/size_constants.dart';
import 'package:stock_app/product/language/language_items.dart';
import 'package:stock_app/product/widgets/logo_widget.dart';

import '../product/widgets/stock_book_list_widget.dart';

class SelectionPage extends ConsumerStatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectionPageState();
}

class _SelectionPageState extends ConsumerState<SelectionPage> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: _myStockBooks(context),
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




/* Container(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: isSelected ? Colors.transparent : null,
                      ),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(Colors.red.withOpacity(0.8), BlendMode.hardLight),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            selected: isSelected,
                            enabled: true,
                            onLongPress: isSelected
                                ? null
                                : () {
                                    setState(() {
                                      HapticFeedback.vibrate();
                                      isSelected = true;
                                      print(isSelected);
                                    });
                                  },
                            onTap: isSelected
                                ? () {
                                    setState(() {
                                      isSelected = false;
                                      print(isSelected);
                                    });
                                  }
                                : null,
                            title: const Text("Stok Defterim"),
                            subtitle: const Text("Oluşturma tarihi - 22.01.2022"),
                            leading: const Icon(Icons.book),
                            trailing: const Icon(Icons.chevron_right_outlined, size: AppSize.largeSize),
                          ),
                        ),
                      ),
                    ),
                  ) */