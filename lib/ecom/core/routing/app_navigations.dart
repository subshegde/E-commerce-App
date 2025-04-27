import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<T?> push<T extends Object?>(Route<T> route) {
    return navigatorKey.currentState!.push(route);
  }

  static Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(routeName, arguments: arguments, result: result);
  }

  static void popUntil(bool Function(Route<dynamic>) predicate) {
    return navigatorKey.currentState!.popUntil(predicate);
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }
}
