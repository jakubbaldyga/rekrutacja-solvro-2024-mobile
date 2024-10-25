import 'package:flutter/material.dart';

import 'LoadingPage/LoadingPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String appName = "Cocktails";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoadingPage(),
    );
  }
}

/*
1 - loading screen and check if there is network and is able to fetch data
2 - once data is fetched, show the list of cocktails
3 - once cocktails are shown, user can click on a cocktail to see the details
4 - once user clicks on a cocktail, show the details of the cocktail (it comes from the bottom and goes up)
*/