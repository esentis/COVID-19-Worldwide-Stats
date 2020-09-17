import 'package:covid19worldwide/components/country_searcher.dart';
import 'package:covid19worldwide/components/language_picker.dart';
import 'package:covid19worldwide/components/main_screen_cases.dart';
import 'package:covid19worldwide/components/update_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../virus_data.dart';
import '../constants.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:animate_do/animate_do.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

String gCountryCode = '';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// Method that fetches and updates data.
  void fetchData() async {
    var response = await getAllCases();
    setState(() {
      kOverallCases = response['response'][0]['cases']['total'].toString();
      kUpdateDate = response['response'][0]['day'].toString();
      kUpdateTime = response['response'][0]['time'].toString();
      kOverallNewCases = response['response'][0]['cases']['new'].toString();
      kOverallNewDeaths = response['response'][0]['deaths']['new'].toString();
      kOverallDeaths = response['response'][0]['deaths']['total'].toString();
      kOverallRecovered =
          response['response'][0]['cases']['recovered'].toString();
      kOverallCritical =
          response['response'][0]['cases']['critical'].toString();
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

  var selectedLanguage = kSelectedLanguage.greek;
  //----------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF0f4c75),
            Color(0xFF1b262c),
          ],
        ),
      ),
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
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
                              distanceText:
                                  selectedLanguage == kSelectedLanguage.english
                                      ? '2 meters distance'
                                      : '2 μέτρα απόσταση',
                              onGreekTap: () {
                                setState(() {
                                  selectedLanguage = kSelectedLanguage.greek;
                                });
                              },
                              usFlagBorderColor:
                                  selectedLanguage == kSelectedLanguage.english
                                      ? const Color(0xFFebecf1).withOpacity(0.8)
                                      : Colors.transparent,
                              usFlagBackgroundColor:
                                  selectedLanguage == kSelectedLanguage.english
                                      ? const Color(0xFFebecf1).withOpacity(0.8)
                                      : Colors.transparent,
                              grFlagBorderColor: selectedLanguage ==
                                      kSelectedLanguage.english
                                  ? Colors.transparent
                                  : const Color(0xFFebecf1).withOpacity(0.8),
                              grFlagBackgroundColor: selectedLanguage ==
                                      kSelectedLanguage.english
                                  ? Colors.transparent
                                  : const Color(0xFFebecf1).withOpacity(0.8),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      UpdateDate(
                        text: selectedLanguage == kSelectedLanguage.english
                            ? 'Last update'
                            : 'Τελευταία ενημέρωση',
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
                        casesText: selectedLanguage == kSelectedLanguage.english
                            ? 'Worldwide cases'
                            : 'Παγκόσμια κρούσματα',
                        newCasesText:
                            selectedLanguage == kSelectedLanguage.english
                                ? 'New cases'
                                : 'Καινούργια κρούσματα',
                        newDeathsText:
                            selectedLanguage == kSelectedLanguage.english
                                ? 'New deaths'
                                : 'Καινούργιοι θάνατοι',
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
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFebecf1).withOpacity(0.8),
                          ),
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
            )),
      ),
    );
  }
}
