import 'package:flutter/material.dart';
import 'package:georline_shopping_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:georline_shopping_app/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavorites;
  ProductGrid(this.showFavorites);
  @override
  Widget build(BuildContext context) {
    // This is how you access data from a state management
    // ProductsProvider is passed in to the highest level where this widget is called.
    // In this case, it is passed in the ProductOverviewScreen which is also passed in the main.dart
    // where we are using wrapping the whole app in the ChangeNotifierProvider
    // and create a new instance of the ProductsProvider
    // ChangeNotifierProvider (create: (context) => ProductsProvider(),child: MaterialApp())
    final productsData = Provider.of<ProductsProvider>(context);
    // Using the getter, we get the data (items) from the provider
    final products =
        showFavorites ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider(
          create: (context) => products[
              index], // this products[index] is a class that can notify of changes
          child: ProductItem(
              // products[index].id,
              // products[index].title,
              // products[index].imageUrl,
              // products[index].price,
              ),
        );
      },
    );
  }
}
