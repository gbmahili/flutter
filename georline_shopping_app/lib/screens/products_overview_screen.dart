import 'package:flutter/material.dart';
import 'package:georline_shopping_app/widgets/product_grid.dart';
import '../models/product.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [];

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
