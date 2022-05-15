import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_app/core/constants/constants.dart';

import 'package:stock_app/core/themes/themes.dart';
import 'package:stock_app/data/hive/hive_local_storage_category.dart';
import 'package:stock_app/data/hive/hive_local_storage_stock.dart';
import 'package:stock_app/data/hive/hive_local_storage_stock_book.dart';

import 'Routes/routes.dart';

import 'data/abstract_local_storage.dart';
import 'data/hive/hive_setup.dart';

final locator = GetIt.instance;

void getItSetup() {
  locator.registerSingleton<LocalStorageStockBook>(HiveLocalStorageStockBook());
  locator.registerSingleton<LocalStorageStock>(HiveLocalStorageStock());
  locator.registerSingleton<LocalStorageCategory>(HiveLocalStorageCategory());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SetupHive.setupHive();

  getItSetup();

  runApp(const ProviderScope(child: MyApp()));
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
        onGenerateRoute: AppRoutes.routesGenerator,
        theme: ThemeData(
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
