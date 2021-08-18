import 'package:flutter/material.dart';
import 'package:georline_shopping_app/widgets/product_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final loadedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GeorLine Shopping',
        ),
      ),
      body: ProductGrid(),
    );
  }
}
