import 'package:flutter/material.dart';
//LIST OF CONSTANTS USED ACROSS THE APP
String kOverallCases = '';
String kOverallDeaths = '';
String kCasesByCountry = '';
String kCasesByCountryGR = '';
String kCasesByCountryCode = '';
String kFetchedOverallCases;
String kFetchedOverallDeaths;
String kFetchedCasesByCountry;
String kFetchedCasesByCountryGR;
String kFetchedCasesByCountryCode;



//THE API URLS THAT OUR APP CALLS
const String totalsUrl = 'https://covid-19-data.p.rapidapi.com/totals';
const String countryUrl =
    'https://covid-19-data.p.rapidapi.com/country?format=undefined&name=';
const String countryByCodeUrl =
    'https://covid-19-data.p.rapidapi.com/country/code?format=undefined&code=';

List<DropdownMenuItem> kCountryFlags = [
  DropdownMenuItem<String>(value:'de',child: Image.asset('icons/flags/png/de.png', package: 'country_icons')),
  DropdownMenuItem<String>(value:'gr',child: Image.asset('icons/flags/png/gr.png', package: 'country_icons')),
  DropdownMenuItem<String>(value:'gb',child: Image.asset('icons/flags/png/gb.png', package: 'country_icons')),
  DropdownMenuItem<String>(value:'fr',child: Image.asset('icons/flags/png/fr.png', package: 'country_icons')),
  DropdownMenuItem<String>(value:'it',child: Image.asset('icons/flags/png/it.png', package: 'country_icons')),
  DropdownMenuItem<String>(value:'es',child: Image.asset('icons/flags/png/es.png', package: 'country_icons')),
  DropdownMenuItem<String>(value:'br',child: Image.asset('icons/flags/png/br.png', package: 'country_icons')),
];