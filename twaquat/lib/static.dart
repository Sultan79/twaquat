// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

final twaquatThemeData = ThemeData(
  fontFamily: "Montserrat-Arabic",
  scaffoldBackgroundColor: backgroundColor(),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor(),
    secondary: primaryColor(),
    primary: secondaryColor(),
    background: backgroundColor(),
  ),
  hintColor: Colors.grey,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(secondaryColor()),
        elevation: MaterialStateProperty.all(0)),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.grey),
      surfaceTintColor: MaterialStateProperty.all(Colors.blue),
      overlayColor:
          MaterialStateProperty.all(secondaryColor().withOpacity(0.1)),
      textStyle: MaterialStateProperty.all(TextStyle()),
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      fontSize: 12,
      color: Colors.black,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      letterSpacing: 1,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: primaryColor(),
    actionTextColor: Colors.white,
  ),
);

Color backgroundColor() => Color(0xffF9F9F9);

Color secondaryColor() => Color(0xff1AAF5D);

Color primaryColor() => Color(0xffF8815E);
