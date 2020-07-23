import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../virus_data.dart';

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

bool showSpinner = true;
String countryCode = '';
List<String> resultsList = ['', '', '', ''];
List arguments = ['', '', ''];

class _CountryScreenState extends State<CountryScreen> {
  VirusData virusData = new VirusData();

  //Method that updates the searched country UI
  Future<void> updateUI(String code) async {
    List<String> results;
    var searchedCountryResults = await virusData.getCasesByCountryCode(code);
    var confirmedCases =
        jsonDecode(searchedCountryResults)[0]['confirmed'].toString();
    var recovered =
        jsonDecode(searchedCountryResults)[0]['recovered'].toString();
    var critical = jsonDecode(searchedCountryResults)[0]['critical'].toString();
    var deaths = jsonDecode(searchedCountryResults)[0]['deaths'].toString();
    print("CONFIRMED CASES $confirmedCases");
    print("RECOVERED CASES $recovered");
    print("CRITICAL CASES $critical");
    print("DEATHS $deaths");
    results = [confirmedCases, recovered, critical, deaths];
    resultsList = results;
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    arguments = Get.arguments;
    updateUI(arguments[0]);
    countryCode = arguments[0];
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFF202040),
            body: Center(
              child: Column(
                children: [
                  Text(
                    arguments[2],
                    style: GoogleFonts.gfsNeohellenic(
                        fontSize: 30, color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(160),
                    child: Image.asset(
                      arguments[1],
                      package: 'country_list_pick',
                      scale: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "${resultsList[0].toString()} overall",
                        style: GoogleFonts.gfsNeohellenic(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${resultsList[1].toString()} recovered",
                        style: GoogleFonts.gfsNeohellenic(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${resultsList[2].toString()} critical",
                        style: GoogleFonts.gfsNeohellenic(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${resultsList[3].toString()} deaths",
                        style: GoogleFonts.gfsNeohellenic(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
//                      FlatButton(
//                          onPressed: () {
//                            DatePicker.showDatePicker(context,
//                                showTitleActions: true,
//                                minTime: DateTime(2020, 2, 5),
//                                maxTime: DateTime(2020, 6, 7),
//                                onChanged: (date) {
//                              print('change $date');
//                            }, onConfirm: (date) async {
//                              print('confirm $date');
//
//                              //YYYY-MM-DD
//                              var dateForSearch =
//                                  "${date.year}-${date.month}-${date.day}";
//                              var response =
//                                  await virusData.dailyReportByCountryCode(
//                                      countryCode, dateForSearch);
//                              print(response);
//                              print(
//                                  "The country is ${countryCode} and on $dateForSearch it had ${jsonDecode(response)[0]['provinces'][0]['confirmed'] ?? "zero"} confirmed cases ");
//                            },
//                                currentTime: DateTime.now(),
//                                locale: LocaleType.en);
//                          },
//                          child: Text(
//                            'Date Picker',
//                            style: TextStyle(color: Colors.blue),
//                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
