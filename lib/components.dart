import 'package:slimy_card/slimy_card.dart';
import 'package:flutter/material.dart';

class CaseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlimyCard(
      color: Colors.green,
      borderRadius: 20,
      width: 100,
      topCardHeight: 150,
      bottomCardHeight: 100,
      topCardWidget: Text('Hello'),
    );
  }
}
