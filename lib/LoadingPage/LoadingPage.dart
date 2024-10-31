import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solvro_cocktails/LoadingPage/CheckForInternet.dart';
import 'package:solvro_cocktails/Services/DataManagerSingleton.dart';
import 'package:solvro_cocktails/Services/QueryOptions.dart';

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
    DataManagerSingleton.getInstance().loadCategoriesAndGlasses();
    DataManagerSingleton.getInstance().load(QueryOptions());
    waitAndNavigate();
  }

  void waitAndNavigate() async {

    if(!await CheckForInternet.check()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Connection Error'),
            content: const Text('No internet connection. Please check your settings.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  SystemNavigator.pop(); // Exit the app// Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    while (DataManagerSingleton.getInstance().isBusy()) {
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Image(
                image: AssetImage('assets/loading.png'),
                fit: BoxFit.cover
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                  Text(
                    text,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    )
                  ),
              )
            ),
          ]
        ),
      ),

    );
  }
}