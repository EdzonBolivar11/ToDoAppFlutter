import 'package:flutter/material.dart';
import 'package:to_do_app/src/constants/theme/colors.dart';

class CustomDialogWidget {
  static void showCustomDialog(BuildContext context, Widget child) =>
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => Dialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child,
              ],
            ),
          ),
        ),
      );
}
