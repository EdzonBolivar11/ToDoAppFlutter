import 'package:flutter/material.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 17,
                color: subtitleTextColor,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
