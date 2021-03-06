

import 'package:flutter/material.dart';
import 'package:stock_app/pages/main_page.dart';
import 'package:stock_app/pages/selection_page.dart';

class AppRoutes {
  static Route<dynamic>? routesGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SelectionPage(), settings: settings);

      case '/home':
        return MaterialPageRoute(builder: (context) => const MainPage(), settings: settings);
      default:
    }
  }
}
