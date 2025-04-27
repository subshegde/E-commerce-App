import 'package:ecom_app/ecom/presentation/pages/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String home = '/home';
  static const String cart = '/cart';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomePageMain(),
    };
  }
}
