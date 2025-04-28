import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  // Getter to retrieve the current list of cart items
  List<CartItem> get cartItems => _cartItems;

  // Add a product to the cart or increase its quantity if already present
  void addToCart(ProductEntity product) {
    // Check if the product is already in the cart
    final existingProductIndex =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (existingProductIndex == -1) {
      // If not found, add a new cart item
      _cartItems.add(CartItem(product: product));
    } else {
      // If found, increase the quantity of the existing cart item
      _cartItems[existingProductIndex] =
          _cartItems[existingProductIndex].copyWith(
        quantity: _cartItems[existingProductIndex].quantity + 1,
      );
    }
    // Notify listeners that the state has changed
    notifyListeners();
  }

  // Remove a product from the cart
  void removeFromCart(ProductEntity product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    // Notify listeners about the state change
    notifyListeners();
  }

  // Increase the quantity of a product in the cart
  void increaseQuantity(ProductEntity product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      // Update the quantity of the item if it exists in the cart
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );
      // Notify listeners about the state change
      notifyListeners();
    }
  }

  // Decrease the quantity of a product in the cart
  void decreaseQuantity(ProductEntity product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1 && _cartItems[index].quantity > 1) {
      // Prevent quantity from going below 1
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity - 1,
      );
      // Notify listeners about the state change
      notifyListeners();
    }
  }

  // Calculate the total price of all items in the cart
  double get totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // Get the count of unique products in the cart (no duplicates)
  int get uniqueProductCount {
    Set<String> uniqueProductIds = {};

    for (var item in _cartItems) {
      uniqueProductIds.add(item.product.id);
    }
    return uniqueProductIds.length;
  }

  // Format the price according to the Indian currency format (₹)
  String formatPrice(double price) {
    final formatter = NumberFormat("#,##,##0.00", "en_IN");
    return '₹${formatter.format(price)}';
  }

  String get formattedTotalPrice => formatPrice(totalPrice);
}
