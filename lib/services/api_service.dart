import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/cart.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));

    if (response.statusCode != 200) {
      throw 'Failed to load products (Status ${response.statusCode})';
    }

    try {
      return List<Product>.from(
          (jsonDecode(response.body) as List).map((p) => Product.fromMap(p)));
    } catch (e) {
      throw 'Failed to parse products';
    }
  }
}
