import 'package:flutter/material.dart';

const Color _colorMain = Color(0xFF4574D9);
final ThemeData _originalLightTheme = ThemeData.dark();

Color blendColorsWithOpacity(Color background, Color overlay, double opacity) {
  // Mezcla el overlay con el fondo usando la opacidad
  int equivalentOpacity = (255 * opacity).toInt();
  final overlayWithAlpha = overlay.withAlpha(equivalentOpacity);
  return Color.alphaBlend(overlayWithAlpha, background);
}

ThemeData darkTheme({Color colorMain = _colorMain}) {
  return ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: colorMain,
    ),
    primaryColor: colorMain,
    bottomAppBarTheme: BottomAppBarTheme(
      color: colorMain,
    ),
    bottomNavigationBarTheme:
        ThemeData.dark().bottomNavigationBarTheme.copyWith(
              selectedItemColor: colorMain,
              unselectedItemColor: Colors.grey,
            ),
    scaffoldBackgroundColor: colorMain.toString() == colorMain.toString()
        ? ThemeData.dark().scaffoldBackgroundColor
        : blendColorsWithOpacity(
            ThemeData.dark().scaffoldBackgroundColor,
            colorMain,
            0.1,
          ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: colorMain, fontSize: 20),
      elevation: 0,
      iconTheme: IconThemeData(color: colorMain),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: colorMain,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    cardTheme: const CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorMain,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: const UnderlineInputBorder(),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorMain, width: 2.0),
      ),
      prefixIconColor: colorMain, // Color del ícono por defecto
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorMain,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: _originalLightTheme.textTheme.headlineLarge?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: _originalLightTheme.textTheme.headlineMedium?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineSmall: _originalLightTheme.textTheme.headlineSmall?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: _originalLightTheme.textTheme.bodyLarge?.copyWith(
        fontSize: 16,
        color: Colors.grey,
      ),
      bodyMedium: _originalLightTheme.textTheme.bodyMedium?.copyWith(
        fontSize: 14,
        color: Colors.grey,
      ),
      bodySmall: _originalLightTheme.textTheme.bodySmall?.copyWith(
        fontSize: 12,
        color: Colors.grey,
      ),
      titleLarge: _originalLightTheme.textTheme.titleLarge?.copyWith(
        fontSize: 24,
        color: Colors.white,
      ),
      titleMedium: _originalLightTheme.textTheme.titleMedium?.copyWith(
        fontSize: 20,
        color: Colors.white,
      ),
      titleSmall: _originalLightTheme.textTheme.titleSmall?.copyWith(
        fontSize: 18,
        color: Colors.white,
      ),
    ),
  );
}
