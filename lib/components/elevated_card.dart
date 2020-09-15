import 'package:flutter/material.dart';

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
