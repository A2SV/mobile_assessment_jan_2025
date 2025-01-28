import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Cart _cart = Cart();
  final List<Product> _favorites = [];

  Cart get cart => _cart;

  List<Product> get favorites => _favorites;

  double get totalPrice {
    return _cart.items
        .fold(0.0, (sum, item) => sum + item.product.price * item.quantity);
  }

  void addToCart(Product product, {int quantity = 1}) {
    final existingItem = _cart.items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );

    if (existingItem.product.id != -1) {
      existingItem.quantity += quantity;
    } else {
      _cart.items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cart.items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int newQuantity) {
    final item = _cart.items.firstWhere((item) => item.product.id == productId,
        orElse: () => CartItem(product: Product.empty(), quantity: 0));
    if (item.product.id != -1) {
      if (newQuantity <= 0) {
        removeFromCart(productId);
      } else {
        item.quantity = newQuantity;
        notifyListeners();
      }
    }
  }

  void clearCart() {
    _cart.items.clear();
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    if (_favorites.any((p) => p.id == product.id)) {
      _favorites.removeWhere((p) => p.id == product.id);
      product.isFavorite = false;
    } else {
      _favorites.add(product);
      product.isFavorite = true;
    }
    notifyListeners();
  }

  List<Product> getFavoriteProducts() {
    return _favorites;
  }
}
