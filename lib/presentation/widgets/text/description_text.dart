import 'package:flutter/material.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  final EdgeInsets margin;
  final double fontSize;

  const DescriptionText(this.text,
      {Key? key,
      this.margin = const EdgeInsets.symmetric(vertical: 10),
      this.fontSize = 17})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize,
                color: subtitleTextColor,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
