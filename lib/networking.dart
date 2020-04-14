import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

//This class helps establish our connection with the API
class NetworkHelper {
  NetworkHelper({this.url});
  final String url;
  Future getData() async {
    //getting the response
    http.Response response = await http.get(url, headers: {
      'x-rapidapi-host': '${DotEnv().env['API_HOST']}',
      'x-rapidapi-key': '${DotEnv().env['API_KEY']}'
    });
    return response.body;
  }
}
