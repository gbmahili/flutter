import 'package:flutter/material.dart';
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
    final selectedProduct = productProvider.findById(productId);
    // print(selectedProduct);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            selectedProduct.title,
          ),
        ),
        body: Container(
          // height: 300,
          width: double.infinity,
          child: Column(
            children: [
              Card(
                child:
                    Image.network(selectedProduct.imageUrl, fit: BoxFit.cover),
              ),
              SizedBox(height: 10),
              Text(
                "\$${selectedProduct.price}",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text(
                selectedProduct.description,
                style: TextStyle(fontSize: 18),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          margin: EdgeInsets.all(16),
        ));
  }
}
