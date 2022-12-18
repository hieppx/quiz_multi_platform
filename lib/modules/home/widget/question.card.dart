import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../models/questions.dart';
import '../provider/quiz.controller.dart';
import 'options.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key, required this.question, required this.model})
      : super(key: key);

  final Question question;
  final QuizModel model;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: Column(children: [
          Text(
            question.content.toString(),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          ...List.generate(
              question.options!.length,
              (index) => Option(
                    text: question.options![index],
                    index: index,
                    press: () {
                      model.checkAns(question, index, context);
                    },
                    model: model,
                  ))
        ]),
      ),
    );
  }
}
