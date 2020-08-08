import 'package:flutter/material.dart';

//LIST OF CONSTANTS USED ACROSS THE APP
String kOverallCases = '';
String kOverallDeaths = '';
String kOverallNewDeaths = '';
String kOverallNewCases = '';
String kOverallCritical = '';
String kUpdateDate = '';
String kUpdateTime = '';
String kOverallRecovered = '';
String kCasesByCountry = '';
String kCasesByCountryGR = '';
String kCasesByCountryCode = '';
String kFetchedOverallCases;
String kFetchedOverallDeaths;
String kFetchedCasesByCountry;
String kFetchedCasesByCountryGR;
String kFetchedCasesByCountryCode;

enum kSelectedLanguage { greek, english }

const kResultsNumberStyle =
    TextStyle(fontSize: 25, fontFamily: 'Cardo', color: Colors.white);
const kResultsTextStyle = TextStyle(fontSize: 24, fontFamily: 'Cardo');
const kOverallTextStyle =
    TextStyle(fontSize: 30, fontFamily: 'Cardo', color: Colors.white);
//THE API URLS THAT OUR APP CALLS
const String totalsUrl = 'https://covid-193.p.rapidapi.com/statistics?country=All';
const String countryUrl =
    'https://covid-193.p.rapidapi.com/statistics?country=';
const String countryByCodeUrl =
    'https://covid-19-data.p.rapidapi.com/country/code?format=undefined&code=';
const String dailyReportUrl =
    'https://covid-19-data.p.rapidapi.com/report/country/code?format=json&date-format=YYYY-MM-DD&date=2020-04-01&code=it';
