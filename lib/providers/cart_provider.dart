import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../screens/products/model/product_model.dart';

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

    notifyListeners();
  }

  void updateQuantity(int productId, int newQuantity) {
    // TODO: Update quantity for item with productId
    // TODO: If quantity <= 0, remove the item
    notifyListeners();
  }

  void clearCart() {
    // TODO: Clear the cart
    notifyListeners();
  }
}
