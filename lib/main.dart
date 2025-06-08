import 'package:flutter/material.dart';
import 'package:stockprediction/core/helpers/welcome.dart';
import 'package:stockprediction/theme/app_pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: WidgetStatePropertyAll(AppPallete.whiteOpac),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}

