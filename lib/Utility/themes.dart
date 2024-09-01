import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  hintColor: Colors.amber,
  appBarTheme: AppBarTheme(
    color: Colors.blue,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.black,fontSize: 18)
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    color: Colors.black,fillColor: Colors.white
  )
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey,
  hintColor: Colors.cyan,
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.white,fontSize: 18)
  ),
);
