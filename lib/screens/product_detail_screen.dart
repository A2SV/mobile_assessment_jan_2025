import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile_assessment_jan_2025/app/common/ui_helpers.dart';
import 'package:mobile_assessment_jan_2025/widgets/custom_button.dart';
import 'package:mobile_assessment_jan_2025/widgets/image_builder.dart';
import 'package:provider/provider.dart';
import '../app/common/app_text_style.dart';
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
              }),
          horizontalSpaceMiddle,
        ],
      ),
      // TODO: improve the UI of the product detail screen
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageBuilder(
                  image: product.image,
                  height: screenHeight(context) * .3,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                Text('\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 24)),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  RatingBarIndicator(
                      rating: 3,
                      itemSize: 18,
                      itemCount: 1,
                      itemPadding: const EdgeInsets.only(right: 0.0),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {},
                            child: const Icon(Icons.star, color: Colors.amber));
                      }),
                  Text(
                    product.rating.rate.toStringAsFixed(1),
                    style: bold.copyWith(color: Colors.black38),
                  ),
                  Text(
                    '(${product.rating.count} reviews)',
                    style: regular.copyWith(
                      color: Colors.grey,
                    ),
                  )
                ]),
                const SizedBox(height: 16),
                Text(product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            right: mediumSize, left: mediumSize, bottom: middleSize),
        child: CustomButton(
          onTap: () {
            cartProvider.addToCart(product);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Added to cart!')));
          },
          text: 'Add to Cart',
        ),
      ),
    );
  }
}
