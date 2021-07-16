import 'package:first_app/answer.dart';
import 'package:first_app/question.dart';
import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final List<Map> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(questions[questionIndex]['questionText']),
        // Spread operator (...) (which adds a list of lists)
        ...(questions[questionIndex]['answers']).map(
          (answer) {
            return Answer(
                () => answerQuestion(answer['score']), answer['text']);
          },
        ),
      ],
    );
  }
}
