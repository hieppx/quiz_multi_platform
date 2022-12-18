// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


extension ConvertToImage on String {
  Widget toSvg({
    BuildContext? context,
    double width = 24,
    double? height,
    double padding = 0,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SvgPicture.asset(
        this,
        width: width,
        height: height ?? width,
        color: color,
        cacheColorFilter: true,
      ),
    );
  }
}
