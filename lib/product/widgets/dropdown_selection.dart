import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_app/core/constants/constants.dart';
import 'package:stock_app/product/language/language_items.dart';

import '../model/category_model.dart';
import '../providers/category_provider/all_providers.dart';

class DropDownSelectionWidget extends ConsumerStatefulWidget {
  const DropDownSelectionWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DropDownSelectionWidgetState();
}

class _DropDownSelectionWidgetState extends ConsumerState<DropDownSelectionWidget> {
  int selectedValue = 0;
  late TextEditingController addCategoryController;

  @override
  void initState() {
    super.initState();
    addCategoryController = TextEditingController();
  }

  @override
  void dispose() {
    addCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.smallPadding, horizontal: AppPadding.mediumPadding),
      decoration: BoxDecoration(
        color: AppColors.mcgpalette0[100],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.largePadding),
            child: Text(
              LanguageItems.category,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.mcgpalette0[900],
              ),
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            margin: const EdgeInsets.only(right: AppPadding.mediumPadding),
            child: IconButton(
              onPressed: () {
                _addCategoryShowDialog(context);
              },
              icon: const Icon(Icons.add),
              color: AppColors.mcgpalette0[900],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: DropdownButton<int>(
                icon: Icon(
                  Icons.sort,
                  color: AppColors.mcgpalette0[900],
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.mcgpalette0[900],
                ),
                underline: Container(),
                value: ref.watch(selectedCategoryProvider),
                items: myCategories(),
                onChanged: (value) {
                  ref.watch(setCategoryProvider.state).state = value!;
                }),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> myCategories() {
    List<DropdownMenuItem<int>> dropDownItems = [];
    ref.watch(getAllCategoryProvider).whenData((categories) {
      for (var item in categories) {
        var value = DropdownMenuItem<int>(child: Text(item.categoryName), value: item.id);
        dropDownItems.add(value);
      }
    });
    return dropDownItems;
  }

  Future<dynamic> _addCategoryShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Kategori Penceresi"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Eklemek istediğiniz kategoriyi giriniz"),
                TextField(
                  controller: addCategoryController,
                  maxLength: 25,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () {
                              ref.read(categoriesProvider.notifier).addCategory(
                                    CategoryModel.create(
                                      ref: ref,
                                      categoryName: addCategoryController.text,
                                    ),
                                  );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Onayla"))),
                  ],
                )
              ],
            ),
          );
        });
  }
}


/* DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          
          prefixIcon: Icon(Icons.sort),
          label: Text("Ürün Grubu"),
        ),
        value: "tumu",
        items: const [
          DropdownMenuItem<String>(
            child: Text("Tümü"),
            value: "tumu",
          ),
          DropdownMenuItem<String>(
            child: Text("Ekmek"),
            value: "ekmek",
          ),
          DropdownMenuItem<String>(
            child: Text("Yumurta"),
            value: "yumurta",
          ),
        ],
        onChanged: (deger) {}); */