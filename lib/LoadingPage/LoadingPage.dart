import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/DataManagerSingleton.dart';

import '../MainPage/MainPage.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String text = "Loading...";

  @override
  void initState() {
    super.initState();
    DataManagerSingleton.getInstance().loadNextCocktails();
    waitAndNavigate();
  }

  void waitAndNavigate() async {
    while (DataManagerSingleton.getInstance().isBusy()) {
      await Future.delayed(Duration(milliseconds: 1000));
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),

    );
  }
}