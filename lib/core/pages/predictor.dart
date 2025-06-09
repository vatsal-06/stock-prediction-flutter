import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockprediction/theme/app_pallete.dart';
import 'package:stockprediction/core/helpers/forecast_service.dart';

class Predictor extends StatefulWidget {
  const Predictor({super.key});

  @override
  State<Predictor> createState() => _PredictorState();
}

class _PredictorState extends State<Predictor> {
  double _currentYearValue = 1;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  bool isLoading = false;
  String resultMessage = '';

  final ForecastService _forecastService = ForecastService();

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2032),
    );
    if (picked != null) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2032),
    );
    if (picked != null) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  void handlePrediction() async {
    if (selectedStartDate == null || selectedEndDate == null) {
      setState(() {
        resultMessage = 'Please select both start and end dates.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      resultMessage = '';
    });

    // TODO: Replace this mock data with real stock price history fetch logic
    List<Map<String, dynamic>> history = [
      {"ds": "2024-06-01", "y": 100},
      {"ds": "2024-06-02", "y": 105},
      {"ds": "2024-06-03", "y": 102},
      {"ds": "2024-06-04", "y": 110},
    ];

    try {
      final forecast = await _forecastService.getForecast(
        history,
        periods: (_currentYearValue * 365).toInt(),
      );

      setState(() {
        resultMessage = 'Forecast received: ${forecast.length} days';
        isLoading = false;
      });

      print(forecast); // For debugging: check console output
    } catch (e) {
      setState(() {
        resultMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: AppPallete.whiteColor, size: 30),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: AppPallete.backgroundColor,
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
                  selectedStartDate != null
                      ? DateFormat('dd/MM/yyyy').format(selectedStartDate!)
                      : 'No start date selected',
                  style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
                ),
                OutlinedButton(
                  onPressed: _selectStartDate,
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(160, 40)),
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
                  selectedEndDate != null
                      ? DateFormat('dd/MM/yyyy').format(selectedEndDate!)
                      : 'No end date selected',
                  style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
                ),
                OutlinedButton(
                  onPressed: _selectEndDate,
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(160, 40)),
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
              onPressed: isLoading ? null : handlePrediction,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppPallete.deepPurple),
                foregroundColor: MaterialStateProperty.all(AppPallete.whiteColor),
                fixedSize: MaterialStateProperty.all(const Size(200, 50)),
              ),
              child: isLoading
                  ? CircularProgressIndicator(color: AppPallete.whiteColor)
                  : const Text(
                      'Predict Stock',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
            if (resultMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  resultMessage,
                  style: TextStyle(color: AppPallete.whiteColor, fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
