import 'package:dio/dio.dart';
import 'package:ecom_app/ecom/core/network/dio_client.dart';
import 'package:ecom_app/ecom/core/constants/url/app_apiUrl.dart';

abstract class ProductDetailsApiService {
  Future<Response> fetchProductDetails(String id);
}

class ProductDetailsApiServiceImpl implements ProductDetailsApiService {
  final DioClient dioClient;

  ProductDetailsApiServiceImpl(this.dioClient);

  @override
  Future<Response> fetchProductDetails(String id) async {
    final url = ApiUrl.productDetailsUrl(id);
    return await dioClient.get(url);
  }
}
