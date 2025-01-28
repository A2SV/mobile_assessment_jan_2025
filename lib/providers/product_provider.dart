import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _searchQuery = '';

  List<Product> get products => _products;
  List<Product> get filteredProducts =>
      _searchQuery.isEmpty ? _products : _filteredProducts;

  void setProducts(List<Product> products) {
    _products = products;
    _applySearch();
    notifyListeners();
  }

  void searchProducts(String query) {
    _searchQuery = query.toLowerCase();
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products.where((product) {
        final title = product.title.toLowerCase();
        final description = product.description.toLowerCase();
        final category = product.category.toLowerCase();
        return title.contains(_searchQuery) ||
            description.contains(_searchQuery) ||
            category.contains(_searchQuery);
      }).toList();
    }
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredProducts = _products;
    notifyListeners();
  }
}
