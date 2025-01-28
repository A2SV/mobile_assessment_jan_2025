import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/models/favorite.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';

class FavoriteProvider extends ChangeNotifier {
  final Favorite _favorite = Favorite();
  Favorite get favorite => _favorite;

  void addToFavorite(Product product) {
    final existingItem = _favorite.items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => FavoriteItem(product: Product.empty()),
    );

    _favorite.items.add(FavoriteItem(product: product));

    notifyListeners();
  }

  void removeFromFavorite(int productId) {
    _favorite.items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _favorite.items.clear();
    notifyListeners();
  }
}
