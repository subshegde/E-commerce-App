import 'package:dio/dio.dart';
import 'package:ecom_app/ecom/core/constants/url/app_apiUrl.dart';
import '../../core/network/dio_client.dart';

// The abstract class defines the contract for fetching products from an API
abstract class ProductApiService {
  // Fetches a list of products
  // Returns a response from the API (Dio Response)
  Future<Response> fetchProducts();
}

// The implementation of ProductApiService using Dio client to make API requests
class ProductApiServiceImpl implements ProductApiService {
  // DioClient instance for making HTTP requests
  final DioClient dioClient;

  // Constructor to inject DioClient instance
  ProductApiServiceImpl(this.dioClient);

  @override
  Future<Response> fetchProducts() async {
    // Constructs the API URL for fetching products
    // Calls the ApiUrl.productsUrl to get the correct endpoint
    return await dioClient.get(ApiUrl.productsUrl);
  }
}
