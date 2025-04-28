import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/core/usecase/base_use_case.dart';
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/product_repo.dart';

class GetProductsUseCase implements UseCase {
  // Repository instance used to fetch products
  final ProductRepository repository;

  // Constructor to initialize the repository
  GetProductsUseCase(this.repository);

  @override
  // Fetches a list of products using the repository
  // Returns either a Failure (error) or a List of ProductEntity (success)
  Future<Either<Failure, List<ProductEntity>>> call() {
    return repository.getProducts();
  }
}
