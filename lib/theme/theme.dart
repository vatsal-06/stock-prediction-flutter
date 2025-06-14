import 'package:flutter/material.dart';
import 'package:stockprediction/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(10),
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: AppPallete.whiteColor,
          fontSize: 18,
        ),
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border(),
        ),
  );
}
