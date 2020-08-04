import 'constants.dart';
import 'networking.dart';

//Our main app brain ,here are all the functions
class VirusData {
  NetworkHelper networkOverallCases = NetworkHelper(url: totalsUrl);

  //Method that calls API for overall cases data.
  Future<dynamic> getOverallCases() async {
    var overallCasesData = await networkOverallCases.getData();
    return overallCasesData;
  }

  //A methods that calls API for Cases by Country name
  Future<dynamic> getCasesByCountryName(String country) async {
    var networkByCountry =
        NetworkHelper(url: countryUrl + country);
    var casesByCountryName = await networkByCountry.getData();
    return casesByCountryName;
  }
  //Method for getting report for country on specific date
  Future<String> dailyReportByCountryCode(
      String countryName, String date) async {
    //2020-04-01
    var dailyReportUrl =
        'https://covid-193.p.rapidapi.com/history?day=$date&country=$countryName';
    var networkByCountryCode =
        NetworkHelper(url: dailyReportUrl);
    var dailyReportByCountryCode = await networkByCountryCode.getData();
    return dailyReportByCountryCode;
  }
}
