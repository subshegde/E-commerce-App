import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/data/models/product_model.dart';
import 'package:ecom_app/ecom/data/sources/product_remote_datasource.dart';
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/product_repo.dart';

// Implementation of ProductRepository that fetches products from a remote API
class ProductRepositoryImpl implements ProductRepository {
  // Dependency: API service used to fetch products
  final ProductApiService apiService;

  // Constructor to initialize the API service
  ProductRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      // Call the API service to fetch the products
      final response = await apiService.fetchProducts();

      // Parse the response body
      final Map<String, dynamic> data = response.data;

      // Access the 'best_sellers' list inside the 'data' field
      final List<dynamic> productData = data['data']['best_sellers'];

      // Convert the list of JSON objects into a list of ProductEntity
      List<ProductEntity> products = productData.map((e) => ProductModel.fromJson(e)).toList();

      // If successful, return the list wrapped in Right
      return Right(products);
    } catch (e) {
      // If any error occurs, return a ServerFailure wrapped in Left
      return Left(ServerFailure(e.toString()));
    }
  }
}
