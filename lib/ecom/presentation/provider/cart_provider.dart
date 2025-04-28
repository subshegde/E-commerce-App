import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(ProductEntity product) {
    final existingProductIndex =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (existingProductIndex == -1) {
      _cartItems.add(CartItem(product: product));
    } else {
      _cartItems[existingProductIndex] =
          _cartItems[existingProductIndex].copyWith(
        quantity: _cartItems[existingProductIndex].quantity + 1,
      );
    }
    notifyListeners();
  }

  void removeFromCart(ProductEntity product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void increaseQuantity(ProductEntity product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );
      notifyListeners();
    }
  }

  void decreaseQuantity(ProductEntity product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1 && _cartItems[index].quantity > 1) {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity - 1,
      );
      notifyListeners();
    }
  }

  double get totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  int get uniqueProductCount {
    // Using a Set to store unique product IDs
    Set<String> uniqueProductIds = {};

    for (var item in _cartItems) {
      uniqueProductIds.add(item.product.id);
    }
    return uniqueProductIds.length;
  }

  String formatPrice(double price) {
    final formatter = NumberFormat("#,##,##0.00", "en_IN");
    return '₹${formatter.format(price)}';
  }
  String get formattedTotalPrice => formatPrice(totalPrice);
}
