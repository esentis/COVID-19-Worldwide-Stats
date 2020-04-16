import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';
import 'virus_data.dart';
import 'constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';



class CaseScreen extends StatefulWidget {
  @override
  _CaseScreenState createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  NumberFormat heart = new NumberFormat("#,###", "en_US");

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
    kFetchedOverallDeaths = await virusData.getOverallDeaths();
    setState(() {
      kOverallCases = kFetchedOverallCases;
      kOverallDeaths = kFetchedOverallDeaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidPullToRefresh(
            child: ListView(
              children: <Widget>[
                Text('Overall cases in the world: $kOverallCases'),
                Text('Overall deaths in the world: $kOverallDeaths')
              ],
            ),
            onRefresh: () async {
              startApp();
            }
        ));
  }
}