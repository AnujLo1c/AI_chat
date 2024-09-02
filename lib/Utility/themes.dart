import 'package:ai_chat/Utility/colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  // primaryColorDark: ,
  primaryColor: Colors.white,
  splashColor: Colors.black,
  primaryColorDark: Colors.blue,
  primaryColorLight: Colors.black,
  cardColor: Colors.lightBlueAccent,
  canvasColor: Colors.green,
hoverColor: Colors.blue,
  //side panel
  disabledColor: Colors.grey.shade100,
  dividerColor: Colors.white,

  hintColor: Colors.amber,
  // textTheme: TextTheme(displayMedium:TextStyle(color: Colors.white)),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),


);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: MyColors.primary,
  // primaryColorDark: ,
  splashColor: MyColors.primary2,
  primaryColorDark: MyColors.secondary,
  primaryColorLight: MyColors.secondary2,
  cardColor: MyColors.chatboxmy,
  canvasColor: MyColors.chatboxai,
  disabledColor: MyColors.sidepanel,
  dividerColor: MyColors.sidepaneltile,
//panel
hoverColor: Colors.black,

  hintColor: Colors.cyan,



);
