import 'package:flutter/material.dart';
import 'package:georline_shopping_app/models/product.dart';
import 'package:georline_shopping_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = "/product_details";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    // print(productId);
    final ProductsProvider productProvider =
        Provider.of<ProductsProvider>(context);
    // print(productProvider);
    final Product selectedProduct =
        productProvider.items.firstWhere((product) => product.id == productId);
    // print(selectedProduct);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedProduct.title,
        ),
      ),
      body: Text(
        selectedProduct.id,
      ),
    );
  }
}
