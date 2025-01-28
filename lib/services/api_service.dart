import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/cart.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    // TODO: Fetch products from $_baseUrl/products
    //  Parse JSON response into List<Product>
    //  Handle errors (e.g., non-200 status codes)
    // https://fakestoreapi.com/docs for reference

    throw UnimplementedError();
  }
}
