import 'package:flutter/material.dart';
import 'package:georline_shopping_app/providers/cart.dart';
import 'package:georline_shopping_app/providers/orders.dart';
import 'package:georline_shopping_app/screens/cart_screen.dart';
import 'package:georline_shopping_app/screens/edit_product_screen.dart';
import 'package:georline_shopping_app/screens/order_screen.dart';
import 'package:georline_shopping_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

import 'package:georline_shopping_app/providers/products_provider.dart';
import 'package:georline_shopping_app/screens/product_detail_screen.dart';
import 'package:georline_shopping_app/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Pass data to all the children of the app using ChangeNotifiedProvider
    // return ChangeNotifierProvider.value(
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(value: ProductsProvider()),
        // ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      // return ChangeNotifierProvider.value(
      //   // value: (context) =>
      //   value:
      //       ProductsProvider(), // use this if not using ChangeNotifiedProvider.value and don't need the context
      //   // value:
      //   //     ProductsProvider(), // provide value if using ChangeNotifiedProvider.value
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GeorLine Shopping',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
