import 'package:slimy_card/slimy_card.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

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
class ResultsColumn extends StatelessWidget {
  const ResultsColumn({
    @required this.confirmedCases,
    @required this.recovered,
    @required this.critical,
    @required this.deaths,
    @required this.countryCode
  });

  final String confirmedCases;
  final String recovered;
  final String critical;
  final String deaths;
  final String countryCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset('icons/flags/png/$countryCode.png', package: 'country_icons',scale: 0.8,),
        SizedBox(height: 25,),
        ResultsRow(text: 'Confirmed Cases',results: confirmedCases),
        ResultsRow(text: 'Recovered',results: recovered),
        ResultsRow(text: 'Critical',results: critical),
        ResultsRow(text: 'Deaths',results: deaths),
      ],
    );
  }
}

class ResultsRow extends StatelessWidget {
  const ResultsRow({@required this.results, @required this.text});
  final String results;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text('$text : ',style : kResultsTextStyle),
        Text('$results',style: kResultsNumberStyle,)
      ],
    );
  }
}