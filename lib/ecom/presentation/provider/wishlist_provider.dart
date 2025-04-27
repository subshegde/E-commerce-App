import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  final List<ProductEntity> _wishlistItems = [];

  List<ProductEntity> get wishlistItems => _wishlistItems;
  
  void removeFromWishlist(ProductEntity product) {
    _wishlistItems.remove(product);
    notifyListeners();
  }
  void addToWishlist(ProductEntity product) {
  if (!_wishlistItems.contains(product)) {
    _wishlistItems.add(product);
    notifyListeners();
  }
}

}
