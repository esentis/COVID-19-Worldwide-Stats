import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'elevated_card.dart';

class MainScreenCases extends StatelessWidget {
  const MainScreenCases({
    this.newCases,
    this.newDeaths,
    this.overallCases,
    this.casesText,
    this.newDeathsText,
    this.newCasesText,
  });
  final String overallCases;
  final String newCases;
  final String newDeaths;
  final String casesText;
  final String newCasesText;
  final String newDeathsText;
  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      gradientColors: [
        const Color(0xFF848ccf),
        const Color(0xFF322f3d),
      ],
      shadowColor: Colors.black,
      elevation: 15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text(
                casesText,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 25,
                  color: const Color(0xFFebecf1).withOpacity(0.8),
                ),
              ),
            ),
            Center(
              child: Text(
                overallCases,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFebecf1).withOpacity(0.8),
                ),
              ),
            ),
            Center(
              child: Text(
                newCasesText,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 25,
                  color: const Color(0xFFebecf1).withOpacity(0.8),
                ),
              ),
            ),
            Center(
              child: Text(
                kOverallNewCases,
                style: GoogleFonts.gfsNeohellenic(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    color: Colors.orangeAccent.withOpacity(0.8)),
              ),
            ),
            Center(
              child: Text(
                newDeathsText,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 25,
                  color: const Color(0xFFebecf1).withOpacity(0.8),
                ),
              ),
            ),
            Center(
              child: Text(
                kOverallNewDeaths,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFcf1b1b).withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
