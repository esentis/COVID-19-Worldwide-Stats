import 'package:covid19worldwide/components/circular_result.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'elevated_card.dart';

class MainScreenCases extends StatelessWidget {
  const MainScreenCases({
    this.newCases,
    this.newDeaths,
    this.overallCases,
    this.overallCasesText,
    this.newDeathsText,
    this.newCasesText,
  });
  final String overallCases;
  final String newCases;
  final String newDeaths;
  final String overallCasesText;
  final String newCasesText;
  final String newDeathsText;
  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      gradientColors: [
        Colors.white,
        Colors.red[900],
      ],
      shadowColor: Colors.black,
      elevation: 15,
      child: Expanded(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CircularResult(
                color: const Color(0xfffe7171),
                titleFontSize: 22,
                contentFontSize: 22,
                width: 150,
                height: 100,
                title: overallCasesText,
                content: overallCases,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CircularResult(
                color: Colors.orange[900],
                titleFontSize: 22,
                contentFontSize: 22,
                width: 150,
                height: 100,
                title: newCasesText,
                content: newCases,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CircularResult(
                color: Colors.red[900],
                titleFontSize: 22,
                contentFontSize: 22,
                width: 150,
                height: 100,
                title: newDeathsText,
                content: newDeaths,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
