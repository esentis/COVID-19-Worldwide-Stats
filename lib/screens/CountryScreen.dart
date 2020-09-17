import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:covid19worldwide/components/circular_result.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
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
    for (var i = 0; i < kDates.length; i++) {
      var response = await virusData.dateReport(countryName, kDates[i]);
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
          image: DecorationImage(
            image: Image.asset(
              arguments[1],
              package: 'country_list_pick',
              scale: 1,
            ).image,
            fit: BoxFit.cover,
          )
          // gradient: const LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [Color(0xFF0f4c75), Colors.white],
          // ),
          ),
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            resultsList[5] != '' && resultsList[6].length > 10
                                ? '${resultsList[5]} ${resultsList[6].substring(11, 19)}'
                                : '',
                            style: GoogleFonts.gfsNeohellenic(
                                fontSize: 19, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 179.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              image: DecorationImage(
                                image: Image.asset(
                                  arguments[1],
                                  package: 'country_list_pick',
                                  scale: 1,
                                ).image,
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                width: 1.0,
                                color: const Color(0xff000000),
                              ),
                              boxShadow: [
                                const BoxShadow(
                                  color: Color(0x29000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: CircularResult(
                              color: const Color(0xfffe7171),
                              titleFontSize: 22,
                              contentFontSize: 22,
                              width: 100,
                              height: 100,
                              title: 'Overall',
                              content: resultsList[0].toString(),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: CircularResult(
                              color: const Color(0xff81b214),
                              titleFontSize: 21,
                              contentFontSize: 22,
                              width: 100,
                              height: 100,
                              title: 'Recovered',
                              content: resultsList[1].toString(),
                            ),
                          ),
                          Positioned(
                            left: 140,
                            top: 0,
                            child: CircularResult(
                              color: Colors.red[900],
                              titleFontSize: 22,
                              contentFontSize: 22,
                              width: 100,
                              height: 100,
                              title: 'Deaths',
                              content: resultsList[3].toString(),
                            ),
                          ),
                          Positioned(
                            left: 140,
                            bottom: 0,
                            child: CircularResult(
                              color: Colors.orange[900],
                              titleFontSize: 22,
                              contentFontSize: 22,
                              width: 100,
                              height: 100,
                              title: 'Critical',
                              content: resultsList[2].toString(),
                            ),
                          ),
                          Positioned(
                            left: 280,
                            bottom: 30,
                            child: Flash(
                              child: CircularResult(
                                titleFontSize: 22,
                                contentFontSize: 25,
                                color: const Color(0xffe00543),
                                width: 120,
                                height: 120,
                                title: 'New Cases',
                                content: resultsList[4].toString(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
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
                                    return kDates[2]
                                        .toString()
                                        .substring(5, 10);
                                  case 5:
                                    return kDates[5]
                                        .toString()
                                        .substring(5, 10);
                                  case 8:
                                    return kDates[8]
                                        .toString()
                                        .substring(5, 10);
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
                                var result =
                                    seperator ? value.ceil().toString() : '';
                                seperator
                                    ? seperator = false
                                    : seperator = true;
                                return result;
                              },
                              reservedSize: 40,
                              margin: 12,
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: const Color(0xff37434d),
                              width: 1,
                            ),
                          ),
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
              ),
            )),
      ),
    );
  }
}
