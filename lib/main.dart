import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:stock_app/core/constants/color_constants.dart';
import 'package:stock_app/core/themes/themes.dart';

import 'Routes/routes.dart';
import 'data/hive/hive_setup.dart';
import 'pages/selection_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SetupHive.setupHive();
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
      ),
    );
  }
}
