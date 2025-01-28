import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/cart.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  // Future<List<Product>> fetchProducts() async {
  //   List<Product> product = [];
  //   // TODO: Fetch products from $_baseUrl/products
  //   //  Parse JSON response into List<Product>
  //   //  Handle errors (e.g., non-200 status codes)
  //   // https://fakestoreapi.com/docs for reference
  //   final result = http.get(Uri.parse('https://fakestoreapi.com/products'));
  //   return throw UnimplementedError();
  // }
  Future<List<Product>> fetchProducts() async {
    List<Product> products = [];

    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        // Parse the JSON response into a list of Product objects
        List<dynamic> jsonData = json.decode(response.body);
        products =
            jsonData.map((product) => Product.fromJson(product)).toList();
        print(products);
      } else {
        throw Exception(
            'Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }

    return products;
  }
}
