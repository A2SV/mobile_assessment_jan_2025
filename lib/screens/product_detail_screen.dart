import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';
import 'package:mobile_assessment_jan_2025/providers/favorites_provider.dart';
import 'package:mobile_assessment_jan_2025/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 222, 245, 248)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Product Card
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button & Lock Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ListenableBuilder(
                        listenable: cartProvider,
                        builder: (context, child) {
                          return Badge.count(
                            padding: EdgeInsets.zero,
                            count: cartProvider.cart.items.length,
                            isLabelVisible: cartProvider.cart.items.isNotEmpty,
                            child: IconButton(
                              icon: const Icon(
                                Icons.shopping_cart,
                                color: Color(0xFF1b1564),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const CartScreen()),
                              ),
                            ),
                          );
                        })
                  ],
                ),

                // Product Image with Circular Background
                Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.network(product.image, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 48,
                      child: IconButton(
                        icon: favoritesProvider.isFavorite(product.id)
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border, color: Colors.red),
                        onPressed: () {
                          if (favoritesProvider.isFavorite(product.id)) {
                            favoritesProvider.removeFromFavorites(product.id);
                          } else {
                            favoritesProvider.addToFavorites(product);
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                const SizedBox(height: 16),

                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1b1564)),
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                ),

                const SizedBox(height: 8),

                const SizedBox(height: 8),

                // Product Description
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const Spacer(),

                // Bottom Buttons
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1b1564),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.only(bottom: 58, top: 32, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionButton(
                        Icons.add,
                        'Add to cart',
                        Color(0xFF1b1564),
                        onTap: () {
                          cartProvider.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart!')),
                          );
                        },
                      ),
                      _buildActionButton(
                        Icons.shopping_cart,
                        'View cart',
                        Colors.orange,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartScreen()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorDot(Color color, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isSelected ? 16 : 12,
      height: isSelected ? 16 : 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, {VoidCallback? onTap}) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
