import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mobile_assessment_jan_2025/services/api_call_service.dart';
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';
  static const String _products = '/products';

  Future<List<Product>> fetchProducts() async {
    try {
      String url = '$_baseUrl$_products';
      var response = await ApiCallService.getCall(url, needToken: false);
      var body = jsonDecode(response.body);
      if (statusCodeSuccess(response.statusCode)) {
        // success
        return Product.listProvider(body);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error2938: $e');
      }
      return <Product>[];
    }

    throw UnimplementedError();
  }
}
