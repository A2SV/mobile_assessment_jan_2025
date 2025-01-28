
import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Cart _cart = Cart();
  final List<Product> _favorites = [];

  Cart get cart => _cart;

  List<Product> get favorites => _favorites;

  void addToCart(Product product, {int quantity = 1}) {
    final existingItemIndex =
        _cart.items.indexWhere((item) => item.product.id == product.id);

    if (existingItemIndex != -1) {
      _cart.items[existingItemIndex].quantity += quantity;
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
    final existingItemIndex =
        _cart.items.indexWhere((item) => item.product.id == productId);

    if (existingItemIndex != -1) {
      if (newQuantity <= 0) {
        removeFromCart(productId);
      } else {
        _cart.items[existingItemIndex].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  double get totalPrice => _cart.items
      .fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  void clearCart() {
    _cart.items.clear();
    notifyListeners();
  }

  void addToFavorites(Product product) {
    if (!_favorites.contains(product)) {
      _favorites.add(product);
      notifyListeners();
    }
  }

  void removeFromFavorites(Product product) {
    _favorites.remove(product);
    notifyListeners();
  }
}
