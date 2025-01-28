import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';
import 'package:mobile_assessment_jan_2025/screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productName = product.title;
    final price = product.price.toStringAsFixed(2);
    final imageAssetPath = product.image;
    final rating = product.rating.rate;
    return Container(
      margin: const EdgeInsets.all(16),
      height: 250.0,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            // Product Image
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageAssetPath ?? ""),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withAlpha((0.7 * 255).round()),
                      Colors.black.withAlpha((0.2 * 255).round()),
                    ],
                  ),
                ),
              ),
            ),

            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: Container(
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: Color(0xFF1b1564),
            //       borderRadius: const BorderRadius.only(
            //         topRight: Radius.circular(16),
            //       ),
            //     ),
            //     child: Row(
            //       children: [
            //         const Icon(
            //           Icons.shopping_cart,
            //           color: Colors.white,
            //           size: 16,
            //         ),
            //         const SizedBox(width: 4.0),
            //         Text(
            //           "20",
            //           style: const TextStyle(
            //             letterSpacing: 1.5,
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // Price Overlay
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF1b1564),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: Text(
                  price ?? "",
                  style: const TextStyle(
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Product Details Overlay
            Positioned(
              bottom: 16.0,
              left: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300.0,
                    child: Text(
                      productName ?? "",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: index < (rating ?? 0.0) ? Colors.yellow : Colors.grey,
                        size: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
