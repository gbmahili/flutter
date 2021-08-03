import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/widgets/meal_item.dart';

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
    final String categoryTitle = routeArgs['title'] as String;
    final categortyId = routeArgs['id'];

    // Find the meals that match the category from the DUMMY_MEALS data
    final categoryMeals = DUMMY_MEALS.where((meal) {
      // categories is a list so we can use the contains method on a list to see if a list contains something
      return meal.categories.contains(categortyId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Container(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                id: categoryMeals[index].id,
                title: categoryMeals[index].title,
                imageUrl: categoryMeals[index].imageUrl,
                duration: categoryMeals[index].duration,
                affordability: categoryMeals[index].affordability,
                complexity: categoryMeals[index].complexity,
              );
            },
            itemCount: categoryMeals.length),
      ),
    );
  }
}
