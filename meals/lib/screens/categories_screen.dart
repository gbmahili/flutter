import 'package:flutter/material.dart';
import 'package:meals/widgets/category_item.dart';

import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: DUMMY_CATEGORIES
          .map(
            (catData) => CategoryItem(
              catData.id,
              catData.title,
              catData.color,
            ),
          )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // each item can take up to 200dip
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20, // spacing between items on the cross axis
        mainAxisSpacing: 20, // spacing between items on the main axis
      ),
    );
  }
}
