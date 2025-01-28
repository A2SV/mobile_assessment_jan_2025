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
    // TODO: Remove item with matching productId from cart
    final cartToBEDeleted = _cart.items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );
    _cart.items.remove(cartToBEDeleted);
    notifyListeners();
  }

  void updateQuantity(int productId, int newQuantity) {
    final cartToBeUpdated = _cart.items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );
    if (newQuantity <= 0) {
      _cart.items.remove(cartToBeUpdated);
    } else {
      cartToBeUpdated.quantity = newQuantity;
    }
    notifyListeners();
  }

  void clearCart() {
    // TODO: Clear the cart
    _cart.items.clear();
    notifyListeners();
  }
}
