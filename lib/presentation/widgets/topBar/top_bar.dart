import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';

class TopBar extends StatelessWidget {
  final List<Widget> children;

  const TopBar({Key? key, this.children = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 103,
      child: Column(
        children: [
          Expanded(
              child: Column(
            children: children,
          )),
          Separator()
        ],
      ),
    );
  }
}
