
import 'constants.dart';
import 'networking.dart';


//Our main app brain ,here are all the functions
class VirusData {
  NetworkHelper networkOverallCases = new NetworkHelper(url: totalsUrl);

  //Method that calls API for overall cases data.
  Future<String> getOverallCases() async {
    var overallCasesData = await networkOverallCases.getData();
    return overallCasesData;
  }

  //A methods that calls API for Cases by Country name
  Future<String> getCasesByCountryName(String country) async {
    NetworkHelper networkByCountry =
        new NetworkHelper(url: countryUrl + country);
    var casesByCountryName = await networkByCountry.getData();
    return casesByCountryName;
  }

  //A methods that calls API for Cases by Country code (gr,it,fr,gb etc)
  Future<String> getCasesByCountryCode(String countryCode) async {
    NetworkHelper networkByCountryCode =
        new NetworkHelper(url: countryByCodeUrl + countryCode);
    var casesByCountryCode = await networkByCountryCode.getData();
    return casesByCountryCode;
  }
}
