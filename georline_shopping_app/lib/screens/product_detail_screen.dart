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
    final ProductsProvider productProvider = Provider.of<ProductsProvider>(
      context,
      listen:
          false, // use false if you only pull data once and you don't want to listen for changes...means if the data in the state changes, you should not rebuild this widget, it doesn't care...but keep it to true (which is the default) if you want to listen for changes)
    );
    // print(productProvider);
    final Product selectedProduct = productProvider.findById(productId);
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
