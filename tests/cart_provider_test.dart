import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';
import 'package:mobile_assessment_jan_2025/models/rating.dart';
import 'package:mobile_assessment_jan_2025/providers/cart_provider.dart';
import 'package:mobile_assessment_jan_2025/screens/products/model/product_model.dart';

void main() {
  group('CartProvider', () {
    late CartProvider cartProvider;

    setUp(() {
      cartProvider = CartProvider();
    });

    test('Initial cart should be empty', () {
      expect(cartProvider.cart.items, isEmpty);
    });

    // test('addToCart adds a new product to the cart', () {
    //   final product = Product(
    //       id: 1,
    //       title: 'Product 1',
    //       price: 10.0,
    //       description: 'Description 1',
    //       category: 'Category 1',
    //       image: 'Image 1',
    //       rating: Rating( rate: 4.5, count: 10));

    //   cartProvider.addToCart(product);

    //   expect(cartProvider.cart.items.length, 1);
    //   expect(cartProvider.cart.items.first.product.id, product.id);
    //   expect(cartProvider.cart.items.first.quantity, 1);
    // });

    // test('addToCart increases quantity for existing product', () {
    //   final product = Product(
    //       id: 1,
    //       title: 'Product 1',
    //       price: 10.0,
    //       description: 'Description 1',
    //       category: 'Category 1',
    //       image: 'Image 1',
    //       rating: Rating(rate: 4.5, count: 10));

    //   cartProvider.addToCart(product);
    //   cartProvider.addToCart(product, quantity: 2);

    //   expect(cartProvider.cart.items.length, 1);
    //   expect(cartProvider.cart.items.first.quantity, 3);
    // });

    // test('removeFromCart removes product with matching ID', () {
    //   final product = Product(
    //       id: 1,
    //       title: 'Product 1',
    //       price: 10.0,
    //       description: 'Description 1',
    //       category: 'Category 1',
    //       image: 'Image 1',
    //       rating: Rating(rate: 4.5, count: 10));

    //   cartProvider.addToCart(product);
    //   cartProvider.removeFromCart(1);

    //   expect(cartProvider.cart.items, isEmpty);
    // });

    // test('updateQuantity updates quantity of a product', () {
    //   final product = Product(
    //       id: 1,
    //       title: 'Product 1',
    //       price: 10.0,
    //       description: 'Description 1',
    //       category: 'Category 1',
    //       image: 'Image 1',
    //       rating: Rating(rate: 4.5, count: 10));

    //   cartProvider.addToCart(product);
    //   cartProvider.updateQuantity(1, 5);

    //   expect(cartProvider.cart.items.first.quantity, 5);
    // });

    // test('updateQuantity removes product if quantity is 0', () {
    //   final product = Product(
    //       id: 1,
    //       title: 'Product 1',
    //       price: 10.0,
    //       description: 'Description 1',
    //       category: 'Category 1',
    //       image: 'Image 1',
    //       rating: Rating(rate: 4.5, count: 10));

    //   cartProvider.addToCart(product);
    //   cartProvider.updateQuantity(1, 0);

    //   expect(cartProvider.cart.items, isEmpty);
    // });

    // test('clearCart removes all items from the cart', () {
    //   final product1 = Product(
    //       id: 1,
    //       title: 'Product 1',
    //       price: 10.0,
    //       description: 'Description 1',
    //       category: 'Category 1',
    //       image: 'Image 1',
    //       rating: Rating(rate: 4.5, count: 10));
    //   final product2 = Product(
    //       id: 2,
    //       title: 'Product 2',
    //       price: 20.0,
    //       description: 'Description 2',
    //       category: 'Category 2',
    //       image: 'Image 2',
    //       rating: Rating(rate: 4.5, count: 20));

    //   cartProvider.addToCart(product1);
    //   cartProvider.addToCart(product2);
    //   cartProvider.clearCart();

    //   expect(cartProvider.cart.items, isEmpty);
    // });
  });
}
