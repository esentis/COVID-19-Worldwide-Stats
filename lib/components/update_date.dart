import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'elevated_card.dart';

class UpdateDate extends StatelessWidget {
  const UpdateDate({
    this.date,
    this.text,
  });
  final String date;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      gradientColors: [
        const Color(0xFF848ccf),
        const Color(0xFF322f3d),
      ],
      shadowColor: Colors.black,
      elevation: 25,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Center(
              child: Text(
                text,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFebecf1).withOpacity(0.8),
                ),
              ),
            ),
            Center(
              child: Text(
                date,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFebecf1).withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
