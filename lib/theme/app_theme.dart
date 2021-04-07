import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    fontFamily: 'Nunito',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    brightness: Brightness.dark,
    centerTitle: true,
    elevation: 0,
    color: Colors.white,
  );
}
