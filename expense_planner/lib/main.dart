import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Planner'),
      ),
      body: Column(
        children: [
          Card(
            child: Container(
              width: double.infinity,
              color: Colors.blue,
              child: Text('CHARTS'),
            ),
          ),
          Card(
            child: Text('List of transactions'),
          ),
        ],
      ),
    );
  }
}
