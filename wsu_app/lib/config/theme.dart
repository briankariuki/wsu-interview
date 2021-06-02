import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:wsu_app/config/palette.dart';
import 'package:wsu_app/helpers/helpers.dart';

class AppTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      primaryColor: Palette.black,
      fontFamily: 'Inter',
      primarySwatch: generateMaterialColor(Palette.black),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      indicatorColor: Palette.black,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.scaled,
            fillColor: Palette.gray8,
          ),
        },
      ),
      colorScheme: ColorScheme.light(
        primary: Palette.black,
        secondary: Colors.white,
      ),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      primaryColor: Palette.secondary_black,
      fontFamily: 'Inter',
      primarySwatch: generateMaterialColor(Palette.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      indicatorColor: Palette.primary,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.scaled,
            fillColor: Palette.black,
          ),
        },
      ),
      scaffoldBackgroundColor: Palette.secondary_black,
    );
  }
}
