import 'package:flutter/material.dart';
import 'package:stockprediction/theme/app_pallete.dart';

class Predictor extends StatefulWidget {
  const Predictor({super.key});

  @override
  State<Predictor> createState() => _PredictorState();
}

class _PredictorState extends State<Predictor> {
  double _currentYearValue = 1;
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2032),
    );

    setState(() {
      selectedDate = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppPallete.whiteColor, size: 30),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Stock Prediction',
              style: TextStyle(
                color: AppPallete.whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
              decoration: InputDecoration(
                labelText: 'Stock Symbol',
                labelStyle: TextStyle(
                  color: AppPallete.greyColor,
                  fontSize: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppPallete.borderColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppPallete.whiteColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'No date selected',
                  style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
                ),
                OutlinedButton(
                  onPressed: _selectDate,
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(const Size(160, 40)),
                  ),
                  child: const Text('Select Start Date'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'No date selected',
                  style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
                ),
                OutlinedButton(
                  onPressed: _selectDate,
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(const Size(160, 40)),
                  ),
                  child: const Text('Select End Date'),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              'Select Prediction Years:',
              style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
            ),
            Slider(
              value: _currentYearValue,
              min: 1,
              max: 5,
              divisions: 4,
              label: _currentYearValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentYearValue = value;
                });
              },
              activeColor: AppPallete.deepPurple,
              inactiveColor: AppPallete.whiteColor,
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Handle prediction logic here
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppPallete.deepPurple),
                foregroundColor: WidgetStateProperty.all(AppPallete.whiteColor),
                fixedSize: WidgetStateProperty.all(const Size(200, 50)),
              ),
              child: const Text(
                'Predict Stock',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppPallete.backgroundColor,
    );
  }
}
