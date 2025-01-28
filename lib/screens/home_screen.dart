import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/providers/cart_provider.dart';
import 'package:mobile_assessment_jan_2025/providers/favorite_provider.dart';
import 'package:mobile_assessment_jan_2025/screens/favorite_screen.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Row(
            children: [
              Consumer<FavoriteProvider>(
                builder: (context, favoriteProvider, child) {
                  return Badge.count(
                    count: favoriteProvider.favorite.items.length,
                    isLabelVisible: favoriteProvider.favorite.items.isNotEmpty,
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavoriteScreen(),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return Badge.count(
                    count: cartProvider.cart.items.length,
                    isLabelVisible: cartProvider.cart.items.isNotEmpty,
                    child: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: const ProductListScreen(),
    );
  }
}
