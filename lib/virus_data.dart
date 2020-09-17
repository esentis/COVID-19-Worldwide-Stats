import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'constants.dart';

BaseOptions httpOptions = BaseOptions(
    baseUrl: 'https://covid-193.p.rapidapi.com',
    receiveDataWhenStatusError: true,
    connectTimeout: 6 * 1000, // 6 seconds
    receiveTimeout: 6 * 1000,
    headers: {
      'x-rapidapi-host': DotEnv().env['API_HOST'],
      'x-rapidapi-key': DotEnv().env['API_KEY']
    } // 6 seconds
    );
Dio http = Dio(httpOptions);

/// Returns overall cases.
Future<dynamic> getAllCases() async {
  Response response;
  try {
    response = await http.get('/statistics?country=All');
    logger.i('Getting date report.');
  } on DioError catch (e) {
    logger.e(e);
    return e.type;
  }
  return response.data;
}

/// Returns cases using [country] name.
Future<dynamic> getCases(String country) async {
  Response response;
  try {
    response = await http
        .get('https://covid-193.p.rapidapi.com/statistics?country=$country');
    logger.i('Getting cases for $country.');
  } on DioError catch (e) {
    logger.e(e);
    return e.type;
  }
  return response.data;
}

/// Returns [country] report on specific [date].
Future<dynamic> dateReport(String country, String date) async {
  Response response;
  try {
    response = await http.get('/history?day=$date&country=$country');
    logger.i('Getting date report.');
  } on DioError catch (e) {
    logger.e(e);
    return e.type;
  }
  return response.data;
}
