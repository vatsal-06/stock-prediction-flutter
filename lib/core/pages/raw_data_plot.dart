import 'package:flutter/material.dart';
import 'package:stockprediction/theme/app_pallete.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';
import 'package:fl_chart/fl_chart.dart';

class RawDataPlot extends StatefulWidget {
  const RawDataPlot({super.key});

  @override
  State<RawDataPlot> createState() => _RawDataPlotState();
}

class _RawDataPlotState extends State<RawDataPlot> {
  final nameController = TextEditingController(text: 'AAPL');
  double _currentYearValue = 1;
  late Future<YahooFinanceResponse> future;

  @override
  void initState() {
    super.initState();
    plot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
              SizedBox(height: 14),
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
              SizedBox(height: 12),
              Slider(
              value: _currentYearValue,
              min: 1,
              max: 15,
              divisions: 15,
              label: _currentYearValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentYearValue = value;
                });
              },
              activeColor: AppPallete.deepPurple,
              inactiveColor: AppPallete.whiteColor,
            ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: plot,
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
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppPallete.deepPurple,
                        ),
                      );
                    } else if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.candlesData.isEmpty) {
                      return Text(
                        'No data found for ${nameController.text}',
                        style: TextStyle(
                          color: AppPallete.whiteColor,
                          fontSize: 18,
                        ),
                      );
                    } else {
                      final candles = snapshot.data!.candlesData;
                      final numYears = DateTime.now().subtract(
                        Duration(days: (_currentYearValue * 365).round()),
                      );
                      final filteredCandles =
                          candles
                              .where(
                                (c) => c.date.isAfter(numYears),
                              )
                              .toList()
                            ..sort((a, b) => a.date.compareTo(b.date));
                      final open = <FlSpot>[];
                      final high = <FlSpot>[];
                      final low = <FlSpot>[];
                      final close = <FlSpot>[];

                      for (int i = 0; i < filteredCandles.length; i++) {
                        open.add(FlSpot(i.toDouble(), filteredCandles[i].open));
                        high.add(FlSpot(i.toDouble(), filteredCandles[i].high));
                        low.add(FlSpot(i.toDouble(), filteredCandles[i].low));
                        close.add(FlSpot(i.toDouble(), filteredCandles[i].close));
                      }
                      return LineChart(
                        LineChartData(
                          backgroundColor: AppPallete.backgroundColor,
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: (filteredCandles.length / 5)
                                    .floorToDouble()
                                    .clamp(1, double.infinity),
                                getTitlesWidget: (value, meta) {
                                  int idx = value.toInt();
                                  if (idx < 0 || idx >= filteredCandles.length) {
                                    return Container();
                                  }
                                  final date = filteredCandles[idx].date;
                                  return Text(
                                    "${date.month}/${date.day}",
                                    style: TextStyle(
                                      color: AppPallete.whiteColor,
                                      fontSize: 10,
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: open,
                              isCurved: false,
                              color: AppPallete.blueColor,
                              barWidth: 2,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                            LineChartBarData(
                              spots: close,
                              isCurved: false,
                              color: AppPallete.greenColor,
                              barWidth: 2,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                            LineChartBarData(
                              spots: high,
                              isCurved: false,
                              color: AppPallete.redColor,
                              barWidth: 2,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                            LineChartBarData(
                              spots: low,
                              isCurved: false,
                              color: Colors.orange,
                              barWidth: 2,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: true),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void plot() {
    future = YahooFinanceDailyReader().getDailyDTOs(nameController.text);
    setState(() {});
  }
}
