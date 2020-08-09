import 'package:flutter/material.dart';
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

class LanguagePicker extends StatelessWidget {
  const LanguagePicker(
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
