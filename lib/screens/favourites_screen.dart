import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/common_widgets/text/customNavHeading.dart';
import 'package:mobile_assessment_jan_2025/constants/app_sizes.dart';
import 'package:mobile_assessment_jan_2025/models/product.dart';
import 'package:mobile_assessment_jan_2025/screens/product_detail_screen.dart';
import 'package:mobile_assessment_jan_2025/services/api_service.dart';
import 'package:mobile_assessment_jan_2025/widgets/product_item.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});
  static const routeName = '/favourites';

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
            padding: EdgeInsets.all(Sizes.p8),
            child: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: CustomNavHeading(text: "Favourites"),
            )),
      ),
      body: SingleChildScrollView(
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 10, // Spacing between columns
            mainAxisSpacing: 10, // Spacing between rows
            childAspectRatio: 0.85, // Adjust as needed for aspect ratio
          ),
          shrinkWrap: true,
          itemCount: 10,
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
      ),
    );
  }
}
