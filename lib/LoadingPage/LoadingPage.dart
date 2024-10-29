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
    DataManagerSingleton.getInstance().load(QueryOptions());
    waitAndNavigate();
  }

  void waitAndNavigate() async {

    if(!await CheckForInternet.check()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Connection Error'),
            content: Text('No internet connection. Please check your settings.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  SystemNavigator.pop(); // Exit the app// Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

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
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
                image: AssetImage('assets/loading.png'),
                fit: BoxFit.cover
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                  Text(
                    text,
                    style: TextStyle(
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