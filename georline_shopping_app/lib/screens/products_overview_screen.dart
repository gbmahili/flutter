import 'package:flutter/material.dart';
import 'package:georline_shopping_app/providers/cart.dart';
import 'package:georline_shopping_app/screens/cart_screen.dart';
import 'package:georline_shopping_app/widgets/badge.dart';
import 'package:georline_shopping_app/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final loadedProducts = [];
  bool _showFavorites = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer =
    //     Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GeorLine Shopping',
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  // productsContainer.showFavorittesOnly();
                  _showFavorites = true;
                } else {
                  // productsContainer.showAll();
                  _showFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, childArgument) => Badge(
              child: childArgument
                  as Widget, // this should have been the child but putting it out so it does not rebuild (performance)
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: ProductGrid(_showFavorites),
    );
  }
}
