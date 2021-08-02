import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  // You can create the name of the route to which this widget will navigate to
  static const String routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    // To extract arguments passed into the navigation (pushedNamed), use this
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // final categortyId = routeArgs['id'];
    final String categoryTitle = routeArgs['title'] as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Container(
        child: Text('Display recipes'),
      ),
    );
  }
}
