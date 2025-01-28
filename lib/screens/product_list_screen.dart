import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/constants/app_sizes.dart';
import 'package:mobile_assessment_jan_2025/widgets/product_item.dart';
import 'package:mobile_assessment_jan_2025/widgets/product_item_hori.dart';
import '../models/product.dart';
import '../services/api_service.dart';

import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final products = await _apiService.fetchProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load products. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_products.isEmpty) {
      return const Center(
        child: Text(
          'No products found.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Column(children: [
      _buildHorizontalSection("Best Sellers", _products),
      gapH12,
      Text("All Products ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      gapH12,
      Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 10, // Spacing between columns
            mainAxisSpacing: 10, // Spacing between rows
            childAspectRatio: 0.85, // Adjust as needed for aspect ratio
          ),
          shrinkWrap: true,
          itemCount: _products.length,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final product = _products[index];
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              ),
              child: ProductItem(
                title: product.title.length > 10
                    ? '${product.title.substring(0, 10)}...' // Truncate title with ellipsis
                    : product.title,
                price: product.price,
                imageUrl: product.image,
              ),
            );
          },
        ),
      )
    ]);
  }
}

// divide the products in to five

// show in horizontal scroll
//give it title for each section u can be free on that like best selling, new arrivals, etc
//1 show in grid
Widget _buildHorizontalSection(String title, List<Product> products) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: product),
                        ),
                      ),
                  child: ProductItemHori(
                    title: product.title,
                    price: product.price,
                    imageUrl: product.image,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    ),
                  )),
            );
          },
        ),
      ),
    ],
  );
}
