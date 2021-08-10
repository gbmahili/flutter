import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> _availableMeals;
  // You can create the name of the route to which this widget will navigate to
  static const String routeName = '/category-meals';
  CategoryMealsScreen(this._availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  bool _loadedData = false;

  @override
  void initState() {
    // print('calling --- initState()');
    super.initState();

    // There is no context in initState, so we could have loaded the data here but we can use
    // didChangeDependencies to load the data when the widget has been fully mounted
    // .
    // To extract arguments passed into the navigation (pushedNamed), use this
    // final routeArgs =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // categoryTitle = routeArgs['title'] as String;
    // final categortyId = routeArgs['id'];
    // // Find the meals that match the category from the DUMMY_MEALS data
    // displayedMeals = DUMMY_MEALS.where((meal) {
    //   // categories is a list so we can use the contains method on a list to see if a list contains something
    //   return meal.categories.contains(categortyId);
    // }).toList();
  }

  @override
  void didChangeDependencies() {
    // print('calling --- didChangeDependencies()');
    super.didChangeDependencies();
    if (!_loadedData) {
      // To extract arguments passed into the navigation (pushedNamed), use this
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'] as String;
      final categortyId = routeArgs['id'];
      // Find the meals that match the category from the DUMMY_MEALS data
      displayedMeals = widget._availableMeals.where((meal) {
        // categories is a list so we can use the contains method on a list to see if a list contains something
        return meal.categories.contains(categortyId);
      }).toList();
      _loadedData = true;
    }
  }

  void _removeItem(id) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Container(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                id: displayedMeals[index].id,
                title: displayedMeals[index].title,
                imageUrl: displayedMeals[index].imageUrl,
                duration: displayedMeals[index].duration,
                affordability: displayedMeals[index].affordability,
                complexity: displayedMeals[index].complexity,
                removeItem: _removeItem,
              );
            },
            itemCount: displayedMeals.length),
      ),
    );
  }
}
