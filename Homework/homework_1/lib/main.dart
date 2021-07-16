import 'package:flutter/material.dart';
import 'package:homework_1/display_text.dart';
import 'package:homework_1/text_control.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> words = ['Wow', 'Such', 'Amazing', 'Mahili', 'Baraka'];
  // create random value between 0 and 2
  int random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  int _rand = 0;
  void _updateText() {
    setState(() {
      _rand = random(0, words.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: DisplayText('Assignment 1'),
        ),
        body: Center(
          child: Container(
            height: 200,
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              children: [
                Center(
                  child: DisplayText(
                    words[_rand],
                  ),
                ),
                TextControl(
                  _updateText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
