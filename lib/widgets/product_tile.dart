import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/favorite_provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return ListTile(
      leading: Hero(
        tag: 'item${product.id}',
        child: CachedNetworkImage(
          imageUrl: product.image,
          width: 50,
          height: 50,
        ),
      ),
      // leading: Image.network(product.image, width: 50, height: 50),
      title: Text(
        product.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber[600], size: 16),
              Text(
                ' ${product.rating.rate} (${product.rating.count} reviews)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            product.category.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  letterSpacing: 0.5,
                ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          if (favoriteProvider.product.contains(product)) {
            favoriteProvider.removeFromFavorite(product);
          } else {
            favoriteProvider.addToFavorite(product);
          }
        },
        icon: Icon(
          favoriteProvider.product.contains(product)
              ? Icons.favorite
              : Icons.favorite_outline,
        ),
      ),
    );
  }
}
