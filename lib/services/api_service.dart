import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';
  final http.Client client;

  ApiService._singleton(this.client);
  static final ApiService instance = ApiService._singleton(http.Client());

  Future<List<Product>> fetchProducts() async {
    try {
      print('Fetching products from $_baseUrl/products');
      http.Response response = await client.get(
        Uri.parse('$_baseUrl/products'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('Received response: ${response.statusCode}');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Product> products = data.map((e) => Product.fromJson(e)).toList();
        return products;
      } else {
        throw HttpException('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }
}
