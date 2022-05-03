import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:stock_app/core/constants/color_constants.dart';
import 'package:stock_app/core/themes/themes.dart';
import 'package:stock_app/product/model/stock_book_model.dart';

import 'pages/selection_page.dart';

Future<void> setupHive() async {
  await Hive.initFlutter("StockBookDatabase");
  Hive.registerAdapter(StockBookModelAdapter());

  var stockBookBox = await Hive.openBox<StockBookModel>("stockBooks");
  // await stockBookBox.add(StockBookModel(id: 45, bookName: "Test2", creationDate: DateTime.now()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 738),
      builder: (child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stock App',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.emerald,
          fontFamily: 'Mulish',
          primarySwatch: AppColors.mcgpalette0,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: MyTheme.statusBarTheme,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            foregroundColor: AppColors.black,
            centerTitle: false,
          ),
        ),
        home: const SelectionPage(),
      ),
    );
  }
}
