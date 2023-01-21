import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Screen extends StatelessWidget {
  final Widget child;
  final void Function()? onPressedAction;

  const Screen({Key? key, required this.child, this.onPressedAction})
      : super(key: key);

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
            floatingActionButton: onPressedAction != null
                ? FloatingActionButton(
                    onPressed: onPressedAction,
                    backgroundColor: Color(0xFF1294f2),
                    child: const Icon(Icons.add, color: Colors.white),
                  )
                : null));
  }
}
