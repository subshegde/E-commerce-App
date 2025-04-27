import 'package:ecom_app/ecom/data/repositories/product_repo_impl.dart';
import 'package:ecom_app/ecom/data/sources/product_remote_datasource.dart';
import 'package:ecom_app/ecom/domain/repositories/product_repo.dart';
import 'package:ecom_app/ecom/domain/usecases/get_product_usecase.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/product_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/wishlist_provider.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';

final sl = GetIt.instance;

Future setUpServiceLocator() async{
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<ProductApiService>(ProductApiServiceImpl(sl()));
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl(sl()));

  sl.registerSingleton<GetProductsUseCase>(GetProductsUseCase(sl()));

  sl.registerFactory<ProductProvider>(() => ProductProvider(sl()));
  sl.registerFactory<CartProvider>(() => CartProvider());
  sl.registerFactory<WishlistProvider>(() => WishlistProvider());

}
