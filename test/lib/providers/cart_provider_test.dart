import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';
import 'package:mobile_assessment_jan_2025/providers/cart_provider.dart';
import 'package:mobile_assessment_jan_2025/models/rating.dart';

void main() {
  group('CartProvider Tests', () {
    late CartProvider cartProvider;
    late Product testProduct;

    setUp(() {
      cartProvider = CartProvider();
      testProduct = Product(
        id: 1,
        title: 'Test Product',
        price: 9.99,
        description: 'Test Description',
        image: 'test_image.jpg',
        category: 'Test Category',
        rating: Rating(rate: 4.5, count: 10),
      );
    });

    test('should add item to cart', () {
      cartProvider.addToCart(testProduct);
      expect(cartProvider.cart.items.length, 1);
      expect(cartProvider.cart.items.first.product.id, testProduct.id);
      expect(cartProvider.cart.items.first.quantity, 1);
    });

    test('should update quantity when adding existing item', () {
      cartProvider.addToCart(testProduct);
      cartProvider.addToCart(testProduct);
      expect(cartProvider.cart.items.length, 1);
      expect(cartProvider.cart.items.first.quantity, 2);
    });

    test('should remove item from cart', () {
      cartProvider.addToCart(testProduct);
      cartProvider.removeFromCart(testProduct.id);
      expect(cartProvider.cart.items.isEmpty, true);
    });

    test('should update quantity of existing item', () {
      cartProvider.addToCart(testProduct);
      cartProvider.updateQuantity(testProduct.id, 5);
      expect(cartProvider.cart.items.first.quantity, 5);
    });

    test('should remove item when quantity is set to 0', () {
      cartProvider.addToCart(testProduct);
      cartProvider.updateQuantity(testProduct.id, 0);
      expect(cartProvider.cart.items.isEmpty, true);
    });

    test('should clear cart', () {
      cartProvider.addToCart(testProduct);
      cartProvider.addToCart(
        Product(id: 2,
         title: 'Test 2',
         image: 'https://flkasjdf.com',
         category: 'this category',
          price: 19.99,
           description: 'Test', 
            rating: Rating(rate: 4.5, count: 10)
        ,));
      cartProvider.clearCart();
      expect(cartProvider.cart.items.isEmpty, true);
    });

    test('should complete checkout successfully', () async {
      cartProvider.addToCart(testProduct);
      final result = await cartProvider.checkout();
      expect(result, true);
      expect(cartProvider.cart.items.isEmpty, true);
    });
  });
}