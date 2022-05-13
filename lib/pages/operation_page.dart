import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_app/product/model/stock_model.dart';
import 'package:stock_app/product/providers/category_provider/all_providers.dart';
import 'package:stock_app/product/widgets/dropdown_selection.dart';

import '../core/constants/constants.dart';
import '../product/providers/stock_book_provider/all_providers.dart';
import '../product/providers/stock_provider/all_providers.dart';
import '../product/widgets/custom_textfield.dart';

class OperationPage extends ConsumerStatefulWidget {
  const OperationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OperationPageState();
}

class _OperationPageState extends ConsumerState<OperationPage> with SingleTickerProviderStateMixin {
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

  StockProcessStatus girisCikis = StockProcessStatus.add;
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
            onTap: () => _showSheet(stockModel),
            child: const Icon(
              Icons.edit,
              color: AppColors.emerald,
            ),
          ),
          GestureDetector(
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

  void _showSheet(StockModel stockModel) {
    _stockNameController.text = stockModel.stockName;
    _stockQuantityController.text = stockModel.quantity.toString();
    var categories = ref.watch(categoriesProvider);
    var category = categories.firstWhere((element) => element.categoryName == stockModel.categoryName);
    ref.watch(setCategoryProvider.state).state = category.id;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.25,
          maxChildSize: 1,
          expand: false,
          builder: (_, controller) {
            return StatefulBuilder(
              builder: (context, setState) => Padding(
                padding: const EdgeInsets.all(AppPadding.mediumPadding),
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
                    Row(
                      children: [
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
                                    "Giriş",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14.sp, color: AppColors.monteCarloMaterial[900]),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  color: AppColors.monteCarloMaterial[100],
                                  child: RadioListTile<StockProcessStatus>(
                                      value: StockProcessStatus.add,
                                      groupValue: girisCikis,
                                      onChanged: (deger) {
                                        setState(() {});
                                        girisCikis = deger!;
                                      }),
                                ),
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
                                    "Çıkış",
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
                                      value: StockProcessStatus.out,
                                      groupValue: girisCikis,
                                      onChanged: (deger) {
                                        setState(() {});
                                        girisCikis = deger!;
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.mediumSize),
                    CustomTextField(
                      textController: _quantityController,
                      text: "Miktar",
                      hintText: "Miktar",
                      materialColor: AppColors.monteCarloMaterial,
                      isNumber: true,
                    ),
                    const SizedBox(height: AppSize.largeSize),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  var stockName = _stockNameController.text;
                                  int stockQuantity;
                                  var j = ref.watch(selectedCategoryProvider);

                                  var selectedCategory = ref.watch(categoriesProvider).firstWhere((element) => element.id == j);

                                  _quantityController.text.isEmpty ? _quantityController.text = "0" : _quantityController.text;
                                  if (girisCikis == StockProcessStatus.add) {
                                    stockQuantity = (stockModel.quantity + int.parse(_quantityController.text));
                                  } else {
                                    stockQuantity = (stockModel.quantity - int.parse(_quantityController.text));
                                  }
                                  ref.read(stocksProvider.notifier).addStock(stockModel.copyWith(
                                      stockName: stockName, quantity: stockQuantity, categoryName: selectedCategory.categoryName));
                                },
                                child: const Text("Onayla"))),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

enum StockProcessStatus { add, out }

/* 
  IconButton(
            onPressed: () => _showSheet(stockModel),
            icon: const Icon(
              Icons.remove,
              color: AppColors.emerald,
            ),
          ), */