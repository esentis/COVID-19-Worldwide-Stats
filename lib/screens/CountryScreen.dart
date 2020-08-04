import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
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
String countryName = '';
List<String> resultsList = ['', '', '', ''];
List arguments = ['', '', ''];
List dates = [
  '2020-04-01',
  '2020-04-15',
  '2020-05-01',
  '2020-05-15',
  '2020-06-01',
  '2020-06-15',
  '2020-07-01',
  '2020-07-15',
  '2020-08-01',
];
List<double> casesByDate = [0, 0, 0, 0, 0, 0, 0, 0, 0];

class _CountryScreenState extends State<CountryScreen> {
  VirusData virusData = new VirusData();

  //Method that updates the searched country UI
  Future<void> updateUI(String name) async {
    var searchedCountryResults = await virusData.getCasesByCountryName(name);
    print(searchedCountryResults);
    try {
      resultsList[0] = jsonDecode(searchedCountryResults)['response'][0]
              ['cases']['total']
          .toString();
      resultsList[1] = jsonDecode(searchedCountryResults)['response'][0]
              ['cases']['recovered']
          .toString();
      resultsList[2] = jsonDecode(searchedCountryResults)['response'][0]
              ['cases']['critical']
          .toString();
      resultsList[3] = jsonDecode(searchedCountryResults)['response'][0]
              ['deaths']['total']
          .toString();
    } catch (e) {
      print (e.toString());
      resultsList = ['-', '-', '-', '-'];
    }
  }

  Future<void> getCountryReport() async {
    setState(() {
      showSpinner = true;
    });
    //YYYY-MM-DD
    for (var i = 0; i < dates.length; i++) {
      var response =
          await virusData.dailyReportByCountryCode(countryName, dates[i]);
      try {
        casesByDate[i] =
            jsonDecode(response)['response'][0]['cases']['total'].toDouble();
        print(casesByDate);
      } catch (e) {
        print(e.toString());
        casesByDate[i] = 0;
      }
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    arguments = Get.arguments;
    updateUI(arguments[2]);
    countryCode = arguments[0];
    countryName = arguments[2];
    getCountryReport();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFF202040),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      arguments[2],
                      style: GoogleFonts.gfsNeohellenic(
                          fontSize: 35, color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(160),
                          child: Image.asset(
                            arguments[1],
                            package: 'country_list_pick',
                            scale: 1.5,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "${resultsList[0].toString()} overall",
                              style: GoogleFonts.gfsNeohellenic(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${resultsList[1].toString()} recovered",
                              style: GoogleFonts.gfsNeohellenic(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${resultsList[2].toString()} critical",
                              style: GoogleFonts.gfsNeohellenic(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${resultsList[3].toString()} deaths",
                              style: GoogleFonts.gfsNeohellenic(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(),
                LineChart(
                  LineChartData(
                    backgroundColor: Colors.transparent,
                    axisTitleData: FlAxisTitleData(
                      bottomTitle: AxisTitle(
                          titleText: 'Dates',
                          showTitle: true,
                          textStyle: GoogleFonts.gfsNeohellenic(fontSize: 25)),
                      leftTitle: AxisTitle(
                          titleText: 'Active Cases',
                          showTitle: true,
                          textStyle: GoogleFonts.gfsNeohellenic(fontSize: 25)),
                      topTitle: AxisTitle(
                          titleText: 'Active Cases timeline',
                          showTitle: true,
                          textStyle: GoogleFonts.gfsNeohellenic(fontSize: 25)),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        show: true,
                        curveSmoothness: 0.5,
                        belowBarData: BarAreaData(
                          show: true,
                          colors: [
                            Colors.blueGrey.withOpacity(0.5),
                            Colors.red
                          ],
                        ),
                        shadow: Shadow(
                          color: Colors.white,
                        ),
                        barWidth: 3,
                        spots: [
                          FlSpot(1, casesByDate[0]),
                          FlSpot(2, casesByDate[1]),
                          FlSpot(3, casesByDate[2]),
                          FlSpot(4, casesByDate[3]),
                          FlSpot(5, casesByDate[4]),
                          FlSpot(6, casesByDate[5]),
                          FlSpot(7, casesByDate[6]),
                        ],
                        preventCurveOverShooting: true,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.grey.withOpacity(0.5),
                          Colors.red,
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox()
              ],
            ),
          ),
        ));
  }
}
