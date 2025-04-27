import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/add_to_cart.dart';

class AddToCart {
  // Reference to the CartRepository to perform cart-related actions
  final CartRepository cartRepository;

  // Constructor to initialize the repository
  AddToCart(this.cartRepository);

  // Method to add a product to the cart
  // It takes a ProductEntity and calls the repository's addToCart method
  Future<void> execute(ProductEntity product) {
    return cartRepository.addToCart(product);
  }
}
