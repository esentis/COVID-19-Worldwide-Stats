import 'constants.dart';
import 'networking.dart';

//Our main app brain ,here are all the functions
class VirusData {
  NetworkHelper networkOverallCases = NetworkHelper(url: totalsUrl);

  /// Returns overall cases.
  Future<dynamic> getOverallCases() async {
    var overallCasesData = await networkOverallCases.getData();
    return overallCasesData;
  }

  /// Returns cases using [country] name.
  Future<dynamic> getCasesByCountryName(String country) async {
    var networkByCountry = NetworkHelper(url: countryUrl + country);
    var casesByCountryName = await networkByCountry.getData();
    return casesByCountryName;
  }

  /// Returns [country] report on specific [date].
  Future<String> dailyReportByCountryCode(String country, String date) async {
    //2020-04-01
    var dailyReportUrl =
        'https://covid-193.p.rapidapi.com/history?day=$date&country=$country';
    var networkByCountryCode = NetworkHelper(url: dailyReportUrl);
    var dailyReportByCountryCode = await networkByCountryCode.getData();
    return dailyReportByCountryCode;
  }
}
