import 'package:flutter/material.dart';
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
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
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
        },
      ),
    );
  }
}