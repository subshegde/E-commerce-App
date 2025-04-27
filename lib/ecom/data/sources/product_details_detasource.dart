import 'package:dio/dio.dart';
import 'package:ecom_app/ecom/core/network/dio_client.dart';
import 'package:ecom_app/ecom/core/constants/url/app_apiUrl.dart';

// The abstract class defines the contract for fetching product details from an API
abstract class ProductDetailsApiService {
  // Fetches the details of a product given its ID
  // Returns a response from the API (Dio Response)
  Future<Response> fetchProductDetails(String id);
}

// The implementation of ProductDetailsApiService using Dio client to make API requests
class ProductDetailsApiServiceImpl implements ProductDetailsApiService {
  // DioClient instance for making HTTP requests
  final DioClient dioClient;

  // Constructor to inject DioClient instance
  ProductDetailsApiServiceImpl(this.dioClient);

  @override
  Future<Response> fetchProductDetails(String id) async {
    // Constructs the API URL using the product ID
    final url = ApiUrl.productDetailsUrl(id);
    
    // Makes a GET request to the API and returns the response
    return await dioClient.get(url);
  }
}
