import 'package:flutter/material.dart';

class AppCardTheme {
  AppCardTheme._();

  static CardThemeData _baseTheme({
    required Color backgroundColor,
    required Color borderColor,
    required double radius,
    required double elevation,
  }) {
    return CardThemeData(
      color: backgroundColor,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor),
      ),
      margin: EdgeInsets.zero,
    );
  }

  /// 🌞 Light Theme
  static final CardThemeData lightCardTheme = _baseTheme(
    backgroundColor: Colors.white,
    borderColor: Colors.black,
    radius: 16,
    elevation: 0,
  );

  /// 🌚 Dark Theme
  static final CardThemeData darkCardTheme = _baseTheme(
    backgroundColor: const Color(0xff212121),
    borderColor: const Color(0xff16A8AD),
    radius: 16,
    elevation: 0,
  );
}
