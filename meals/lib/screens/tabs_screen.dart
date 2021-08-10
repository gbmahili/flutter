import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorites_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // List of tab screens to display which include a lot more data for each one
  List<Map<String, Object>> _pages = [];

  // This will be updated based on which tab was selected, and its index will be
  // used to determine which screen to display.
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // widget is available in initState not directly in the class
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Favorites'},
    ];
  }

  // We update the state of the tabs based on which tab is tapped.
  // Index of the tapped tab is passed in as an argument.
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // A comon way of adding tabs is to add a tab at the bottom of the screen
    return Scaffold(
      // Top bar with title
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),

      // Drawer to the left of the screen
      drawer: MainDrawer(),

      // Bottom tab with navigations
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        currentIndex: _selectedPageIndex, // says what is currently selected
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(fontSize: 14),
        // The type (BottomNavigationBarType) will change the look (background color mostly), style each BottomNavigationBarItem individually
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 18,
        unselectedFontSize: 17,
        items: [
          // Order matters here is on tap will pick the index and pass it to the _selectPage function
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
    );

    // Another way is to add a tab right after the top bar, use DefaultTabController like this:
    // DefaultTabController( does not need to be in a stateful widget

    // return DefaultTabController(
    //   length: 2,
    //   // initialIndex: 1, // default is 0 (which tab is selected first)
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Mahili Meals'),
    //       bottom: TabBar(
    //         tabs: [
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: 'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: 'Favorites',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         // Order is important here. The first widget corresponds to the first tab in TabBar.
    //         CategoriesScreen(),
    //         FavoritesScreen(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
