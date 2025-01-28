import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/common_widgets/button/btn_gradient.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          ListenableBuilder(
              listenable: cartProvider,
              builder: (context, child) {
                return Badge.count(
                  padding: EdgeInsets.zero,
                  count: cartProvider.cart.items.length,
                  isLabelVisible: cartProvider.cart.items.isNotEmpty,
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    ),
                  ),
                );
              })
        ],
      ),
      // TODO: improve the UI of the product detail screen
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Image.network(product.image, height: 300),
              alignment: Alignment.center,
            ),
            const SizedBox(height: 16),
            Text('\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            BtnGradient(
              text: "Add to Cart",
              action: () {
                cartProvider.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to cart!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
