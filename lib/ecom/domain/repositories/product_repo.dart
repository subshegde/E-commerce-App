import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
// Defines the contract for fetching a list of products
abstract class ProductRepository {
  // Fetches a list of products
  // Returns either a Failure (in case of error) or a list of ProductEntity objects (on success)
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
