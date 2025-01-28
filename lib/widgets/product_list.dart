import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductListWidget extends StatelessWidget {
  final Product product;

  const ProductListWidget({
    super.key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
    required this.onFavorite,
  });

  final double width, aspectRetio;

  final VoidCallback onPress;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.08,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF979797).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    Hero(tag: product.id, child: Image.network(product.image)),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF7643),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: product.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: onFavorite,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
