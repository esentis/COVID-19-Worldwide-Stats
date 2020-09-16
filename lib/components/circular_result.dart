import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircularResult extends StatelessWidget {
  const CircularResult({
    @required this.title,
    @required this.content,
    @required this.width,
    @required this.height,
    @required this.color,
    @required this.titleFontSize,
    @required this.contentFontSize,
    Key key,
  }) : assert(title != null, 'Title is needed');
  final String title;
  final double titleFontSize;

  final String content;
  final double contentFontSize;
  final double width;
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          color: color,
          border: Border.all(width: 3.0, color: Colors.white),
          boxShadow: [
            const BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: titleFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: Text(
                content,
                style: GoogleFonts.gfsNeohellenic(
                  fontSize: contentFontSize,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
