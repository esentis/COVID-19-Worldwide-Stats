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
List<String> resultsList = ['', '', '', ''];
List arguments = ['', '', ''];
List dates = [
  '2020-3-1',
  '2020-4-15',
  '2020-5-1',
  '2020-5-15',
  '2020-6-1',
  '2020-6-10',
  '2020-6-18',
];
List<double> casesByDate = [0, 0, 0, 0, 0, 0, 0];

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
    results = [confirmedCases, recovered, critical, deaths];
    resultsList = results;
    setState(() {
      showSpinner = false;
    });
  }

  Future<void> getCountryReport() async {
    //YYYY-MM-DD
    for (var i = 0; i < dates.length; i++) {
      var response =
      await virusData.dailyReportByCountryCode(countryCode, dates[i]);
      var active = jsonDecode(response)[0]['provinces'][0]['active'];
      print(active);
      if (active == null) {
        casesByDate[i] = 0.toDouble();
      } else {
        casesByDate[i] = active.toDouble();
      }
      print(casesByDate);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    arguments = Get.arguments;
    updateUI(arguments[0]);
    countryCode = arguments[0];
    getCountryReport();
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
                        fontSize: 35, color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
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
                      SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
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
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  LineChart(
                    LineChartData(

                      backgroundColor: Colors.transparent,
                      axisTitleData: FlAxisTitleData(
                        bottomTitle: AxisTitle(
                            titleText: 'Dates',
                            showTitle: true,
                            textStyle:
                            GoogleFonts.gfsNeohellenic(fontSize: 25)),
                        leftTitle: AxisTitle(
                            titleText: 'Active Cases',
                            showTitle: true,
                            textStyle:
                            GoogleFonts.gfsNeohellenic(fontSize: 25)),
                        topTitle: AxisTitle(
                            titleText: 'Active Cases timeline',
                            showTitle: true,
                            textStyle:
                            GoogleFonts.gfsNeohellenic(fontSize: 25)),
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
                ],
              ),
            ),
          ),
        ));
  }
}
