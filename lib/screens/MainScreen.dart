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
    print(jsonDecode(kFetchedOverallCases)['response'][0]['cases']['total'].toString());
    //Set state of overall cases card
    setState(() {
      kOverallCases =
          jsonDecode(kFetchedOverallCases)['response'][0]['cases']['total'].toString();
      kOverallDeaths = jsonDecode(kFetchedOverallCases)['response'][0]['deaths']['total'].toString();
      kOverallRecovered =
          jsonDecode(kFetchedOverallCases)['response'][0]['cases']['recovered'].toString();
      kOverallCritical =
          jsonDecode(kFetchedOverallCases)['response'][0]['cases']['critical'].toString();
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
        backgroundColor: const Color(0xFF202040),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            //Pull the page to refresh
            child: LiquidPullToRefresh(
                height: 150,
                backgroundColor: const Color(0xFF202040),
                color: Colors.white,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              LanguagePicker(
                                languageFlag: Image.asset(
                                  'flags/us.png',
                                  package: 'country_list_pick',
                                  scale: 4,
                                ),
                                onTapped: () {
                                  setState(() {
                                    selectedLanguage =
                                        kSelectedLanguage.english;
                                  });
                                },
                                borderColor: selectedLanguage ==
                                    kSelectedLanguage.english
                                    ? Colors.red
                                    : Colors.white,
                                backgroundColor: selectedLanguage ==
                                        kSelectedLanguage.english
                                    ? Colors.red
                                    : Colors.white,
                                borderWidth: 2,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  CustomPaint(
                                    painter: MyPainter(),
                                    child: const SizedBox(
                                      width: 110,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '2 meters distance',
                                    style: GoogleFonts.gfsNeohellenic(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomPaint(
                                    painter: MyPainter(),
                                    child: const SizedBox(
                                      width: 110,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              LanguagePicker(
                                languageFlag: Image.asset(
                                  'flags/gr.png',
                                  package: 'country_list_pick',
                                  scale: 4.5,
                                ),
                                onTapped: () {
                                  setState(() {
                                    selectedLanguage = kSelectedLanguage.greek;
                                  });
                                },
                                borderColor:
                                    selectedLanguage == kSelectedLanguage.greek
                                        ? Colors.red
                                        : Colors.white,
                                backgroundColor:
                                    selectedLanguage == kSelectedLanguage.greek
                                        ? Colors.red
                                        : Colors.white,
                                borderWidth: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Text(
                        'Worldwide cases',
                        style: GoogleFonts.gfsNeohellenic(
                            fontSize: 25, color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Text(
                        kOverallCases,
                        style: GoogleFonts.gfsNeohellenic(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
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
                    Container(
                      child: CountryListPick(
                        // to show or hide flag
                        isShowFlag: true,
                        // true to show  title country or false to code phone country
                        isShowTitle: true,
                        // to show or hide down icon
                        isDownIcon: true,
                        isShowCode: true,
                        showEnglishName: true,
                        // to get feedback data from picker
                        onChanged: (CountryCode countryCode) async {
                          var arguments = [
                            countryCode.code.toLowerCase(),
                            countryCode.flagUri,
                            countryCode.name
                          ];
                          await Get.toNamed('/countryScreen', arguments: arguments);
                        },
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

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var arrowLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = Colors.white;
    canvas.drawLine(Offset.zero, const Offset(110, 0), arrowLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}