import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/Services/DataManagerSingleton.dart';
import 'package:solvro_cocktails/MainPage/CocktailGrid.dart';
import 'package:solvro_cocktails/Services/QueryOptions.dart';

import 'ICocktailGridProvider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _InfiniteScrollExampleState();
}

class _InfiniteScrollExampleState extends State<MainPage> implements ICocktailGridProvider {

  QueryOptions globalOptions = QueryOptions();

  late List<int> cocktailsIds;
  ScrollController _scrollController = ScrollController();
  late CocktailGrid cocktailGrid;
  bool _isLoadingMore = false;
  int gridIndice = 2;
  @override
  void initState() {
    super.initState();
    cocktailsIds = DataManagerSingleton.getInstance().currentCocktailSet;
    cocktailGrid = CocktailGrid(cocktailsIds, gridIndice, _scrollController, this);
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

    DataManagerSingleton.getInstance().load(globalOptions);
    await Future.delayed(Duration(seconds: 4));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cocktailsIds = DataManagerSingleton.getInstance().currentCocktailSet;
        _isLoadingMore = false;
      });
    });

  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
bool _isLoading = false;
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
         fit: StackFit.expand,
        children: [
          CocktailGrid(cocktailsIds, gridIndice, _scrollController, this), // Your cocktail grid
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
                onTextInput(text);
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

  void onTextInput(text) async {
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 400), () async {


      globalOptions.search = text;
      print("Search: ${globalOptions.search}");

      // Load the data outside of setState
      if(await DataManagerSingleton.getInstance().load(globalOptions)) {
        await Future.delayed(Duration(milliseconds: 300));
        cocktailsIds = DataManagerSingleton.getInstance().currentCocktailSet;
        print(cocktailsIds.length);
        setState(() {
          print("Search: ${globalOptions.search}!!!!!!!!!!!!!!!!!!!!!!!");
          _isLoading = false; // Stop loading
        });
      }

    });
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