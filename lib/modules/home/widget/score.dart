import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/routes.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen(
      {super.key,  this.correctAns,  this.allAns});
  final int? correctAns;
  final int? allAns;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Spacer(flex: 3),
          Text(
            "Score",
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: kSecondaryColor),
          ),
          const Spacer(),
          Text(
            "$correctAns/$allAns",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: kSecondaryColor),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(kMain);
              },
              child: const Text('Trở về')),
          const Spacer(flex: 3),
        ],
      ),
    ));
  }
}
