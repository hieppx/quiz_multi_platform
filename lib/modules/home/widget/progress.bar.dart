import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/constants.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key, required this.i}) : super(key: key);
  final double i;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
          width: double.infinity,
          height: 35,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff3f4768), width: 3),
              borderRadius: BorderRadius.circular(50)),
          child: Stack(
            children: [
              LayoutBuilder(
                  builder: ((context, constraints) => Container(
                        width: constraints.maxWidth * i,
                        decoration: BoxDecoration(
                            gradient: kPrimaryGradient,
                            borderRadius: BorderRadius.circular(50)),
                      ))),
              Positioned.fill(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${(i * 12).round()} sec"),
                    SvgPicture.asset("assets/icon/clock.svg"),
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
