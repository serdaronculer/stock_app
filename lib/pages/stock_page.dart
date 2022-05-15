import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_app/core/constants/constants.dart';
import 'package:stock_app/product/model/stock_model.dart';

import '../product/providers/stock_provider/all_providers.dart';

class StockPage extends ConsumerStatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StockPageState();
}

class _StockPageState extends ConsumerState<StockPage> with WidgetsBindingObserver {
  late FocusNode fieldFocusNode;

  @override
  void initState() {
    super.initState();
    fieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    fieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<StockModel> _stocks = ref.watch(stocksProvider);
    final AsyncValue<List<StockModel>> _filteredStocks = ref.watch(getFilteredStocksProvider);
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Stok"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.mediumPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => fieldFocusNode.requestFocus(),
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.mediumPadding),
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(50.sp),
                    border: Border.all(
                      color: AppColors.emerald,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        var _stocks = ref.watch(allStocksProvider);

                        ref.read(getFilteredStocksProvider.state).state = _stocks;
                      } else {
                        var filteredStocks = _filteredStocks
                            .whenData((filteredStocks) => filteredStocks.where((element) => element.stockName.startsWith(value)).toList());
                        ref.read(getFilteredStocksProvider.state).state = filteredStocks;
                      }
                    },
                    maxLines: 1,
                    focusNode: fieldFocusNode,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSize.mediumSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Stok Listesi", style: Theme.of(context).textTheme.headline4),
                    const Divider(
                      color: AppColors.emerald,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _filteredStocks.when(data: (data) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        StockModel _stock = data[index];
                        return Card(
                          child: ListTile(
                            title: Text(_stock.stockName),
                            subtitle: Text(_stock.categoryName),
                            trailing: const Icon(Icons.chevron_right_outlined),
                          ),
                        );
                      });
                }, error: (err, stackTrace) {
                  return Center(child: Text(err.toString()));
                }, loading: () {
                  return const CircularProgressIndicator();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
