
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class CaseCard extends StatelessWidget {
  const CaseCard({this.text,this.icon,this.results,this.backgroundColor,this.iconColor,this.fontSize});
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
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(text,style: kOverallTextStyle.copyWith(
                fontSize: fontSize
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Flash(child: Icon(icon,color: iconColor,size: 25,)),
                SizedBox(width: 15,),
                Text(results,style: kOverallTextStyle),
              ],
            )
          ],
        ),
      ),
    );
  }
}