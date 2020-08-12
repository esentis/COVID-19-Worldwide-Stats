import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'package:animate_do/animate_do.dart';

class CaseCard extends StatelessWidget {
  const CaseCard(
      {this.text,
      this.icon,
      this.results,
      this.backgroundColor,
      this.iconColor,
      this.fontSize});
  final String text;
  final IconData icon;
  final String results;
  final Color backgroundColor;
  final Color iconColor;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            style: BorderStyle.solid,
            color: Colors.white,
            width: 4,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(text, style: kOverallTextStyle.copyWith(fontSize: fontSize)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Flash(
                    child: Icon(
                  icon,
                  color: iconColor,
                  size: 25,
                )),
                const SizedBox(
                  width: 15,
                ),
                Text(results, style: kOverallTextStyle),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LanguageFlag extends StatelessWidget {
  const LanguageFlag(
      {this.onTapped,
      this.backgroundColor,
      this.languageFlag,
      this.borderColor,
      this.borderWidth});
  final Function onTapped;
  final Color backgroundColor;
  final Color borderColor;
  final Widget languageFlag;
  final double borderWidth;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: borderWidth,
              color: borderColor,
            )),
        child: languageFlag,
      ),
    );
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({
    this.child,
    this.elevation,
    this.shadowColor,
    this.gradientColors,
  });
  final Widget child;
  final List<Color> gradientColors;
  final double elevation;
  final Color shadowColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
      ),
      child: Material(
        color: Colors.transparent,
        elevation: elevation,
        shadowColor: shadowColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: gradientColors),
          ),
          child: child,
        ),
      ),
    );
  }
}

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

class LinePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var arrowLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = const Color(0xFFebecf1).withOpacity(0.8);
    canvas.drawLine(Offset.zero, const Offset(110, 0), arrowLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CountrySearcher extends StatelessWidget {
  const CountrySearcher({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      gradientColors: [
        const Color(0xFF848ccf),
        const Color(0xFF322f3d),
      ],
      shadowColor: Colors.black,
      elevation: 15,
      child: Container(
        child: CountryListPick(
          // to show or hide flag
          isShowFlag: true,
          // true to show  title country or false to code phone country
          isShowTitle: true,
          // to show or hide down icon
          isDownIcon: true,
          isShowCode: true,
          showEnglishName: true,
          // to get feedback data from picker
          onChanged: (CountryCode countryCode) async {
            var arguments = [
              countryCode.code.toLowerCase(),
              countryCode.flagUri,
              countryCode.name
            ];
            await Get.toNamed('/countryScreen', arguments: arguments);
          },
        ),
      ),
    );
  }
}

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
