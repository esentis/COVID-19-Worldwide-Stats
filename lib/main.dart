import 'package:flutter/material.dart';
import 'cases_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


//Our main that runs the APP
Future main() async {
  //Awaiting to load our environmental variables
  await DotEnv().load('.env');
  //Starting the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Using the dark theme
      //Redirecting to the cases_screen.dart
      home: CaseScreen(),
    );
  }
}
