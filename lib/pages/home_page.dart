import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/product/model/category_model.dart';



import '../product/providers/category_provider/all_providers.dart';
import '../product/providers/stock_book_provider/all_providers.dart';
import '../product/widgets/dropdown_selection.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    var _allCategories = ref.watch(getAllCategoryProvider);

    return Column(
      children: [
        const DropDownSelectionWidget(isFiltered: true),
        Expanded(
          child: _allCategories.when(data: (allCategories) {
            List<CategoryModel> _allCategories =
                allCategories.where((element) => element.stockBookID == ref.watch(selectedStockBookProvider).id).toList();
            return ListView.builder(
                itemCount: _allCategories.length,
                itemBuilder: (context, index) {
                  CategoryModel categoryModel = _allCategories[index];
                  return ListTile(
                    title: Text(categoryModel.categoryName),
                    subtitle: Text(categoryModel.id.toString() + " " + categoryModel.stockBookID.toString()),
                  );
                });
          }, error: (err, stackTree) {
            return Center(child: Text(err.toString()));
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }),
        ),
   
      ],
    );
  }
}

