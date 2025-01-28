import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/models/favorite.dart';
import 'package:mobile_assessment_jan_2025/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoriteItemWidget extends StatelessWidget {
  final FavoriteItem favoriteItem;

  const FavoriteItemWidget({super.key, required this.favoriteItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(favoriteItem.product.id),
      background: Container(
        color: Theme.of(context).indicatorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<FavoriteProvider>(context, listen: false)
            .removeFromFavorite(favoriteItem.product.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.network(favoriteItem.product.image),
              ),
            ),
            title: Text(favoriteItem.product.title),
            subtitle: Text('price:${favoriteItem.product.price}'),
          ),
        ),
      ),
    );
  }
}
