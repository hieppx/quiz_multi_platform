import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_platform/common/routes.dart';
import 'package:quiz_multi_platform/generated/l10n.dart';
import 'package:quiz_multi_platform/modules/home/widget/question.card.dart';

import '../../../common/constants.dart';
import '../provider/quiz.controller.dart';
import '../widget/progress.bar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.title});
  final String title;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  QuizModel model = QuizModel();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    model.getQuestion();
    model.getTime(this);
  }

  @override
  void dispose() {
    super.dispose();
    model.animationController!.dispose();
    model.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => model,
        builder: (context, widgets) =>
            Consumer<QuizModel>(builder: ((context, value, child) {
              return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: onBack,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    title: Text(widget.title),
                    centerTitle: true,
                  ),
                  body: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProgressBar(i: model.animation?.value),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        Text.rich(TextSpan(
                            text:
                                "${S.of(context).question} ${model.questionNumber}",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: kSecondaryColor,
                                    fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "/${model.question.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.bold),
                              )
                            ])),
                        const Divider(
                          thickness: 1.5,
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        Expanded(
                            child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: model.pageController,
                                onPageChanged: model.getPage,
                                itemCount: model.question.length,
                                itemBuilder: (context, index) => QuestionCard(
                                      question: model.question[index],
                                      model: model,
                                    )))
                      ],
                    ),
                  )));
            })));
  }

  void onBack() {
    Navigator.of(context).pushNamed(kMain);
  }
}
