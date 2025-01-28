import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/providers/favorite_provider.dart';
import 'package:mobile_assessment_jan_2025/widgets/favorite_item.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite';

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorite'),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: favoriteProvider.favorite.items.length,
            itemBuilder: (ctx, i) => FavoriteItemWidget(
              favoriteItem: favoriteProvider.favorite.items[i],
            ),
          ),
        ),
      ]),
    );
  }
}
