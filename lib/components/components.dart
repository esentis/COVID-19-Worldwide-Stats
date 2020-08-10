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
    this.color,
  });
  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
      ),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        color: color,
        shadowColor: Colors.white,
        child: child,
      ),
    );
  }
}

class MainScreenCases extends StatelessWidget {
  const MainScreenCases({
    this.newCases,
    this.newDeaths,
    this.overallCases,
  });
  final String overallCases;
  final String newCases;
  final String newDeaths;
  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      color: Colors.red.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'Worldwide cases',
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                overallCases,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                'New cases',
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                kOverallNewCases,
                style: GoogleFonts.gfsNeohellenic(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    color: Colors.orangeAccent),
              ),
            ),
            Center(
              child: Text(
                'New deaths',
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                kOverallNewDeaths,
                style: GoogleFonts.gfsNeohellenic(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent),
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
      ..color = Colors.white;
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
      color: Colors.red.withOpacity(0.5),
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
                fontSize: 20,
                color: Colors.white,
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
  });
  final String date;
  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      color: Colors.redAccent.withOpacity(0.5),
      child: Column(
        children: [
          Center(
            child: Text(
              'Last update',
              style: GoogleFonts.gfsNeohellenic(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Text(
              date,
              style: GoogleFonts.gfsNeohellenic(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
