import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'virus_data.dart';
import 'constants.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:animate_do/animate_do.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'components.dart';

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
  bool showSpinner = false;
  String searchedCountryResults;
  String confirmedCases='-';
  String recovered='-';
  String critical='-';
  String deaths='-';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: LiquidPullToRefresh(
            backgroundColor: Colors.blueAccent,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Center(child: FadeInLeft(child: Column(
                    children: <Widget>[
                      Text('Overall cases in the world: ',style: kOverallTextStyle,textAlign: TextAlign.center,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: <Widget>[
                          Flash(child: Icon(FontAwesomeIcons.virus,size: 35,color: Colors.deepOrange,)),
                          SizedBox(width: 15,),
                          Text('$kOverallCases',style: kOverallTextStyle),
                        ],
                      )
                    ],
                  ))),
                  Center(child: FadeInLeft(child: Column(
                    children: <Widget>[
                      Text('Overall deaths in the world: ',style: kOverallTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Flash(child: Icon(FontAwesomeIcons.skull,color: Colors.red,size: 25,)),
                          SizedBox(width: 15,),
                          Text('$kOverallDeaths',style: kOverallTextStyle),
                        ],
                      )
                    ],
                  ))),
                  SizedBox(height: 25),
                  Center(child: Flash(child: Text('Search country',style: kResultsTextStyle,))),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        //Drop down menu with country flags to search for cases
                        DropdownButton(
                            icon: Icon(FontAwesomeIcons.search),
                            underline: Container(
                            ),
                            iconSize: 35,
                            elevation: 24,
                            value: dropDownItemValue,
                            items: kCountryFlags,
                            onChanged: (value) async {
                              showSpinner=true;
                              setState(() {
                                dropDownItemValue=value;
                              });
                              searchedCountryResults = await virusData.getCasesByCountryCode(dropDownItemValue);
                              confirmedCases = jsonDecode(searchedCountryResults)[0]['confirmed'].toString();
                              recovered = jsonDecode(searchedCountryResults)[0]['recovered'].toString();
                              critical = jsonDecode(searchedCountryResults)[0]['critical'].toString();
                              deaths = jsonDecode(searchedCountryResults)[0]['deaths'].toString();
                              setState(() {
                                showSpinner=false;
                              });
                            }),
                        SizedBox(height: 10,),
                        ResultsColumn(confirmedCases: confirmedCases, recovered: recovered, critical: critical, deaths: deaths,countryCode: dropDownItemValue,),
                      ],
                    ),
                  ),
                ],
              ),
              onRefresh: () async {
                fetchData();
              }
          ),
        ));
  }
}

