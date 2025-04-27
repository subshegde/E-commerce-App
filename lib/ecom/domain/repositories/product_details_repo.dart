import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/domain/entities/product_details_entity.dart';

// Defines the contract for fetching product details
abstract class ProductDetailsRepository {
  // Fetch product details by providing a product ID
  // Returns either a Failure (in case of error) or ProductDetailsEntity (on success)
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(String id);
}
