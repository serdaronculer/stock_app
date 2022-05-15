import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/constants.dart';
import '../../pages/table_page.dart';

class RadioSelectionWidget extends ConsumerWidget {
  const RadioSelectionWidget(
      {Key? key,
      required this.materialColor,
      required this.stockProcessStatus,
      required this.onChanged,
      required this.add,
      required this.remove})
      : super(key: key);
  final MaterialColor materialColor;
  final StockProcessStatus stockProcessStatus;
  final Function(StockProcessStatus? value) onChanged;
  final String add;
  final String remove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.smallPadding, horizontal: AppPadding.mediumPadding),
            color: materialColor[100],
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: AppPadding.largePadding),
                  child: Text(
                    add,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp, color: materialColor[900]),
                  ),
                ),
                Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: AppColors.monteCarloMaterial[100],
                  child: RadioListTile<StockProcessStatus>(
                    value: StockProcessStatus.add,
                    groupValue: stockProcessStatus,
                    onChanged: onChanged,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.smallPadding, horizontal: AppPadding.mediumPadding),
            color: AppColors.monteCarloMaterial[100],
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: AppPadding.largePadding),
                  child: Text(
                    remove,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp, color: AppColors.monteCarloMaterial[900]),
                  ),
                ),
                Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.monteCarloMaterial[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RadioListTile<StockProcessStatus>(
                    value: StockProcessStatus.remove,
                    groupValue: stockProcessStatus,
                    onChanged: onChanged,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
