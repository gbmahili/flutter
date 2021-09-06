import 'package:flutter/material.dart';
import 'package:georline_shopping_app/providers/cart.dart';
import 'package:georline_shopping_app/providers/products_provider.dart';
import 'package:georline_shopping_app/screens/cart_screen.dart';
import 'package:georline_shopping_app/widgets/app_drawer.dart';
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

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // This wont work unless you add , listen: false to the provider
    // Provider.of<ProductsProvider>(context)
    //     .fetchAndSetProducts();
    // This will work but its hacky...
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductsProvider>(context)
    //     .fetchAndSetProducts();
    // });
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      // only so it can run once
      _isLoading = true;
      try {
        await Provider.of<ProductsProvider>(context).fetchAndSetProducts();
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("We're sorry!"),
            content:
                Text("There was an error fetching data. Please contact us."),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('GOT IT'))
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    _isInit = false; // set it false so it only run onces
    super.didChangeDependencies();
  }

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
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(_showFavorites),
    );
  }
}
