import 'dart:convert';
import 'constants.dart';
import 'networking.dart';


//Our main app brain ,here are all the functions
class VirusData {
  NetworkHelper networkOverallCases = new NetworkHelper(url: totalsUrl);

  //A methods that calls API for Cases by Country name
  Future<String> getOverallConfirmedCases() async {
    var overallCasesData = await networkOverallCases.getData();
    return jsonDecode(overallCasesData)[0]['confirmed'].toString();
  }

  //A methods that calls API for Cases by Country name
  Future<String> getCasesByCountry(String country) async {
    NetworkHelper networkByCountry =
        new NetworkHelper(url: countryUrl + country);
    var casesByCountry = await networkByCountry.getData();
    return jsonDecode(casesByCountry)[0]['confirmed'].toString();
  }

  //A methods that calls API for Cases by Country code (gr,it,fr,gb etc)
  Future<String> getCasesByCountryCode(String countryCode) async {
    NetworkHelper networkByCountryCode =
        new NetworkHelper(url: countryByCodeUrl + countryCode);
    var casesByCountryCode = await networkByCountryCode.getData();
    return jsonDecode(casesByCountryCode)[0]['confirmed'].toString();
  }

  //A method that calls for Overall Deaths
  Future<String> getOverallDeaths() async {
    var overallDeathsData = await networkOverallCases.getData();
    return jsonDecode(overallDeathsData)[0]['deaths'].toString();
  }
}
