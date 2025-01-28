import 'package:flutter/foundation.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Cart _cart = Cart();
  double _totalPrice = 0;

  Cart get cart => _cart;
  double get totalPrice => _totalPrice;

  void _totalPriceCalculator() {
    _totalPrice = 0;
    for (var ele in _cart.items) {
      var price = ele.product.price * ele.quantity;
      _totalPrice += price;
    }
    notifyListeners();
  }

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
    _totalPriceCalculator();
  }

  void removeFromCart(int productId) {
    final existingItem = _cart.items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );

    if (existingItem.product.id != -1) {
      _cart.items.remove(existingItem);
    } else {
      print("Couldn't find the product");
      return;
    }
    notifyListeners();
    _totalPriceCalculator();
  }

  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity == 0) {
      removeFromCart(productId);
      return;
    }

    final existingItem = _cart.items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );

    if (existingItem.product.id != -1) {
      existingItem.quantity = newQuantity;
    } else {
      if (kDebugMode) {
        print("Couldn't find the product");
      }
      return;
    }
    notifyListeners();
    _totalPriceCalculator();
  }

  void clearCart() {
    _cart.items.clear();
    _totalPrice = 0;
    notifyListeners();
  }

  checktheProduct(int productId) {
    final existingItem = _cart.items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );
    return existingItem.product.id != -1;
  }
}
