import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_assessment_jan_2025/screens/cart/bloc/cart_bloc.dart';
import 'package:mobile_assessment_jan_2025/screens/products/bloc/products_bloc.dart';
import 'package:mobile_assessment_jan_2025/screens/products/repository/products_repository.dart';

GetIt getIt = GetIt.instance;

registerDependencies() {
  registerConfigurations();
  registerProducts();
  registerCart();
}

registerConfigurations() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerSingleton(
      instanceName: "fakeStoreApi",
      Dio(
        BaseOptions(
            baseUrl: 'https://fakestoreapi.com',
            connectTimeout: const Duration(minutes: 5),
            receiveTimeout: const Duration(minutes: 5),
            sendTimeout: const Duration(minutes: 5)),
      )..interceptors.add(CustomDioInterceptor()));
}

registerProducts() {
  getIt
    ..registerFactory<ProductsRepository>(() => ProductsRepositoryImpl())
    ..registerFactory(() => ProductsBloc(productsRepository: getIt()));
}

registerCart() {
  getIt.registerFactory(() => CartBloc());
}

class CustomDioInterceptor extends Interceptor {
  CustomDioInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("Request sent: ${options.method} ${options.path}");

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("Response received: ${err.message} ${err.type} ");
    return super.onError(err, handler);
  }
}
