import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String text;
  final bool enabled;
  final Icon? icon;
  final VoidCallback? onPressed;
  final TextEditingController? controller;
  final Widget? child;

  const CustomTextField(
      {Key? key,
      this.text = "",
      this.label = "TextField",
      this.enabled = true,
      this.icon,
      this.onPressed,
      this.controller,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressed?.call(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3), topRight: Radius.circular(3)),
            color: Color(0xFF2C2B30),
          ),
          child: child ??
              TextField(
                controller: controller,
                enabled: enabled,
                decoration: InputDecoration(
                  labelText: label,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  suffixIcon: icon,
                ),
              ),
        ));
  }
}
