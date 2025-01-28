import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/cart.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  // Future<List<Product>> fetchProducts() async {
  //   // TODO: Fetch products from $_baseUrl/products
  //   //  Parse JSON response into List<Product>
  //   //  Handle errors (e.g., non-200 status codes)
  //   // https://fakestoreapi.com/docs for reference
  //   final response = await http.get(Uri.parse('$_baseUrl/products'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     return data.map((json) => Product.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/products'))
          .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> data = json.decode(response.body);

        // Validate JSON structure before converting to Product list
        if (data is List) {
          return data.map((json) => Product.fromJson(json)).toList();
        } else {
          throw FormatException("Unexpected JSON format: Expected a list");
        }
      } else {
        // Handle non-200 status codes
        throw HttpException(
            "Failed to load products. Status Code: ${response.statusCode}");
      }
    } on FormatException catch (e) {
      // Handle JSON parsing errors
      throw Exception("Data parsing error: ${e.message}");
    } on http.ClientException {
      // Handle HTTP client-specific exceptions
      throw Exception("Network error: Unable to connect to server");
    } on TimeoutException {
      // Handle request timeout
      throw Exception("Request timed out. Please try again later.");
    } catch (e) {
      // Handle any other types of exceptions
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
