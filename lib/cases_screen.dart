import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';
import 'virus_data.dart';
import 'constants.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    fetchData();
  }

  //This method is mostly for debugging purposes to check the API calls results
  void fetchData() async {
    kFetchedOverallCases = await virusData.getOverallConfirmedCases();
    kFetchedOverallDeaths = await virusData.getOverallDeaths();
    setState(() {
      kOverallCases = kFetchedOverallCases;
      kOverallDeaths = kFetchedOverallDeaths;
    });
  }



  String dropDownItemValue='de';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidPullToRefresh(
          backgroundColor: Colors.blueAccent,
            child: ListView(
              children: <Widget>[
                Text('Overall cases in the world: $kOverallCases'),
                Text('Overall deaths in the world: $kOverallDeaths'),
                SizedBox(height: 25),
                Column(
                  children: <Widget>[
                    //Drop down menu with country flags to search for cases
                    DropdownButton(
                        icon: Icon(FontAwesomeIcons.search),
                        iconSize: 35,
                        elevation: 24,
                        value: dropDownItemValue,
                        items: kCountryFlags,
                        onChanged: (value){
                          setState(() {
                            dropDownItemValue=value;
                            print(value);
                          });
                        })
                  ],
                ),
              ],
            ),
            onRefresh: () async {
              fetchData();
            }
        ));
  }
}