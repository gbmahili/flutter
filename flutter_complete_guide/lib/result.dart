import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function _resetHandler;

  Result(this.resultScore, this._resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 8) {
      resultText = 'You are awesome and innocent';
    } else if (resultScore <= 12) {
      resultText = 'You are likeable';
    } else if (resultScore <= 16) {
      resultText = 'You are ... strange?!';
    } else {
      resultText = 'You are so bad';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: double.infinity,
          height: 200.0,
          child: Center(
              child: Column(
            children: [
              Text(
                resultPhrase,
                style: TextStyle(
                  fontSize: 40.0,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              TextButton(onPressed: _resetHandler, child: Text('Restart Quiz'))
            ],
          )),
        ),
      ),
    );
  }
}
