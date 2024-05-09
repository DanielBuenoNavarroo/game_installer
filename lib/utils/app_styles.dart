import 'package:flutter/material.dart';

class AppTheme {
  static const Color dark = Color.fromARGB(255, 19, 19, 19);
  static const Color medium = Color(0x50FFFFFF);
  static const Color light = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFFFA500);

  static const Color disabledBackgroundColor = Colors.black12;
  static const Color disabledForegroundColor = Colors.white12;

  static const Color exitColor = Color.fromARGB(255, 226, 72, 61);
  static const Color minimizeColor = Color.fromARGB(255, 49, 49, 49);
  static const Color sidebarBg = Color.fromARGB(150, 19, 19, 19);

  static const TextStyle titleStyle = TextStyle(
    color: light,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
  );
}