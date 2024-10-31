import 'package:flutter/material.dart';
import 'package:solvro_cocktails/Services/ApiService.dart';
import 'package:solvro_cocktails/DataStructures/Ingredient/Ingredient.dart';
import 'package:solvro_cocktails/Services/DataCacher.dart';

import '../DataStructures/Cocktail/Cocktail.dart';
import 'QueryOptions.dart';

class DataManagerSingleton {
  static final DataManagerSingleton _instance = DataManagerSingleton();

  int _loadingCount = 0;
  int bandwith = 30;

  final DataCacher _dataCacher = DataCacher();

  List<DropdownMenuEntry> categoryList = [
    const DropdownMenuEntry(value: null, label: "Any")
  ];

  List<DropdownMenuEntry> glassList = [
    const DropdownMenuEntry(value: null, label: "Any")
  ];

  //int is QueryOptions hashCode
  Map<int, List<int>> cocktailLists = {};
  List<int> currentCocktailSet = [];


  double _screenWidth = 0;

  QueryOptions currentOptions = QueryOptions();

  static DataManagerSingleton getInstance() {
    return _instance;
  }

  void setScreenWidth(double screenWidth) {
    _screenWidth = screenWidth;
  }

  double getScreenWidth() {
    return _screenWidth;
  }

  Future<void> loadCategoriesAndGlasses() async {
    List<String> categories = await ApiService.fetchCategories();
    List<String> glasses = await ApiService.fetchGlasses();

    categoryList.addAll(categories.map((e) => DropdownMenuEntry(value: e, label: e)));
    glassList.addAll(glasses.map((e) => DropdownMenuEntry(value: e, label: e)));
  }

  //returns true if finished loading
  Future<bool> load(QueryOptions options) async {
      if(options == currentOptions) {
          await _loadNextCocktails();
      }
      else
      {
          cocktailLists[currentOptions.hashCode] = currentCocktailSet;

          currentOptions = options.clone();
          if(cocktailLists[currentOptions.hashCode] == null) {
            currentCocktailSet = [];
            await _loadNextCocktails();
          }
          else{
            currentCocktailSet = cocktailLists[currentOptions.hashCode]!;
          }
      }
      return true;
  }

  Future<void> _loadNextCocktails() async {
    // Ensure only one instance is loading at a time
    if (_loadingCount > 0) return;

    _loadingCount++;

    try {
      // Fetch cocktailsIds
      int nextPage = (currentCocktailSet.length / bandwith).floor() + 1;
      var cocktailsIds = await ApiService.fetchCocktails(_dataCacher, currentOptions.createPrompt(nextPage, bandwith));

      // Add cocktailsIds if any are returned
      if (cocktailsIds.isNotEmpty) {
        currentCocktailSet.addAll(cocktailsIds);
      } else {
        print("No more cocktailsIds to load.");
      }
    } finally {
      _loadingCount--;
    }
  }


  bool isBusy() {
    return _loadingCount > 0;
  }

  Cocktail getCocktail(int id) {
    return _dataCacher.getCocktail(id);
  }

  List<Ingredient> getIngredients(Cocktail cocktail) {
    return _dataCacher.getIngredients(cocktail);
  }
}