import 'package:flutter/material.dart';
import 'package:stockprediction/core/helpers/navigator.dart';
import 'package:stockprediction/theme/app_pallete.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Stoxight",
              style: TextStyle(
                color: AppPallete.whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Your personal stock prediction assistant",
              style: TextStyle(color: AppPallete.deepPurple, fontSize: 18),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPallete.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Navigation(),
                ));
              },
              child: Text(
                "Get Started",
                style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
