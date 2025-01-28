import 'package:flutter/material.dart';

class CustomDialog {
  static Future<dynamic> show({
    required BuildContext context,
    required Widget widget,
    bool dismissible = false,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: const EdgeInsets.all(0.0),
          content: widget,
        ),
      );
}
