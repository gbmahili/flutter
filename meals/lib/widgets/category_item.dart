import 'package:flutter/material.dart';
import 'package:meals/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem(this.id, this.title, this.color);

// Navigate to a new screen
  void _selectCategory(BuildContext context) {
    // with push, you get what you set in the parameter, like your id or title
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return CategoryMealsScreen(id, title);
    //     },
    //   ),
    // );

    // with pushNamed, you pass in arguments to the screen, like your id or title
    Navigator.of(context).pushNamed(
      // '/category-meals', // name of the screen to navigate to (check routes)
      CategoryMealsScreen.routeName, // this is the same as above

      // Pass these aguments and retrieve them like:
      //
      ////final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      ///final id = routeArgs['id'];
      arguments: {
        "id": id,
        "title": title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.7),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
