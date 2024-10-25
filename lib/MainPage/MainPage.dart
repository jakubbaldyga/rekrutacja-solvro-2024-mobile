import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/DataStructures/DataManagerSingleton.dart';
import 'package:solvro_cocktails/MainPage/CocktailGrid.dart';

import 'DetailSheet.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _InfiniteScrollExampleState();
}

class _InfiniteScrollExampleState extends State<MainPage> {
  late List<Cocktail> cocktails;
  ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  int gridIndice = 2;
  @override
  void initState() {
    print("MainPage initState");
    super.initState();
    cocktails = DataManagerSingleton.getInstance().getCocktailSet().getCocktails();
    print(cocktails);
    print(cocktails.length);

    setState(() {
      isLoadingMore = false;
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoadingMore) {
        _loadMoreItems();
      }
    });
  }

  void _loadMoreItems() async {
    setState(() {
      isLoadingMore = true;
    });

    DataManagerSingleton.getInstance().loadNextCocktails();
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CocktailGrid(cocktails, gridIndice, _scrollController),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () {
          setState(() {
            gridIndice++;
            if(gridIndice == 3) gridIndice = 0;
          });
        },
        child: Icon(Icons.add),
      ),
    );

  }
}

//      body: ListView.builder(
//         controller: _scrollController,
//         itemCount: cocktails.length + (isLoadingMore ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == cocktails.length) {
//             return Center(
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           return ListTile(
//             onTap: () {
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 builder: (context) {
//                   return FractionallySizedBox(
//                     child: DetailBottomSheet(cocktails[index]),
//                   );
//                 },
//               );
//             },
//             title: Container(
//               padding: EdgeInsets.symmetric(vertical: 8.0), // Adjust padding as needed
//               decoration: BoxDecoration(
//                 color: Colors.blueAccent, // Change color as needed
//                 borderRadius: BorderRadius.circular(8.0), // Adjust border radius
//               ),
//               child: Text(
//                 cocktails[index].name,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white), // Change text color as needed
//               ),
//             )
//           );
//         },
//       ),
//     );