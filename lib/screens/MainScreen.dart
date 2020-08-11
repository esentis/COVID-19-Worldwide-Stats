import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../virus_data.dart';
import '../constants.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:animate_do/animate_do.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import '../components/components.dart';
import 'package:country_list_pick/country_list_pick.dart';

String gCountryCode = '';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //A new instance of VirusData to access search methods
  VirusData virusData = VirusData();

  //This is called exactly when the screen loads
  @override
  void initState() {
    super.initState();
    //Fetch Overall Data every time page loads
    fetchData();
  }

  //The method that gets initialized on page load, gets overall cases
  void fetchData() async {
    kFetchedOverallCases = await virusData.getOverallCases();
    print(kFetchedOverallCases);
    print(jsonDecode(kFetchedOverallCases)['response'][0]['cases']['total']
        .toString());
    //Set state of overall cases card
    setState(() {
      kOverallCases = jsonDecode(kFetchedOverallCases)['response'][0]['cases']
              ['total']
          .toString();
      kUpdateDate =
          jsonDecode(kFetchedOverallCases)['response'][0]['day'].toString();
      kUpdateTime =
          jsonDecode(kFetchedOverallCases)['response'][0]['time'].toString();
      kOverallNewCases = jsonDecode(kFetchedOverallCases)['response'][0]
              ['cases']['new']
          .toString();
      kOverallNewDeaths = jsonDecode(kFetchedOverallCases)['response'][0]
              ['deaths']['new']
          .toString();
      kOverallDeaths = jsonDecode(kFetchedOverallCases)['response'][0]['deaths']
              ['total']
          .toString();
      kOverallRecovered = jsonDecode(kFetchedOverallCases)['response'][0]
              ['cases']['recovered']
          .toString();
      kOverallCritical = jsonDecode(kFetchedOverallCases)['response'][0]
              ['cases']['critical']
          .toString();
    });
  }

  //Variables needed-------------------------------------------------//
  String dropDownItemValue = 'de';
  String chosenCountry;
  String countryName = '';
  bool showSpinner = false;
  String searchedCountryResults;
  String confirmedCases = '-';
  String recovered = '-';
  String critical = '-';
  String deaths = '-';

  kSelectedLanguage selectedLanguage = kSelectedLanguage.greek;
  //----------------------------------------------------------------//

  //Main build method of cases screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFffe4e4),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            //Pull the page to refresh
            child: LiquidPullToRefresh(
                height: 150,
                backgroundColor: const Color(0xFFbe5683),
                color: Colors.transparent,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          LanguagePicker(
                            onEnglishTap: () {
                              setState(() {
                                selectedLanguage = kSelectedLanguage.english;
                              });
                            },
                            distanceText: '2 meters distance',
                            onGreekTap: () {
                              setState(() {
                                selectedLanguage = kSelectedLanguage.greek;
                              });
                            },
                            usFlagBorderColor:
                                selectedLanguage == kSelectedLanguage.english
                                    ? Colors.red
                                    : Colors.transparent,
                            usFlagBackgroundColor:
                                selectedLanguage == kSelectedLanguage.english
                                    ? Colors.red
                                    : Colors.transparent,
                            grFlagBorderColor:
                                selectedLanguage == kSelectedLanguage.english
                                    ? Colors.transparent
                                    : Colors.red,
                            grFlagBackgroundColor:
                                selectedLanguage == kSelectedLanguage.english
                                    ? Colors.transparent
                                    : Colors.red,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    UpdateDate(
                      date: kUpdateTime != ''
                          ? '${kUpdateTime.substring(11, 19)} $kUpdateDate'
                          : '',
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    MainScreenCases(
                      newCases: kOverallNewCases,
                      newDeaths: kOverallNewDeaths,
                      overallCases: kOverallCases,
                    ),

                    const SizedBox(height: 40),
                    //Simple flash animation indicating the search capability
                    Flash(
                      child: Center(
                          child: Text(
                        selectedLanguage == kSelectedLanguage.greek
                            ? 'Αναζήτηση χώρας'
                            : 'Search country',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gfsNeohellenic(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //Country picker container
                    const CountrySearcher(),
                  ],
                ),
                onRefresh: () async {
                  fetchData();
                }),
          ),
        ));
  }
}
