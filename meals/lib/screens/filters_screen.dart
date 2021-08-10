import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersCreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersCreen(this.currentFilters, this.saveFilters);
  @override
  _FiltersCreenState createState() => _FiltersCreenState();
}

class _FiltersCreenState extends State<FiltersCreen> {
  bool _glootenFree = false;
  bool vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  // Widget _buildSwitchListTile(
  //   String title,
  //   String description,
  //   bool currentValue,
  //   Function updateSwitcher,
  // ) {
  //   return SwitchListTile(
  //     value: currentValue,
  //     onChanged: updateSwitcher,
  //     title: Text(title),
  //     subtitle: Text(description),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // print(widget.currentFilters);
    _glootenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glootenFree,
                  'vegan': _vegan,
                  'vegetarian': vegetarian,
                  'lactose': _lactoseFree,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  // _buildSwitchListTile(
                  //   'Gluten-Free',
                  //   'Only include gluten-free meals',
                  //   _glootenFree,
                  //   (val) {
                  //     setState(
                  //       () {
                  //         _glootenFree = val;
                  //       },
                  //     );
                  //   },
                  // )
                  SwitchListTile(
                    title: Text('Gluten-Free'),
                    subtitle: Text('Only include gluten-free meals.'),
                    value: _glootenFree,
                    onChanged: (val) {
                      setState(() {
                        _glootenFree = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Lactose-Free'),
                    subtitle: Text('Only include lactose-free meals.'),
                    value: _lactoseFree,
                    onChanged: (val) {
                      setState(() {
                        _lactoseFree = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Vegeterian'),
                    subtitle: Text('Only include vegeterian meals.'),
                    value: vegetarian,
                    onChanged: (val) {
                      setState(() {
                        vegetarian = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Vegan'),
                    subtitle: Text('Only include vegan meals.'),
                    value: _vegan,
                    onChanged: (val) {
                      setState(() {
                        _vegan = val;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
