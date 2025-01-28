import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_assessment_jan_2025/models/rating.dart';
import '../models/product.dart';
import '../models/cart.dart';
import 'package:flutter/services.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        
        return jsonData.map((json) => Product(
          id: json['id'],
          title: json['title'],
          price: (json['price'] as num).toDouble(),
          description: json['description'],
          category: json['category'],
          image: json['image'],
          rating: Rating(
            rate: (json['rating']['rate'] as num).toDouble(),
            count: json['rating']['count'],
          ),
        )).toList();
      } else {
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // If there's a network error or JSON parsing error, try loading from mock data
      try {
        final String mockData = await rootBundle.loadString('assets/mockdata.json');
        final List<dynamic> jsonData = json.decode(mockData);
        
        return jsonData.map((json) => Product(
          id: json['id'],
          title: json['title'],
          price: (json['price'] as num).toDouble(),
          description: json['description'],
          category: json['category'],
          image: json['image'],
          rating: Rating(
            rate: (json['rating']['rate'] as num).toDouble(),
            count: json['rating']['count'],
          ),
        )).toList();
      } catch (mockError) {
        throw Exception('Failed to load products: $e\nFailed to load mock data: $mockError');
      }
    }
  }
}
