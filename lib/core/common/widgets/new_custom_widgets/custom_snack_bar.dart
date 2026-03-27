import 'package:flutter/material.dart';

class CustomSnackBar {
  /// Show a custom floating SnackBar
  static void show(
      BuildContext context, {
        required String message,
        Color backgroundColor = Colors.black87,
        double fontSize = 16,
        Duration duration = const Duration(seconds: 3),
      }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
