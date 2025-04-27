import 'package:ecom_app/ecom/core/routing/app_navigations.dart';
import 'package:ecom_app/ecom/core/routing/app_routes.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/nav_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/product_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/wishlist_provider.dart';
import 'package:ecom_app/ecom/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  await setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<ProductProvider>()),
        ChangeNotifierProvider(create: (_) => sl<CartProvider>()),
        ChangeNotifierProvider(create: (_) => sl<WishlistProvider>()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
      ],
      child: MaterialApp(
        navigatorKey: AppNavigator.navigatorKey,
        routes: AppRouter.getRoutes(),
        initialRoute: AppRouter.home,
        debugShowCheckedModeBanner: false,
        title: 'ECOM',
      ),
    );
  }
}
