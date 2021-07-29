import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  final Function handler;
  final String buttonText;
  AdaptiveTextButton(this.handler, this.buttonText);

  @override
  Widget build(BuildContext context) {
    final Widget button = Text(
      buttonText,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    return Platform.isIOS
        ? CupertinoButton(
            child: button,
            onPressed: () => handler(),
          )
        : TextButton(
            onPressed: () => handler(),
            child: button,
          );
  }
}
