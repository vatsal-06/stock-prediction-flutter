import 'package:flutter/material.dart';
import 'package:stockprediction/theme/app_pallete.dart';

class RawDataPlot extends StatefulWidget {
  const RawDataPlot({super.key});

  @override
  State<RawDataPlot> createState() => _RawDataPlotState();
}

class _RawDataPlotState extends State<RawDataPlot> {
  final nameController = TextEditingController(text: 'AAPL');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppPallete.whiteColor, size: 30),
            onPressed: () {
              // settings button press
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Plot Raw Data',
                style: TextStyle(
                  color: AppPallete.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Stock Symbol',
                  labelStyle: TextStyle(
                    color: AppPallete.greyColor,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: AppPallete.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: AppPallete.whiteColor),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement the logic to fetch and plot raw data
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPallete.deepPurple,
                  fixedSize: Size(160, 50),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Plot Data',
                  style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
