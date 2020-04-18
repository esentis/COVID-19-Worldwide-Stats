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
    kFetchedOverallCases = await virusData.getOverallCases();

    setState(() {
      kOverallCases =
          jsonDecode(kFetchedOverallCases)[0]['confirmed'].toString();
      kOverallDeaths = jsonDecode(kFetchedOverallCases)[0]['deaths'].toString();
      kOverallRecovered =
          jsonDecode(kFetchedOverallCases)[0]['recovered'].toString();
      kOverallCritical =
          jsonDecode(kFetchedOverallCases)[0]['critical'].toString();
    });
  }

  String dropDownItemValue = 'de';
  bool showSpinner = false;
  String searchedCountryResults;
  String confirmedCases = '-';
  String recovered = '-';
  String critical = '-';
  String deaths = '-';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF202040),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: LiquidPullToRefresh(
              backgroundColor: Colors.blueAccent,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeInLeft(
                            child: CaseCard(
                              text: 'Κρούσματα',
                              fontSize: 23,
                              icon: FontAwesomeIcons.virus,
                              results: kOverallCases,
                              backgroundColor: Color(0xFF363636),
                              iconColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FadeInLeft(
                            child: CaseCard(
                              text: 'Επανήλθαν',
                              fontSize: 23,
                              icon: FontAwesomeIcons.thumbsUp,
                              results: kOverallRecovered,
                              backgroundColor: Colors.green,
                              iconColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeInLeft(
                            child: CaseCard(
                              text: 'Κρίσιμα',
                              fontSize: 23,
                              icon: FontAwesomeIcons.exclamation,
                              results: kOverallCritical,
                              backgroundColor: Color(0xFFff5722),
                              iconColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FadeInLeft(
                            child: CaseCard(
                              text: 'Θάνατοι',
                              fontSize: 23,
                              icon: FontAwesomeIcons.skull,
                              results: kOverallDeaths,
                              backgroundColor: Color(0xFFc70039),
                              iconColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Center(
                      child: Flash(
                          child: Text(
                    'Search country',
                    style: kResultsTextStyle,
                  ))),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        //Drop down menu with country flags to search for cases
                        DropdownButton(
                            icon: Icon(FontAwesomeIcons.search),
                            underline: Container(),
                            iconSize: 35,
                            elevation: 24,
                            value: dropDownItemValue,
                            items: kCountryFlags,
                            onChanged: (value) async {
                              showSpinner = true;
                              setState(() {
                                dropDownItemValue = value;
                              });
                              searchedCountryResults = await virusData
                                  .getCasesByCountryCode(dropDownItemValue);
                              confirmedCases =
                                  jsonDecode(searchedCountryResults)[0]
                                          ['confirmed']
                                      .toString();
                              recovered = jsonDecode(searchedCountryResults)[0]
                                      ['recovered']
                                  .toString();
                              critical = jsonDecode(searchedCountryResults)[0]
                                      ['critical']
                                  .toString();
                              deaths = jsonDecode(searchedCountryResults)[0]
                                      ['deaths']
                                  .toString();
                              setState(() {
                                showSpinner = false;
                              });
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset('icons/flags/png/$dropDownItemValue.png',
                            package: 'country_icons',scale: 0.5,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FadeInLeft(
                                  child: CaseCard(
                                    text: 'Κρούσματα',
                                    fontSize: 23,
                                    icon: FontAwesomeIcons.virus,
                                    results: confirmedCases,
                                    backgroundColor: Color(0xFF363636),
                                    iconColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                FadeInLeft(
                                  child: CaseCard(
                                    text: 'Επανήλθαν',
                                    fontSize: 23,
                                    icon: FontAwesomeIcons.thumbsUp,
                                    results: recovered,
                                    backgroundColor: Colors.green,
                                    iconColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FadeInLeft(
                                  child: CaseCard(
                                    text: 'Κρίσιμα',
                                    fontSize: 23,
                                    icon: FontAwesomeIcons.exclamation,
                                    results: critical,
                                    backgroundColor: Color(0xFFff5722),
                                    iconColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                FadeInLeft(
                                  child: CaseCard(
                                    text: 'Θάνατοι',
                                    fontSize: 23,
                                    icon: FontAwesomeIcons.skull,
                                    results: deaths,
                                    backgroundColor: Color(0xFFc70039),
                                    iconColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              onRefresh: () async {
                fetchData();
              }),
        ));
  }
}
