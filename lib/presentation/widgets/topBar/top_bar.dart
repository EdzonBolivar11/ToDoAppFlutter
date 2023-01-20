import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('MMMM D, yyyy');

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(children: [
          Expanded(
              child: Text(
            formatter.format(now),
            style: TextStyle(
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
                color: titleTextColor),
          )),
          Image(
            image: AssetImage('assets/usuario.png'),
            width: 40,
          ),
        ]),
        DescriptionText("5 incomplete, 5 completed"),
        Separator()
      ],
    );
  }
}
