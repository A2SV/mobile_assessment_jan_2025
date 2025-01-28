import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assessment_jan_2025/screens/cart/bloc/cart_bloc.dart';
import 'package:mobile_assessment_jan_2025/screens/products/bloc/products_bloc.dart';

import 'cart/views/cart_screen.dart';
import 'products/views/product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Badge.count(
                count: state.cart.length,
                isLabelVisible: state.cart.isNotEmpty,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductsStatus.inital:
            case ProductsStatus.loading:
              return Align(
                  alignment: Alignment.center,
                  heightFactor: 1,
                  widthFactor: 1,
                  child: Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(
                          //color: Theme.of(context).primaryIconTheme.color,
                          strokeWidth: 5.0)));
            case ProductsStatus.error:
              return const Center(
                child: Text(
                  'Error fetching products.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            case ProductsStatus.refreshing:
            case ProductsStatus.loaded:
              return state.products.isEmpty
                  ? Center(
                      child: Text(
                        'No products found.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ProductListScreen(products: state.products);
          }
        },
      ),
    );
  }
}
