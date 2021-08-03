import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-detail';
  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    // final id = routeArgs['id'] as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(mealId),
      ),
      body: Container(
        child: Text('hi'),
      ),
    );
  }
}
