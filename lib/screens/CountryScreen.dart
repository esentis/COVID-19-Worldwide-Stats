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
List<String> resultsList = ['', '', '', '', '', '', ''];
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
bool seperator = false;

class _CountryScreenState extends State<CountryScreen> {
  VirusData virusData = VirusData();

  //Method that updates the searched country UI
  Future<void> updateUI(String name) async {
    var searchedCountryResults = await virusData.getCases(name);
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
      resultsList[4] =
          jsonDecode(searchedCountryResults)['response'][0]['cases']['new'];
      resultsList[5] = jsonDecode(searchedCountryResults)['response'][0]['day'];
      resultsList[6] =
          jsonDecode(searchedCountryResults)['response'][0]['time'];
    } catch (e) {
      print(e.toString());
      resultsList = ['-', '-', '-', '-', '-', '-', '-'];
    }
  }

  /// Updates the UI by calling the HTTP method [VirusData.dateReport].
  Future<void> getCountryReport() async {
    setState(() {
      showSpinner = true;
    });
    //YYYY-MM-DD
    for (var i = 0; i < dates.length; i++) {
      var response = await virusData.dateReport(countryName, dates[i]);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        arguments[2],
                        style: GoogleFonts.gfsNeohellenic(
                            fontSize: 35, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Text(
                        'Updated on',
                        style: GoogleFonts.gfsNeohellenic(
                            fontSize: 19, color: Colors.white),
                      ),
                      Text(
                        resultsList[5] != ''
                            ? '${resultsList[5]} ${resultsList[6].substring(11, 19)}'
                            : '',
                        style: GoogleFonts.gfsNeohellenic(
                            fontSize: 19, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                arguments[1],
                                package: 'country_list_pick',
                                scale: 1.8,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${resultsList[0].toString()} overall',
                                style: GoogleFonts.gfsNeohellenic(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${resultsList[1].toString()} recovered',
                                style: GoogleFonts.gfsNeohellenic(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${resultsList[2].toString()} critical',
                                style: GoogleFonts.gfsNeohellenic(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${resultsList[3].toString()} deaths',
                                style: GoogleFonts.gfsNeohellenic(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${resultsList[4].toString()} new cases',
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
                  LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: const Color(0xff37434d),
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: const Color(0xff37434d),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          textStyle: const TextStyle(
                              color: Color(0xff68737d),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 2:
                                return dates[2].toString().substring(5, 10);
                              case 5:
                                return dates[5].toString().substring(5, 10);
                              case 8:
                                return dates[8].toString().substring(5, 10);
                            }
                            return '';
                          },
                          margin: 10,
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          textStyle: const TextStyle(
                            color: Color(0xff67727d),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          getTitles: (value) {
                            var result = seperator ? value.toString() : '';
                            seperator ? seperator = false : seperator = true;
                            return result;
                          },
                          reservedSize: 40,
                          margin: 12,
                        ),
                      ),
                      borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                              color: const Color(0xff37434d), width: 1)),
                      minX: 1,
                      maxX: 9,
                      minY: 2,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(1, casesByDate[0]),
                            FlSpot(2, casesByDate[1]),
                            FlSpot(3, casesByDate[2]),
                            FlSpot(4, casesByDate[3]),
                            FlSpot(5, casesByDate[4]),
                            FlSpot(6, casesByDate[5]),
                            FlSpot(7, casesByDate[6]),
                            FlSpot(8, casesByDate[7]),
                            FlSpot(9, casesByDate[8]),
                          ],
                          show: true,
                          isCurved: true,
                          colors: [Colors.red, Colors.green],
                          barWidth: 5,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: false,
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            colors: [Colors.red, Colors.green]
                                .map((color) => color.withOpacity(0.3))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
