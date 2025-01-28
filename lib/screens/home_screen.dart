import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/common_widgets/text/customNavHeading.dart';
import 'package:mobile_assessment_jan_2025/constants/app_colors.dart';
import 'package:mobile_assessment_jan_2025/constants/app_sizes.dart';
import 'package:mobile_assessment_jan_2025/providers/cart_provider.dart';
import 'package:mobile_assessment_jan_2025/screens/favourites_screen.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.all(Sizes.p8),
          child: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: CustomNavHeading(text: "Products"),
            actions: [
              ListenableBuilder(
                  listenable: cartProvider,
                  builder: (context, child) {
                    return Badge.count(
                      count: cartProvider.cart.items.length,
                      isLabelVisible: cartProvider.cart.items.isNotEmpty,
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: primaryColor,
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartScreen()),
                        ),
                      ),
                    );
                  }),
              gapW12,
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FavouritesScreen()),
                    );
                  },
                  icon: Icon(Icons.favorite_border))
            ],
          ),
        ),
      ),
      body: const ProductListScreen(),
    );
  }
}
