import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  // list to store the wishlists
  final List<ProductEntity> _wishlistItems = [];

  List<ProductEntity> get wishlistItems => _wishlistItems;
  
  // to remove from wishlist
  void removeFromWishlist(ProductEntity product) {
    _wishlistItems.remove(product);
    notifyListeners(); // notify the changes to ui
  }

  // to add the product to wishlist
  void addToWishlist(ProductEntity product) {
  if (!_wishlistItems.contains(product)) {
    _wishlistItems.add(product);
    notifyListeners(); // notify the changes to ui
  }
}

}
