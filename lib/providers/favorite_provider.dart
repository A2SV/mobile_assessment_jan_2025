import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _product = [];
  List<Product> get product => _product;

  void addToFavorite(Product product) {
    if (_product.contains(product) == false) {
      _product.add(product);
    }
    notifyListeners();
  }

  void removeFromFavorite(Product product) {
    if (_product.contains(product)) {
      _product.remove(product);
    }
    notifyListeners();
  }
}
