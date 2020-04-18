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

const kResultsNumberStyle = TextStyle(fontSize: 25, fontFamily: 'Baloo');
const kResultsTextStyle = TextStyle(fontSize: 24, fontFamily: 'Baloo');
const kOverallTextStyle = TextStyle(fontSize: 30, fontFamily: 'Cardo');
//THE API URLS THAT OUR APP CALLS
const String totalsUrl = 'https://covid-19-data.p.rapidapi.com/totals';
const String countryUrl =
    'https://covid-19-data.p.rapidapi.com/country?format=undefined&name=';
const String countryByCodeUrl =
    'https://covid-19-data.p.rapidapi.com/country/code?format=undefined&code=';

List<DropdownMenuItem> kCountryFlags = [
  DropdownMenuItem<String>(
      value: 'de',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 3.0,
                color: Colors.white,
              ),
            ),
            child: Image.asset('icons/flags/png/de.png',
                package: 'country_icons')),
      )),
  DropdownMenuItem<String>(value: 'us', child: CountryIcon(countryCode: 'us')),
  DropdownMenuItem<String>(value: 'gr', child: CountryIcon(countryCode: 'gr')),
  DropdownMenuItem<String>(value: 'gb', child: CountryIcon(countryCode: 'gb')),
  DropdownMenuItem<String>(value: 'fr', child: CountryIcon(countryCode: 'fr')),
  DropdownMenuItem<String>(value: 'it', child: CountryIcon(countryCode: 'it')),
  DropdownMenuItem<String>(value: 'es', child: CountryIcon(countryCode: 'es')),
  DropdownMenuItem<String>(value: 'nl', child: CountryIcon(countryCode: 'nl')),
  DropdownMenuItem<String>(value: 'br', child: CountryIcon(countryCode: 'br')),
  DropdownMenuItem<String>(value: 'cn', child: CountryIcon(countryCode: 'cn')),
  DropdownMenuItem<String>(value: 'ir', child: CountryIcon(countryCode: 'ir')),
  DropdownMenuItem<String>(value: 'tr', child: CountryIcon(countryCode: 'tr')),
  DropdownMenuItem<String>(value: 'bg', child: CountryIcon(countryCode: 'bg')),
  DropdownMenuItem<String>(value: 'ru', child: CountryIcon(countryCode: 'ru')),
  DropdownMenuItem<String>(value: 'ge', child: CountryIcon(countryCode: 'ge')),
];

class CountryIcon extends StatelessWidget {
  const CountryIcon({this.countryCode});
  final String countryCode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 2, color: Colors.white)),
          child: Image.asset('icons/flags/png/$countryCode.png',
              package: 'country_icons')),
    );
  }
}
