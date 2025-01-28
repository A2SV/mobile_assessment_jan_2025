import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';
import 'package:mobile_assessment_jan_2025/models/rating.dart';
import 'package:mobile_assessment_jan_2025/providers/favorites_provider.dart';


void main() {
  group('FavoritesProvider Tests', () {
    late FavoritesProvider favoritesProvider;
    late Product testProduct;

    setUp(() {
      favoritesProvider = FavoritesProvider();
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

    test('should add product to favorites', () {
      favoritesProvider.toggleFavorite(testProduct);
      expect(favoritesProvider.favorites.length, 1);
      expect(favoritesProvider.isFavorite(testProduct), true);
    });

    test('should remove product from favorites', () {
      favoritesProvider.toggleFavorite(testProduct);
      favoritesProvider.toggleFavorite(testProduct);
      expect(favoritesProvider.favorites.isEmpty, true);
      expect(favoritesProvider.isFavorite(testProduct), false);
    });

    test('should correctly check if product is favorite', () {
      expect(favoritesProvider.isFavorite(testProduct), false);
      favoritesProvider.toggleFavorite(testProduct);
      expect(favoritesProvider.isFavorite(testProduct), true);
    });
  });
}