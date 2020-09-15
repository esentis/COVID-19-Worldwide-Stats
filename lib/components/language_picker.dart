import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'language_flag.dart';
import 'linepaint.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({
    @required this.onEnglishTap,
    @required this.onGreekTap,
    @required this.usFlagBorderColor,
    @required this.usFlagBackgroundColor,
    @required this.distanceText,
    @required this.grFlagBackgroundColor,
    @required this.grFlagBorderColor,
  });

  final Function onEnglishTap;
  final Function onGreekTap;
  final Color usFlagBorderColor;
  final Color usFlagBackgroundColor;
  final Color grFlagBorderColor;
  final Color grFlagBackgroundColor;
  final String distanceText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LanguageFlag(
          languageFlag: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'flags/us.png',
              package: 'country_list_pick',
              scale: 4,
            ),
          ),
          onTapped: onEnglishTap,
          borderColor: usFlagBorderColor,
          backgroundColor: usFlagBackgroundColor,
          borderWidth: 2,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            CustomPaint(
              painter: LinePaint(),
              child: const SizedBox(
                width: 110,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              distanceText,
              style: GoogleFonts.gfsNeohellenic(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFebecf1).withOpacity(0.8),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomPaint(
              painter: LinePaint(),
              child: const SizedBox(
                width: 110,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        LanguageFlag(
          languageFlag: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'flags/gr.png',
              package: 'country_list_pick',
              scale: 4.5,
            ),
          ),
          onTapped: onGreekTap,
          borderColor: grFlagBackgroundColor,
          backgroundColor: grFlagBackgroundColor,
          borderWidth: 2,
        ),
      ],
    );
  }
}
