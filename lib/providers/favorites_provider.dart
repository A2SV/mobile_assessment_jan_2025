import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => _favoriteProducts;

  // Add a product to favorites
  void addToFavorites(Product product) {
    if (!_favoriteProducts.any((item) => item.id == product.id)) {
      _favoriteProducts.add(product);
      notifyListeners();
    }
  }

  // Remove a product from favorites
  void removeFromFavorites(int productId) {
    _favoriteProducts.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  // Check if a product is in the favorites list
  bool isFavorite(int productId) {
    return _favoriteProducts.any((item) => item.id == productId);
  }

  // Clear all favorite products
  void clearFavorites() {
    _favoriteProducts.clear();
    notifyListeners();
  }
}
