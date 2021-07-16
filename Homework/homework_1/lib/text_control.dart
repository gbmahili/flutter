import 'package:flutter/material.dart';
import 'package:homework_1/display_text.dart';

class TextControl extends StatelessWidget {
  final Function updateText;

  TextControl(this.updateText);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => updateText(),
      child: DisplayText('Update Text'),
    );
  }
}
