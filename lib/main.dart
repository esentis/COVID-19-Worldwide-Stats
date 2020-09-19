import 'package:covid19worldwide/screens/CountryScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/MainScreen.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => MainScreen(),
          transition: Transition.size,
        ),
        GetPage(
            name: '/countryScreen',
            page: () => CountryScreen(),
            transition: Transition.zoom),
      ],
      //Using the dark theme
      //Redirecting to the MainScreen.dart
      theme: ThemeData.dark().copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
      ),
    );
  }
}
