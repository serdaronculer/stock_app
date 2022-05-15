import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_app/business_layer/table_page_layer.dart';
import 'package:stock_app/product/model/stock_model.dart';
import 'package:stock_app/product/providers/category_provider/all_providers.dart';
import 'package:stock_app/product/widgets/dropdown_selection.dart';

import '../core/constants/constants.dart';
import '../product/language/language_items.dart';
import '../product/providers/stock_book_provider/all_providers.dart';
import '../product/providers/stock_provider/all_providers.dart';
import '../product/widgets/custom_textfield.dart';
import '../product/widgets/radio_selection.dart';

class TablePage extends ConsumerStatefulWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TablePagePageState();
}

class _TablePagePageState extends ConsumerState<TablePage> with SingleTickerProviderStateMixin {
  BLLTablePage bllOperationPage = BLLTablePage();
  late TabController _tabController;
  late TextEditingController _stockNameController;
  late TextEditingController _stockQuantityController;
  late TextEditingController _quantityController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _stockNameController = TextEditingController();
    _stockQuantityController = TextEditingController();
    _quantityController = TextEditingController();
    _quantityController.text = "0";
  }

  StockProcessStatus addRemove = StockProcessStatus.add;
  @override
  Widget build(BuildContext context) {
    var _allStocks = ref.watch(allStocksProvider);
    return _allStocks.when(data: (allStocks) {
      var selectedStockBook = ref.watch(selectedStockBookProvider);
      var stocks = allStocks.where((element) => element.stockBookID == selectedStockBook.id).toList();
      return Padding(
        padding: const EdgeInsets.all(AppPadding.smallPadding),
        child: stocks.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: getColumns(),
                    rows: getRows(stocks, context),
                  ),
                ),
              )
            : const Center(
                child: Text("Herhangi bir stok bulunamadı"),
              ),
      );
    }, error: (err, stackTrace) {
      return const Center(
        child: Text("Veri getirilirken hata oluştu..."),
      );
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }

  List<DataColumn> getColumns() {
    final columns = ["Stok", "Kategori", "Adet", "İşlem"];
    return columns.map((e) => DataColumn(label: Text(e))).toList();
  }

  List<DataRow> getRows(List<StockModel> stockModelList, BuildContext context) {
    return stockModelList.map((StockModel stockModel) {
      final widget = Row(
        children: [
          GestureDetector(
            onTap: () => _showEditSheet(stockModel),
            child: const Icon(
              Icons.edit,
              color: AppColors.emerald,
            ),
          ),
          GestureDetector(
            onTap: () => myDeleteAlertDialog(stockModel),
            child: const Icon(
              Icons.delete,
              color: AppColors.red,
            ),
          ),
        ],
      );
      final cells = [stockModel.stockName, stockModel.categoryName, stockModel.quantity, widget];

      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) {
    return cells
        .map((data) => data.runtimeType == String || data.runtimeType == int
            ? DataCell(Text("$data"))
            : DataCell(Container(
                child: data,
              )))
        .toList();
  }

  myDeleteAlertDialog(StockModel stockModel) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
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
                  ),
                ],
              ),
            ),
            content: const Text(LanguageItems.shouldDeleteStock),
            actions: [
              TextButton(
                onPressed: () {
                  ref.watch(stocksProvider.notifier).deleteStock(stockModel);
                  Navigator.of(context).pop();
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

  void _showEditSheet(StockModel stockModel) {
    _stockNameController.text = stockModel.stockName;
    _stockQuantityController.text = stockModel.quantity.toString();
    var categories = ref.watch(categoriesProvider);
    var category = categories.firstWhere((element) => element.categoryName == stockModel.categoryName);
    ref.watch(setCategoryProvider.state).state = category.id;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0.r),
                    topRight: Radius.circular(25.0.r),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.largePadding,
                      horizontal: AppPadding.largePadding,
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: "Stok adı",
                            materialColor: AppColors.superNovaMaterial,
                            text: "Stok adı",
                            isNumber: false,
                            textController: _stockNameController,
                          ),
                          const SizedBox(height: AppSize.mediumSize),
                          CustomTextField(
                            textController: _stockQuantityController,
                            text: "Stok adedi",
                            hintText: "Stok adedi",
                            materialColor: AppColors.monteCarloMaterial,
                            isNumber: true,
                          ),
                          const SizedBox(height: AppSize.mediumSize),
                          const DropDownSelectionWidget(),
                          const SizedBox(height: AppSize.mediumSize),
                          RadioSelectionWidget(
                            add: LanguageItems.add,
                            remove: LanguageItems.remove,
                            materialColor: AppColors.monteCarloMaterial,
                            stockProcessStatus: addRemove,
                            onChanged: (value) {
                              setState(() {});
                              addRemove = value!;
                            },
                          ),
                          const SizedBox(height: AppSize.mediumSize),
                          Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: CustomTextField(
                              textController: _quantityController,
                              text: "Miktar",
                              hintText: "Miktar",
                              materialColor: AppColors.monteCarloMaterial,
                              isNumber: true,
                            ),
                          ),
                          const SizedBox(height: AppSize.largeSize),
                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        bllOperationPage.editStock(_stockNameController, _quantityController, ref, addRemove, stockModel);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Onayla"))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum StockProcessStatus { add, remove }
