import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        children: const [
          TopBar(),
        ],
      ),
    );
  }
}
