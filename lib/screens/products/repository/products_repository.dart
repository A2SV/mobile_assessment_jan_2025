import 'package:dio/dio.dart';

import '../../../helpers/error_hander.dart';
import '../../../services/get_service.dart';
import '../model/product_model.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProducts();
}

class ProductsRepositoryImpl implements ProductsRepository {
  @override
  Future<List<Product>> getProducts() async {
    try {
      final response =
          await getIt<Dio>(instanceName: "fakeStoreApi").get("/products");

      final List<dynamic> result = response.data;

      if (response.statusCode == 200) {
        List<Product> products =
            result.map((json) => Product.fromJson(json)).toList();

        return products;
      } else {
        throw ErrorHandler(errorMessage: "Error fetching products");
      }
    } on DioException catch (e) {
      throw ErrorHandler(errorMessage: e.message ?? "Error fetching products");
    } on ErrorHandler catch (e) {
      throw ErrorHandler(errorMessage: e.errorMessage);
    } catch (e) {
      throw ErrorHandler(errorMessage: "Error fetching products");
    }
  }
}
