import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_assessment_jan_2025/core/handlers/api_result.dart';
import 'package:mobile_assessment_jan_2025/core/handlers/app_connectivity.dart';
import 'package:mobile_assessment_jan_2025/models/rating.dart';
import '../models/product.dart';
import '../models/cart.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../core/handlers/network_exceptions.dart';
import '../core/handlers/http_service.dart';

class ApiService {
  final HttpService httpService;
  static const String _baseUrl = 'https://fakestoreapi.com';

  ApiService({required this.httpService});

  Future<ApiResult<List<Product>>> fetchProducts() async {
    try {
      final hasInternet = await _checkInternetConnection();
      if (!hasInternet) {
        return ApiResult.failure(
          error: const NetworkExceptions.noInternetConnection()
        );
      }

      final client = httpService.client();
      final response = await client.get('/products');
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        
        final products = jsonData.map((json) => Product(
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

        return ApiResult.success(data: products);
      } else {
        return ApiResult.failure(
          error: NetworkExceptions.defaultError(
            'Failed to load products. Status code: ${response.statusCode}'
          )
        );
      }
    } catch (e) {
      if (e is DioException) {
        return ApiResult.failure(error: NetworkExceptions.getDioException(e));
      }
      return _loadMockData();
    }
  }

  Future<ApiResult<List<Product>>> _loadMockData() async {
    try {
      final String mockData = await rootBundle.loadString('assets/mockdata.json');
      final List<dynamic> jsonData = json.decode(mockData);
      
      final products = jsonData.map((json) => Product(
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

      return ApiResult.success(data: products);
    } catch (e) {
      return ApiResult.failure(
        error: const NetworkExceptions.unableToProcess()
      );
    }
  }

  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
