import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';
import 'virus_data.dart';
import 'constants.dart';
import 'components.dart';

class CaseScreen extends StatefulWidget {
  @override
  _CaseScreenState createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {

  //A new instance of VirusData to access search methods
  VirusData virusData = new VirusData();

  //This is called exactly when the screen loads
  @override
  void initState() {
    super.initState();
    startApp();
  }

  //This method is mostly for debugging purposes to check the API calls results
  void startApp() async {
    kFetchedOverallCases = await virusData.getOverallConfirmedCases();
    kFetchedCasesByCountry = await virusData.getCasesByCountry('Italy');
    kFetchedCasesByCountryGR = await virusData.getCasesByCountry('Greece');
    kFetchedCasesByCountryCode = await virusData.getCasesByCountryCode('it');
    kFetchedOverallDeaths = await virusData.getOverallDeaths();
    setState(() {
      kOverallCases = kFetchedOverallCases;
      kCasesByCountry = kFetchedCasesByCountry;
      kCasesByCountryGR = kFetchedCasesByCountryGR;
      kOverallDeaths = kFetchedOverallDeaths;
      kCasesByCountryCode = kFetchedCasesByCountryCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('$kCasesByCountryCode'),
        ),
      ),
    );
  }
}
