import 'package:flutter/material.dart';

const Color colorMain = Color(0xFF4574D9);
ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    primary: colorMain,
  ),
  primaryColor: colorMain,
  appBarTheme: const AppBarTheme(
    backgroundColor: colorMain,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: colorMain,
      foregroundColor: Colors.white,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  cardColor: Colors.white,
  cardTheme: const CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: colorMain,
      foregroundColor: Colors.white,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
);
