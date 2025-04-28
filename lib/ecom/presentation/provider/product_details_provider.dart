import 'package:ecom_app/ecom/domain/entities/product_details_entity.dart';
import 'package:ecom_app/ecom/domain/usecases/get_product_details_usecase.dart';
import 'package:flutter/material.dart';

class ProductDetailsProvider with ChangeNotifier {
  final GetProductDetailsUseCase _getProductDetailsUseCase;

  ProductDetailsProvider(this._getProductDetailsUseCase);

  ProductDetailsEntity? _productDetail;
  ProductDetailsEntity? get productDetail => _productDetail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchProductDetails(String id) async {
    _isLoading = true;
    _errorMessage = ''; // Clear any previous error
    notifyListeners();

    final result = await _getProductDetailsUseCase.call(id);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (productDetail) {
        _productDetail = productDetail;
        _isLoading = false;
        notifyListeners(); // notify changes
      },
    );
  }
}
