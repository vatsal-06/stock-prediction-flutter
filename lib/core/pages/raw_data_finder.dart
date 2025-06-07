import 'package:flutter/material.dart';
import 'package:stockprediction/theme/app_pallete.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';

class StockRawDataFinder extends StatefulWidget {
  const StockRawDataFinder({super.key});

  @override
  State<StockRawDataFinder> createState() => _StockRawDataFinderState();
}

class _StockRawDataFinderState extends State<StockRawDataFinder> {
  final nameController = TextEditingController(text: 'AAPL');
  late Future<YahooFinanceResponse> future;

  @override
  void initState() {
    super.initState();
    load();
  }

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Stock Raw Data Finder',
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
                onPressed: load,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPallete.deepPurple,
                  fixedSize: Size(160, 50),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Load',
                  style: TextStyle(color: AppPallete.whiteColor, fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: future,
                  builder:
                      (
                        BuildContext context,
                        AsyncSnapshot<YahooFinanceResponse> snapshot,
                      ) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == null) {
                            return Text(
                              'No data found for "${nameController.text}"',
                              style: TextStyle(
                                color: AppPallete.whiteColor,
                                fontSize: 18,
                              ),
                            );
                          }

                          YahooFinanceResponse response = snapshot.data!;
                          final sortedCandles =
                              List<YahooFinanceCandleData>.from(
                                response.candlesData,
                              )..sort((a, b) => b.date.compareTo(a.date));
                          return ListView.builder(
                            itemCount: sortedCandles.length,
                            itemBuilder: (BuildContext context, int index) {
                              YahooFinanceCandleData candleData =
                                  sortedCandles[index];
                              return _CandleCard(candleData);
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppPallete.whiteColor,
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

  void load() {
    future = YahooFinanceDailyReader().getDailyDTOs(nameController.text);
    setState(() {});
  }
}

class _CandleCard extends StatelessWidget {
  final YahooFinanceCandleData candleData;

  const _CandleCard(this.candleData);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPallete.deepPurple,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          candleData.date.toIso8601String(),
          style: TextStyle(color: AppPallete.whiteColor, fontSize: 16),
        ),
        subtitle: Text(
          '''
  Open: ${candleData.open}, 
  Close: ${candleData.close}, 
  High: ${candleData.high}, 
  Low: ${candleData.low}''',
          style: TextStyle(color: AppPallete.whiteColor, fontSize: 14),
        ),
      ),
    );
  }
}
