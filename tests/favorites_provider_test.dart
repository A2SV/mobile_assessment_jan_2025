import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';
import 'package:mobile_assessment_jan_2025/models/rating.dart';
import 'package:mobile_assessment_jan_2025/providers/favorites_provider.dart';

void main() {
  group('FavoriteProvider', () {
    late FavoritesProvider favoriteProvider;

    setUp(() {
      favoriteProvider = FavoritesProvider();
    });

    test('Initial favorite list should be empty', () {
      expect(favoriteProvider.favoriteProducts, isEmpty);
    });

    test('addToFavorites adds a new product to the favorites', () {
      final product = Product(
          id: 1,
          title: 'Product 1',
          price: 10.0,
          description: 'Description 1',
          category: 'Category 1',
          image: 'Image 1',
          rating: Rating(rate: 4.5, count: 10));

      favoriteProvider.addToFavorites(product);

      expect(favoriteProvider.favoriteProducts.length, 1);
      expect(favoriteProvider.favoriteProducts.first.id, product.id);
    });

    test('addToFavorites does not add duplicate products', () {
      final product = Product(
          id: 1,
          title: 'Product 1',
          price: 10.0,
          description: 'Description 1',
          category: 'Category 1',
          image: 'Image 1',
          rating: Rating(rate: 4.5, count: 10));

      favoriteProvider.addToFavorites(product);
      favoriteProvider.addToFavorites(product);

      expect(favoriteProvider.favoriteProducts.length, 1); // No duplicates
    });

    test('removeFromFavorites removes product with matching ID', () {
      final product = Product(
          id: 1,
          title: 'Product 1',
          price: 10.0,
          description: 'Description 1',
          category: 'Category 1',
          image: 'Image 1',
          rating: Rating(rate: 4.5, count: 10));

      favoriteProvider.addToFavorites(product);
      favoriteProvider.removeFromFavorites(1);

      expect(favoriteProvider.favoriteProducts, isEmpty);
    });

    test('isFavorite returns true if product is in favorites', () {
      final product = Product(
          id: 1,
          title: 'Product 1',
          price: 10.0,
          description: 'Description 1',
          category: 'Category 1',
          image: 'Image 1',
          rating: Rating(rate: 4.5, count: 10));

      favoriteProvider.addToFavorites(product);

      expect(favoriteProvider.isFavorite(1), isTrue);
    });

    test('isFavorite returns false if product is not in favorites', () {
      expect(favoriteProvider.isFavorite(1), isFalse);
    });

    test('clearFavorites removes all items from the favorites list', () {
      final product1 = Product(
          id: 1,
          title: 'Product 1',
          price: 10.0,
          description: 'Description 1',
          category: 'Category 1',
          image: 'Image 1',
          rating: Rating(rate: 4.5, count: 10));
      final product2 = Product(
          id: 2,
          title: 'Product 2',
          price: 20.0,
          description: 'Description 2',
          category: 'Category 2',
          image: 'Image 2',
          rating: Rating(rate: 4.5, count: 20));

      favoriteProvider.addToFavorites(product1);
      favoriteProvider.addToFavorites(product2);
      favoriteProvider.clearFavorites();

      expect(favoriteProvider.favoriteProducts, isEmpty);
    });
  });
}
