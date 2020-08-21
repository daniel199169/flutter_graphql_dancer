import 'package:flutter/material.dart';

class DancerTheme {
  DancerTheme._();
  static const Color _primaryColor = Color(0xffDFC494);
  static const Color _lightColor = Color.fromRGBO(255, 216, 74, 1);
  static const Color _darkColor = Color.fromRGBO(198, 120, 0, 1);

  static const Color _lightBackgroundColor = Colors.white;
  static const Color _lightOnSecondaryColor = Colors.black;
  static const Color _lightOnCardColorShadow = Colors.deepOrange;
  static const Color _lightOnPointColor = Colors.black54;

  static final ThemeData lightTheme = ThemeData(
    unselectedWidgetColor: Colors.white,

    primaryColor: _primaryColor,
    primaryColorLight: _lightColor,
    primaryColorDark: _darkColor,
    accentColor: _lightBackgroundColor,
    //primarySwatch: _primaryColor,
    appBarTheme: AppBarTheme(
      color: _lightBackgroundColor,
      elevation: 12,
      textTheme: TextTheme(
        title: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.white, elevation: 10.0),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white70),
      hintStyle: TextStyle(color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      textTheme: ButtonTextTheme.accent,
    ),
    fontFamily: "Poppins",
    textTheme: TextTheme(
      headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: _primaryColor),
      headline2: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal, color: Colors.black),
      subtitle2: TextStyle(fontSize: 12.0, fontStyle: FontStyle.normal, color: _lightOnCardColorShadow),
      headline5: TextStyle(fontSize: 14.0, fontStyle: FontStyle.normal, color: Colors.black),
      headline3: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal, color: _lightOnSecondaryColor),
      subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: _lightOnSecondaryColor),
      bodyText1: TextStyle(fontSize: 14.0),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
