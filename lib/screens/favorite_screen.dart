import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/providers/favorite_provider.dart';
import 'package:mobile_assessment_jan_2025/widgets/product_tile.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';
import 'product_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
        appBar: AppBar(),
        body: (favoriteProvider.product.isEmpty)
            ? Expanded(
                child: Center(
                  child: Text("Favorite Product is empty"),
                ),
              )
            : ListView.builder(
                itemCount: favoriteProvider.product.length,
                itemBuilder: (context, index) {
                  final product = favoriteProvider.product[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    ),
                    child: ProductTile(product: product),
                  );
                },
              ));
  }
}
