import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'virus_data.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:animate_do/animate_do.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'components.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:hover_effect/hover_effect.dart';

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
    //Fetch Overall Data every time page loads
    fetchData();
  }

  //The method that gets initialized on page load, gets overall cases
  void fetchData() async {
    kFetchedOverallCases = await virusData.getOverallCases();

    //Set state of overall cases card
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
  kSelectedLanguage selectedLanguage = kSelectedLanguage.Greek;
  //----------------------------------------------------------------//

  //Method that updates the searched country UI
  Future<void> updateUI(CountryCode code) async {
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
    countryName = code.name;
    searchedCountryResults =
        await virusData.getCasesByCountryCode(chosenCountry);
    confirmedCases =
        jsonDecode(searchedCountryResults)[0]['confirmed'].toString();
    recovered = jsonDecode(searchedCountryResults)[0]['recovered'].toString();
    critical = jsonDecode(searchedCountryResults)[0]['critical'].toString();
    deaths = jsonDecode(searchedCountryResults)[0]['deaths'].toString();
    setState(() {
      showSpinner = false;
    });
  }

  //Main build method of cases screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF202040),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            //Pull the page to refresh
            child: LiquidPullToRefresh(
                height: 150,
                backgroundColor: Color(0xFF202040),
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
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
                                        kSelectedLanguage.English;
                                  });
                                },
                                borderColor: selectedLanguage ==
                                    kSelectedLanguage.English
                                    ? Colors.red
                                    : Colors.white,
                                backgroundColor: selectedLanguage ==
                                    kSelectedLanguage.English
                                    ? Colors.red
                                    : Colors.white,
                                borderWidth: 2,
                              ),
                              SizedBox(
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
                                    selectedLanguage =
                                        kSelectedLanguage.Greek;
                                  });
                                },
                                borderColor: selectedLanguage ==
                                    kSelectedLanguage.Greek
                                    ? Colors.red
                                    : Colors.white,
                                backgroundColor: selectedLanguage ==
                                    kSelectedLanguage.Greek
                                    ? Colors.red
                                    : Colors.white,
                                borderWidth: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Center(
                              //WORLDWIDE TITLE HEADER
                              child: Text(
                            selectedLanguage == kSelectedLanguage.Greek
                                ? 'Παγκόσμια'
                                : 'Worldwide',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Cardo',
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w900),
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //CONTAINER WITH OVERALL CASES
                              Expanded(
                                child: Container(
                                  width: 150,
                                  height: 120,
                                  child: HoverCard(
                                    builder: (context, hovering) {
                                      return Container(
                                        color: Color(0xFFE9E9E9),
                                        child: Center(
                                          child: FadeInLeft(
                                            //Searched worldwide overall cases card
                                            child: CaseCard(
                                              text: selectedLanguage ==
                                                      kSelectedLanguage.Greek
                                                  ? 'Κρούσματα'
                                                  : 'Cases',
                                              fontSize: 23,
                                              icon: FontAwesomeIcons.virus,
                                              results: kOverallCases,
                                              backgroundColor:
                                                  Color(0xFF363636),
                                              iconColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    depth: 10,
                                    depthColor: Colors.grey[500],
                                    onTap: () => print('Hello, World!'),
                                    shadow: BoxShadow(
                                        color: Colors.purple[200],
                                        blurRadius: 30,
                                        spreadRadius: -20,
                                        offset: Offset(0, 40)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              //CONTAINER WITH SEARCHED RECOVERED
                              Expanded(
                                child: Container(
                                  width: 150,
                                  height: 120,
                                  child: HoverCard(
                                    builder: (context, hovering) {
                                      return Container(
                                        color: Color(0xFFE9E9E9),
                                        child: Center(
                                          child: FadeInLeft(
                                            //Searched worldwide recovered cases card
                                            child: CaseCard(
                                              text: selectedLanguage ==
                                                      kSelectedLanguage.Greek
                                                  ? 'Επανήλθαν'
                                                  : 'Recovered',
                                              fontSize: 23,
                                              icon: FontAwesomeIcons.thumbsUp,
                                              results: kOverallRecovered,
                                              backgroundColor: Colors.green,
                                              iconColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    depth: 10,
                                    depthColor: Colors.grey[500],
                                    onTap: () => print('Hello, World!'),
                                    shadow: BoxShadow(
                                        color: Colors.purple[200],
                                        blurRadius: 30,
                                        spreadRadius: -20,
                                        offset: Offset(0, 40)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //CONTAINER WITH SEARCHED CRITICAL
                              Expanded(
                                child: Container(
                                  width: 150,
                                  height: 120,
                                  child: HoverCard(
                                    builder: (context, hovering) {
                                      return Container(
                                        color: Color(0xFFE9E9E9),
                                        child: Center(
                                          child: FadeInLeft(
                                            //Searched worldwide critical cases card
                                            child: CaseCard(
                                              text: selectedLanguage ==
                                                      kSelectedLanguage.Greek
                                                  ? 'Κρίσιμα'
                                                  : 'Critical',
                                              fontSize: 23,
                                              icon:
                                                  FontAwesomeIcons.exclamation,
                                              results: kOverallCritical,
                                              backgroundColor:
                                                  Color(0xFFff5722),
                                              iconColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    depth: 10,
                                    depthColor: Colors.grey[500],
                                    onTap: () => print('Hello, World!'),
                                    shadow: BoxShadow(
                                        color: Colors.purple[200],
                                        blurRadius: 30,
                                        spreadRadius: -20,
                                        offset: Offset(0, 40)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              //CONTAINER WITH SEARCHED DEATHS
                              Expanded(
                                child: Container(
                                  width: 150,
                                  height: 120,
                                  child: HoverCard(
                                    builder: (context, hovering) {
                                      return Container(
                                        color: Color(0xFFE9E9E9),
                                        child: Center(
                                          child: FadeInLeft(
                                            //Searched worldwide deaths card
                                            child: CaseCard(
                                              text: selectedLanguage ==
                                                      kSelectedLanguage.Greek
                                                  ? 'Θανατοι'
                                                  : 'Deaths',
                                              fontSize: 23,
                                              icon: FontAwesomeIcons.skull,
                                              results: kOverallDeaths,
                                              backgroundColor:
                                                  Color(0xFFc70039),
                                              iconColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    depth: 10,
                                    depthColor: Colors.grey[500],
                                    onTap: () => print('Hello, World!'),
                                    shadow: BoxShadow(
                                        color: Colors.purple[200],
                                        blurRadius: 30,
                                        spreadRadius: -20,
                                        offset: Offset(0, 40)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    //Simple flash animation indicating the search capability
                    Flash(
                      child: Center(
                          child: Text(
                        selectedLanguage == kSelectedLanguage.Greek
                            ? 'Αναζήτηση χώρας'
                            : 'Search country',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Cardo',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //Country picker container
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
                        onChanged: (CountryCode code) async {
                          updateUI(code);
                        },
                      ),
                    ),
//                    Image.asset('flags/aq.png',package: 'country_list_pick',scale: 1.5,),
                    //COUNTRY NAME TITLE
                    Center(
                        child: Text(
                      countryName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Cardo',
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w900),
                    )),
                    //HERE STARTS THE RESULTS CARDS
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //CONTAINER WITH SEARCHED CASES
                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      height: 120,
                                      child: HoverCard(
                                        builder: (context, hovering) {
                                          return Container(
                                            color: Color(0xFFE9E9E9),
                                            child: Center(
                                              child: FadeInLeft(
                                                //Searched overall cases card
                                                child: CaseCard(
                                                  text: selectedLanguage ==
                                                          kSelectedLanguage
                                                              .Greek
                                                      ? 'Κρούσματα'
                                                      : 'Cases',
                                                  fontSize: 23,
                                                  icon: FontAwesomeIcons.virus,
                                                  results: confirmedCases,
                                                  backgroundColor:
                                                      Color(0xFF363636),
                                                  iconColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        depth: 10,
                                        depthColor: Colors.grey[500],
                                        onTap: () => print('Hello, World!'),
                                        shadow: BoxShadow(
                                            color: Colors.purple[200],
                                            blurRadius: 30,
                                            spreadRadius: -20,
                                            offset: Offset(0, 40)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  //CONTAINER WITH SEARCHED RECOVERED
                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      height: 120,
                                      child: HoverCard(
                                        builder: (context, hovering) {
                                          return Container(
                                            color: Color(0xFFE9E9E9),
                                            child: Center(
                                              child: FadeInLeft(
                                                //Searched recovered cases card
                                                child: CaseCard(
                                                  text: selectedLanguage ==
                                                          kSelectedLanguage
                                                              .Greek
                                                      ? 'Επανήλθαν'
                                                      : 'Recovered',
                                                  fontSize: 23,
                                                  icon:
                                                      FontAwesomeIcons.thumbsUp,
                                                  results: recovered,
                                                  backgroundColor: Colors.green,
                                                  iconColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        depth: 10,
                                        depthColor: Colors.grey[500],
                                        onTap: () => print('Hello, World!'),
                                        shadow: BoxShadow(
                                            color: Colors.purple[200],
                                            blurRadius: 30,
                                            spreadRadius: -20,
                                            offset: Offset(0, 40)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //CONTAINER WITH SEARCHED CRITICAL
                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      height: 120,
                                      child: HoverCard(
                                        builder: (context, hovering) {
                                          return Container(
                                            color: Color(0xFFE9E9E9),
                                            child: Center(
                                              child: FadeInLeft(
                                                //Searched critical cases card
                                                child: CaseCard(
                                                  text: selectedLanguage ==
                                                          kSelectedLanguage
                                                              .Greek
                                                      ? 'Κρίσιμα'
                                                      : 'Critical',
                                                  fontSize: 23,
                                                  icon: FontAwesomeIcons
                                                      .exclamation,
                                                  results: critical,
                                                  backgroundColor:
                                                      Color(0xFFff5722),
                                                  iconColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        depth: 10,
                                        depthColor: Colors.grey[500],
                                        onTap: () => print('Hello, World!'),
                                        shadow: BoxShadow(
                                            color: Colors.purple[200],
                                            blurRadius: 30,
                                            spreadRadius: -20,
                                            offset: Offset(0, 40)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  //CONTAINER WITH SEARCHED DEATHS
                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      height: 120,
                                      child: HoverCard(
                                        builder: (context, hovering) {
                                          return Container(
                                            color: Color(0xFFE9E9E9),
                                            child: Center(
                                              child: FadeInLeft(
                                                child: CaseCard(
                                                  //Searched death cases card
                                                  text: selectedLanguage ==
                                                          kSelectedLanguage
                                                              .Greek
                                                      ? 'Θάνατοι'
                                                      : 'Deaths',
                                                  fontSize: 23,
                                                  icon: FontAwesomeIcons.skull,
                                                  results: deaths,
                                                  backgroundColor:
                                                      Color(0xFFc70039),
                                                  iconColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        depth: 10,
                                        depthColor: Colors.grey[500],
                                        onTap: () => print('Hello, World!'),
                                        shadow: BoxShadow(
                                            color: Colors.purple[200],
                                            blurRadius: 30,
                                            spreadRadius: -20,
                                            offset: Offset(0, 40)),
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
