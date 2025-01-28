import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/app/common/ui_helpers.dart';
import 'package:mobile_assessment_jan_2025/widgets/custome_list_widget.dart';
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          _errorMessage!,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: _loadProducts, child: const Text('Retry'))
      ]));
    }

    if (_products.isEmpty) {
      return const Center(
          child: Text('No products found.', style: TextStyle(fontSize: 16)));
    }

    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: middleSize, vertical: tinySize),
          child: CustomeListWidget(
            product: product,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product),
              ),
            ),
          ),
        );
        // return InkWell(
        //   onTap: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (_) => ProductDetailScreen(product: product),
        //     ),
        //   ),
        //   child: ListTile(
        //     leading: Image.network(product.image, width: 50, height: 50),
        //     title: Text(product.title),
        //     subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        //   ),
        // );
      },
    );
  }
}
