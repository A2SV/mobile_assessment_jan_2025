import 'product.dart';

class FavoriteItem {
  final Product product;

  FavoriteItem({
    required this.product,
  });
}

class Favorite {
  List<FavoriteItem> items = [];
}
