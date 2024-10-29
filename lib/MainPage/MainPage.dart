import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/DataStructures/DataManagerSingleton.dart';
import 'package:solvro_cocktails/MainPage/CocktailGrid.dart';

import 'ICocktailGridProvider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _InfiniteScrollExampleState();
}

class _InfiniteScrollExampleState extends State<MainPage> implements ICocktailGridProvider {
  late List<Cocktail> cocktails;
  ScrollController _scrollController = ScrollController();
  late CocktailGrid cocktailGrid;
  bool _isLoadingMore = false;
  int gridIndice = 2;
  @override
  void initState() {
    super.initState();
    cocktails = DataManagerSingleton.getInstance().currentCocktailSet;
    cocktailGrid = CocktailGrid(cocktails, gridIndice, _scrollController, this);
    setState(() {
      _isLoadingMore = false;
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent/2 && !_isLoadingMore) {
        _loadMoreItems();

      }
    });
  }

  void _loadMoreItems() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isLoadingMore = true;
      });
    });

    DataManagerSingleton.getInstance().loadNextCocktails();
    await Future.delayed(Duration(seconds: 4));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cocktails = DataManagerSingleton.getInstance().currentCocktailSet;
        _isLoadingMore = false;
      });
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
      backgroundColor: Colors.black,
      body: Stack(
         fit: StackFit.expand,
        children: [
          CocktailGrid(cocktails, gridIndice, _scrollController, this), // Your cocktail grid
          Positioned(
            bottom: 80,
            right: 20,
            width: 50,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  gridIndice+=1;
                  if(gridIndice == CocktailGrid.gridOptions.length) gridIndice = 0;
                });
              },
              child: Text("#"),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            width: 50,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                setState(() {


                });
              },
              child: Text(">"),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 80,
            child: TextField(
              onChanged: (text) {
                print("Text: $text");
                () async {
                  await DataManagerSingleton.getInstance().loadBySearch(text);
                  setState(() {
                    cocktails = DataManagerSingleton.getInstance().currentCocktailSet;
                  });
                }();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your text',
              ),
            ),
          ),

        ],
      ),
    );
  }



  @override
  bool isLoadingMore() {
    return _isLoadingMore;
  }

  @override
  void loadMoreCocktails() {
    _isLoadingMore = true;
    //_loadMoreItems();
  }
}