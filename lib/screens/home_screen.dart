import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/providers/cart_provider.dart';
import 'package:mobile_assessment_jan_2025/screens/fav_screen.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          ListenableBuilder(
              listenable: cartProvider,
              builder: (context, child) {
                return Badge.count(
                  count: cartProvider.favorites.length,
                  isLabelVisible: cartProvider.favorites.isNotEmpty,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FavScreen()),
                      ),
                    ),
                  ),
                );
              }),
          SizedBox(width: 10),
          ListenableBuilder(
              listenable: cartProvider,
              builder: (context, child) {
                return Badge.count(
                  count: cartProvider.cart.items.length,
                  isLabelVisible: cartProvider.cart.items.isNotEmpty,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      ),
                    ),
                  ),
                );
              }),
          SizedBox(width: 10),
        ],
      ),
      body: const ProductListScreen(),
    );
  }
}
