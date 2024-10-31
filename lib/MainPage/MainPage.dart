import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solvro_cocktails/MainPage/FilterWindow.dart';
import 'package:solvro_cocktails/Services/DataManagerSingleton.dart';
import 'package:solvro_cocktails/MainPage/CocktailGrid.dart';
import 'package:solvro_cocktails/Services/QueryOptions.dart';

import 'ICocktailGridProvider.dart';
import 'ImageRoundButton.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _InfiniteScrollExampleState();
}

class _InfiniteScrollExampleState extends State<MainPage> implements ICocktailGridProvider {

  QueryOptions globalOptions = QueryOptions();

  late List<int> cocktailsIds;
  final ScrollController _scrollController = ScrollController();
  late CocktailGrid cocktailGrid;
  bool _isLoadingMore = false;
  int gridIndice = 2;
  bool _isFilterWindowActive = false;
  Timer? _debounce;

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
    await Future.delayed(const Duration(seconds: 4));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
         fit: StackFit.expand,
        children: [
          backgroundImage(),
          CocktailGrid(cocktailsIds, gridIndice, _scrollController, this),
          ImageRoundButton(
              size: 50,
              right: 20,
              bottom:  140,
              imagePath: "assets/filter_icon.png",
              onPressed: () async {
                setState(() {
                  _isFilterWindowActive = !_isFilterWindowActive;
                });
                if(!_isFilterWindowActive) {
                  if(FilterWindow.changed) {
                    print("Filters changed");
                    await loadCocktails();
                  }
                }
              },

          ),
          ImageRoundButton(
              size: 50,
              bottom: 80,
              right: 20,
              onPressed: () {
                setState(() {
                  gridIndice+=1;
                  if(gridIndice == CocktailGrid.gridOptions.length) gridIndice = 0;
                });
              },
              imagePath: CocktailGrid.gridImageIcons[gridIndice],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextField(
                onChanged: onTextInput,
                decoration: InputDecoration(
                  hintText: "Search for cocktail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Builder(
                builder: (context) {
                  if(_isFilterWindowActive) {
                    return FilterWindow(globalOptions);
                  }
                  else {
                    return Container();
                  }
                },
              )
          )
        ],
      ),
    );
  }

  void onTextInput(text) async {
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 400), () async {
      globalOptions.search = text;
      await loadCocktails();
    });
  }

  Future<void> loadCocktails() async {
    if(await DataManagerSingleton.getInstance().load(globalOptions)) {
      await Future.delayed(const Duration(milliseconds: 300));
      cocktailsIds = DataManagerSingleton.getInstance().currentCocktailSet;
      print(cocktailsIds.length);
      setState(() {
        FilterWindow.changed = false;
      });
    }
  }

  Container backgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  bool isLoadingMore() {
    return _isLoadingMore;
  }
}