import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String text;
  const CustomTextField({Key? key, this.text = "", this.label = "TextField"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3), topRight: Radius.circular(3)),
          color: Color(0xFF2C2B30),
        ),
        child: TextField(
          decoration: InputDecoration(
            labelText: label,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          ),
        ));
  }
}
