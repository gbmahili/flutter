import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;
  const MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildContainer(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child, // this will be a widget to put in this component (Widget)
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    // final id = routeArgs['id'] as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingredient'),
            _buildContainer(
              context,
              ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(
              context,
              ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(child: Text("# ${index + 1}")),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              ),
            ),
            FloatingActionButton(
              onPressed: () => toggleFavorite(mealId),
              child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
            ),
            // FloatingActionButton(
            //   onPressed: () {
            //     // Go back (removes page from stack)
            //     // pass in data, array, object, string, etc
            //     // The data passed in pop will be recieved as a Future in the Navigator that pushed to this screen
            //     // use the .then() method to get the data
            //     Navigator.of(context).pop(mealId);
            //   },
            //   child: Icon(Icons.delete),
            // ),
          ],
        ),
      ),
    );
  }
}
