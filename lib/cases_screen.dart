import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'virus_data.dart';
import 'constants.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:animate_do/animate_do.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'components.dart';
import 'package:country_list_pick/country_list_pick.dart';

String gCountryCode = '';

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
                                    selectedLanguage = kSelectedLanguage.Greek;
                                  });
                                },
                                borderColor:
                                    selectedLanguage == kSelectedLanguage.Greek
                                        ? Colors.red
                                        : Colors.white,
                                backgroundColor:
                                    selectedLanguage == kSelectedLanguage.Greek
                                        ? Colors.red
                                        : Colors.white,
                                borderWidth: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(kOverallCases),
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
                        onChanged: (CountryCode countryCode) async {
                          updateUI(countryCode);
                          gCountryCode = countryCode.code.toLowerCase();
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
                    FlatButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2020, 2, 5),
                              maxTime: DateTime(2020, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) async {
                            print('confirm $date');

                            //YYYY-MM-DD
                            var dateForSearch =
                                "${date.year}-${date.month}-${date.day}";
                            var response =
                                await virusData.dailyReportByCountryCode(
                                    gCountryCode, dateForSearch);
                            print(jsonDecode(response)[0]);
                            print(
                                "The country is $gCountryCode and on $dateForSearch it had confirmed cases ${jsonDecode(response)[0]['provinces'][0]['confirmed']} ");
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: Text(
                          'show date time picker (english)',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                ),
                onRefresh: () async {
                  fetchData();
                }),
          ),
        ));
  }
}
