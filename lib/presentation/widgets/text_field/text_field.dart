import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String text;
  final bool enabled;
  final Icon? icon;
  final VoidCallback? onPressed;
  final TextEditingController? controller;
  final Widget? child;
  final bool hasError;
  final String errorText;
  final ValueChanged<String>? onChanged;

  const CustomTextField(
      {Key? key,
      this.text = "",
      this.label = "TextField",
      this.enabled = true,
      this.icon,
      this.onPressed,
      this.controller,
      this.child,
      this.hasError = false,
      this.errorText = "Error",
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressed?.call(),
        child: Container(
          padding: EdgeInsets.only(bottom: hasError ? 10 : 0),
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
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                    suffixIcon: icon,
                    errorText: hasError ? errorText : null,
                  ),
                  onChanged: onChanged),
        ));
  }
}
