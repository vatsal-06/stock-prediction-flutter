import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stockprediction/core/pages/predictor.dart';
import 'package:stockprediction/core/pages/raw_data_finder.dart';
import 'package:stockprediction/core/pages/raw_data_plot.dart';
import 'package:stockprediction/theme/app_pallete.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int currentPage = 0;

  List<Widget> pages = [
    const StockRawDataFinder(),
    const RawDataPlot(),
    const Predictor(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: AppPallete.backgroundColor,
        buttonBackgroundColor: AppPallete.deepPurple,
        backgroundColor: AppPallete.navBarBg,
        onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
        items: [
        Icon(Icons.data_array_outlined, size: MediaQuery.of(context).size.width / 13, color: AppPallete.whiteColor,),
        Icon(Icons.line_axis, size: MediaQuery.of(context).size.width / 13, color: AppPallete.whiteColor,),
        Icon(Icons.lock_clock, size: MediaQuery.of(context).size.width / 13, color: AppPallete.whiteColor,),
      ],),
      body: IndexedStack(
          index: currentPage,
          children: pages,
        ),

      );
  }
}
