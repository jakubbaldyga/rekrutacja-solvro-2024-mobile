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

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: ResponsiveGrid(),
//       ),
//     );
//   }
// }
//
// class ResponsiveGrid extends StatefulWidget {
//   @override
//   _ResponsiveGridState createState() => _ResponsiveGridState();
// }
//
// class _ResponsiveGridState extends State<ResponsiveGrid> {
//   int gridIndice = 2; // Default to 4 items per row
//
//   final List<int> gridOptions = [1, 2, 4, 8, 16];
//   late final List<double> tileSizes = [];
//   List<int> tiles = List.generate(50, (index) => index); // List of tile indices
//   final double spacing = 8.0; // Spacing between tiles
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final deviceWidth = MediaQuery.of(context).size.width;
//       for (int i = 0; i < gridOptions.length; i++) {
//         tileSizes.add((deviceWidth - (1 + gridOptions[i]) * spacing) / gridOptions[i]);
//       }
//       setState(() {}); // Trigger a rebuild if needed
//     });
//   }
//
//   void _changeGridCount() {
//     setState(() {
//       gridIndice = (gridIndice + 1) % gridOptions.length;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: _changeGridCount,
//             child: Text('Change Grid: ${gridOptions[gridIndice]} per row'),
//           ),
//         ),
//
//
//       ],
//     );
//   }
// }
//
//
//




/*
1 - loading screen and check if there is network and is able to fetch data
2 - once data is fetched, show the list of cocktails
3 - once cocktails are shown, user can click on a cocktail to see the details
4 - once user clicks on a cocktail, show the details of the cocktail (it comes from the bottom and goes up)
*/