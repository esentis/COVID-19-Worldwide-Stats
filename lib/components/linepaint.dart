import 'package:flutter/material.dart';

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
