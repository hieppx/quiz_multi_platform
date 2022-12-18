import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../provider/quiz.controller.dart';

class Option extends StatelessWidget {
  const Option(
      {Key? key,
      required this.text,
      required this.index,
      required this.press,
      required this.model})
      : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;
  final QuizModel model;
  @override
  Widget build(BuildContext context) {
    Color getTheRightColor() {
      if (model.isAnswered) {
        if (index == model.correctAns) {
          return kGreenColor;
        } else if (index == model.selectedAns &&
            model.selectedAns != model.correctAns) {
          return kRedColor;
        }
      }
      return kGrayColor;
    }

    IconData getTheRightIcon() {
      return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
    }

    return InkWell(
        onTap: press,
        hoverColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(top: kDefaultPadding),
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            border: Border.all(color: getTheRightColor()),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${index + 1}. $text",
                  style: TextStyle(color: getTheRightColor(), fontSize: 16),
                ),
              ),
              Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: getTheRightColor() == kGrayColor
                      ? Colors.transparent
                      : getTheRightColor(),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: getTheRightColor()),
                ),
                child: getTheRightColor() == kGrayColor
                    ? null
                    : Icon(getTheRightIcon(), size: 16),
              )
            ],
          ),
        ));
  }
}


    