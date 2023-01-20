import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Screen extends StatelessWidget {
  final Widget child;

  const Screen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 15),
            child: child,
          )),
        ));
  }
}
