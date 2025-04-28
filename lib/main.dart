import 'package:ecom_app/ecom/core/routing/app_navigations.dart';
import 'package:ecom_app/ecom/core/routing/app_routes.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/nav_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/product_details_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/product_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/wishlist_provider.dart';
import 'package:ecom_app/ecom/service_locator.dart';
import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';

void main() async {
  // Initialize service locator for dependency injection
  await setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a MultiProvider that provides multiple change notifiers to the app
    return MultiProvider(
      providers: [
        // Provide ProductProvider to manage product-related state
        ChangeNotifierProvider(create: (_) => sl<ProductProvider>()),
        // to manage cart-related state
        ChangeNotifierProvider(create: (_) => sl<CartProvider>()),
        // to manage wishlist-related state
        ChangeNotifierProvider(create: (_) => sl<WishlistProvider>()),
        // to manage navigation state
        ChangeNotifierProvider(create: (_) => NavProvider()),
        // to manage product details state
        ChangeNotifierProvider(create: (_) => sl<ProductDetailsProvider>())
      ],
      child: MaterialApp(
        // Used custom navigator key for routing control
        navigatorKey: AppNavigator.navigatorKey,
        // Defining the routes available in the app
        routes: AppRouter.getRoutes(),
        // Setting the initial route when the app starts
        initialRoute: AppRouter.home,
        debugShowCheckedModeBanner: false,
        title: 'ECOM',
      ),
    );
  }
}
