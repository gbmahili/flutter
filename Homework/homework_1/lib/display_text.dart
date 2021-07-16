import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  final String text;
  const DisplayText(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
