import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Cart _cart = Cart();

  Cart get cart => _cart;

  void addToCart(Product product, {int quantity = 1}) {
    // Provided as a hint
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
    final itemToRemove = _cart.items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );

    if (itemToRemove.product.id != -1) {
      _cart.items.remove(itemToRemove);
    }

    notifyListeners();
  }

  void updateQuantity(int productId, int newQuantity) {
    final itemToUpdate = _cart.items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );

    if (itemToUpdate.product.id != -1) {
      itemToUpdate.quantity = newQuantity;

      if (newQuantity <= 0) {
        _cart.items.remove(itemToUpdate);
      }
    }

    notifyListeners();
  }

  void clearCart() {
    _cart.items.clear();
    notifyListeners();
  }
}
