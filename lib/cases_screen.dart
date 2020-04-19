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
import 'package:country_list_pick/country_list_pick.dart';

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
  String chosenCountry;
  String countryName = '';
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
          child: SafeArea(
            child: LiquidPullToRefresh(
                backgroundColor: Colors.blueAccent,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Column(
                      children: <Widget>[
                        Center(child: Text(
                          'Worldwide',
                          textAlign: TextAlign.center,
                          style : TextStyle(
                              fontFamily: 'Baloo',
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w900
                          ),)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: FadeInLeft(
                                child: CaseCard(
                                  text: 'Κρούσματα',
                                  fontSize: 23,
                                  icon: FontAwesomeIcons.virus,
                                  results: kOverallCases,
                                  backgroundColor: Color(0xFF363636),
                                  iconColor: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: FadeInLeft(
                                child: CaseCard(
                                  text: 'Επανήλθαν',
                                  fontSize: 23,
                                  icon: FontAwesomeIcons.thumbsUp,
                                  results: kOverallRecovered,
                                  backgroundColor: Colors.green,
                                  iconColor: Colors.white,
                                ),
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
                            Expanded(
                              child: FadeInLeft(
                                child: CaseCard(
                                  text: 'Κρίσιμα',
                                  fontSize: 23,
                                  icon: FontAwesomeIcons.exclamation,
                                  results: kOverallCritical,
                                  backgroundColor: Color(0xFFff5722),
                                  iconColor: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: FadeInLeft(
                                child: CaseCard(
                                  text: 'Θάνατοι',
                                  fontSize: 23,
                                  icon: FontAwesomeIcons.skull,
                                  results: kOverallDeaths,
                                  backgroundColor: Color(0xFFc70039),
                                  iconColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Flash(
                      child: Center(child: Text(
                        'Search country',
                        textAlign: TextAlign.center,
                        style : TextStyle(
                            fontFamily: 'Baloo',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900
                        ),)),
                    ),
                    Container(
                      color: Colors.white,
                      child: CountryListPick(
                        // to show or hide flag
                        isShowFlag: true,
                        // true to show  title country or false to code phone country
                        isShowTitle: true,
                        // to show or hide down icon
                        isDownIcon: true,
                        // to initial code number country
                        initialSelection: '+62',
                        // to get feedback data from picker
                        onChanged: (CountryCode code) async{
                          // name of country
                          print(code.name);
                          // code of country
                          print(code.code);
                          // code phone of country
                          print(code.dialCode);
                          // path flag of country
                          print(code.flagUri);
                            showSpinner = true;
                            chosenCountry = code.code.toLowerCase();
                            countryName=code.name;
                            searchedCountryResults = await virusData
                                .getCasesByCountryCode(chosenCountry);
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
                        },
                      ),
                    ),
//                    Image.asset('flags/aq.png',package: 'country_list_pick',scale: 1.5,),
                    SizedBox(height: 5),
                    Center(child: Text(
                      countryName,
                      textAlign: TextAlign.center,
                      style : TextStyle(
                        fontFamily: 'Baloo',
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900
                      ),)),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: FadeInLeft(
                                      child: CaseCard(
                                        text: 'Κρούσματα',
                                        fontSize: 23,
                                        icon: FontAwesomeIcons.virus,
                                        results: confirmedCases,
                                        backgroundColor: Color(0xFF363636),
                                        iconColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: FadeInLeft(
                                      child: CaseCard(
                                        text: 'Επανήλθαν',
                                        fontSize: 23,
                                        icon: FontAwesomeIcons.thumbsUp,
                                        results: recovered,
                                        backgroundColor: Colors.green,
                                        iconColor: Colors.white,
                                      ),
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
                                  Expanded(
                                    child: FadeInLeft(
                                      child: CaseCard(
                                        text: 'Κρίσιμα',
                                        fontSize: 23,
                                        icon: FontAwesomeIcons.exclamation,
                                        results: critical,
                                        backgroundColor: Color(0xFFff5722),
                                        iconColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: FadeInLeft(
                                      child: CaseCard(
                                        text: 'Θάνατοι',
                                        fontSize: 23,
                                        icon: FontAwesomeIcons.skull,
                                        results: deaths,
                                        backgroundColor: Color(0xFFc70039),
                                        iconColor: Colors.white,
                                      ),
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
          ),
        ));
  }
}
