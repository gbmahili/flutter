import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mahili Meals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Railway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            // for the title
            headline6: TextStyle(
              fontSize: 20.0,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: "/",
      routes: {
        // '/': (contextt) => CategoriesScreen(),
        '/': (contextt) => TabsScreen(),
        // '/category-meals': (context) => CategoryMealsScreen(),
        // the routeName is a string that was created on top of the CategoryMealsScreen widget
        // so that we can always refer to it whenever we need to navigatte to that screen, this
        // is a good practice to follow so that you don't forget to update the routeName when
        // you update the screen
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
      },
      // On generateRoute is used catch any error if we try to navigate
      // to a route that doesn't exist (not registered)
      // You pass in a route to which it will go if the route doesn't exist
      onGenerateRoute: (settings) {
        print(settings
            .arguments); // use this settings to do other things if route not found
        return MaterialPageRoute(
            builder: (context) =>
                CategoriesScreen()); // navigate to another route
      },
      // this is used in case Flutter can't find a route or nothing is defined...
      // this is the last resort and if it fails, it will crash the app
      // You can show a page that says "404" or "Something went wrong" screen
      onUnknownRoute: (settings) {
        print(settings
            .arguments); // use this settings to do other things if route not found
        return MaterialPageRoute(
            builder: (context) =>
                CategoriesScreen()); // navigate to another route
      },
      // The difference between onGenerateRoute and onUnknownRoute is that, onGenerateRoute executes for any
      // unregistered route, whereas onUnknownRoute executes if onGenerateRoute isn't defined or doesn't return a valid
      // navigation action.
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahili Meals'),
      ),
      body: Text('Navigation time'),
    );
  }
}
