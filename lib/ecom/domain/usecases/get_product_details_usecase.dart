import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/domain/entities/product_details_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/product_details_repo.dart';
import 'package:ecom_app/ecom/core/usecase/base_use_case.dart';

/// Use case class to fetch product details by product ID
class GetProductDetailsUseCase implements ProductDetailsUseCase<ProductDetailsEntity> {
  final ProductDetailsRepository repository; // Repository to fetch product details

  // Constructor to initialize the repository
  GetProductDetailsUseCase(this.repository);

  @override
  // Executes the use case: returns either a Failure or ProductDetailsEntity
  Future<Either<Failure, ProductDetailsEntity>> call(String id) {
    return repository.getProductDetails(id);
  }
}
