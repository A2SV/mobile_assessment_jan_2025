import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    const String url = 'https://fakestoreapi.com/products';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON response into a list of products
        final List<dynamic> productJsonList = jsonDecode(response.body);

        // Map the JSON objects to Product instances
        return productJsonList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }
}
