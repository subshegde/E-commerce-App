import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/data/models/product_details_model.dart';
import 'package:ecom_app/ecom/data/sources/product_details_detasource.dart';
import 'package:ecom_app/ecom/domain/entities/product_details_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/product_details_repo.dart';

// Implementation of ProductDetailsRepository which fetches product details from a remote API
class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  // Dependency: API service used to fetch product details
  final ProductDetailsApiService apiService;

  // Constructor to initialize the API service
  ProductDetailsRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(String id) async {
    try {
      // Call the API service to fetch product details by product ID
      final response = await apiService.fetchProductDetails(id);

      // Parse the response body into a Map
      final Map<String, dynamic> data = response.data;

      // Access the actual product details inside the 'data' field
      final Map<String, dynamic> productData = data['data']; 

      // Check if product data is not empty
      if (productData.isNotEmpty) {
        // If data exists, convert it to a ProductDetailsEntity object
        ProductDetailsEntity productDetail = ProductDetailsModel.fromJson(productData);
        
        // Return the product detail wrapped in Right
        return Right(productDetail);
      } else {
        // If no data found, return a ServerFailure inside Left
        return Left(ServerFailure("No product details found"));
      }
    } catch (e) {
      // If any error occurs, catch it and return a ServerFailure inside Left
      return Left(ServerFailure(e.toString()));
    }
  }
}
