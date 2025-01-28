 import 'package:mobile_assessment_jan_2025/core/handlers/api_result.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';

abstract class ApiService {
  Future<ApiResult<List<Product>>> fetchProducts();
}