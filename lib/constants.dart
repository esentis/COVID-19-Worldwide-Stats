import 'package:flutter/material.dart';

//LIST OF CONSTANTS USED ACROSS THE APP
String kOverallCases = '';
String kOverallDeaths = '';
String kOverallCritical = '';
String kOverallRecovered = '';
String kCasesByCountry = '';
String kCasesByCountryGR = '';
String kCasesByCountryCode = '';
String kFetchedOverallCases;
String kFetchedOverallDeaths;
String kFetchedCasesByCountry;
String kFetchedCasesByCountryGR;
String kFetchedCasesByCountryCode;

const kResultsNumberStyle = TextStyle(fontSize: 25, fontFamily: 'Baloo',color: Colors.white);
const kResultsTextStyle = TextStyle(fontSize: 24, fontFamily: 'Baloo');
const kOverallTextStyle = TextStyle(fontSize: 30, fontFamily: 'Cardo',color: Colors.white);
//THE API URLS THAT OUR APP CALLS
const String totalsUrl = 'https://covid-19-data.p.rapidapi.com/totals';
const String countryUrl =
    'https://covid-19-data.p.rapidapi.com/country?format=undefined&name=';
const String countryByCodeUrl =
    'https://covid-19-data.p.rapidapi.com/country/code?format=undefined&code=';
