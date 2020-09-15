import 'package:flutter/material.dart';

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
