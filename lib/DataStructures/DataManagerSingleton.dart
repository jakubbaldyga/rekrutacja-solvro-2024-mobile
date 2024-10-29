
import 'package:solvro_cocktails/ApiService.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/CocktailSet.dart';
import 'package:solvro_cocktails/DataStructures/Ingredient/Ingredient.dart';

import 'Cocktail/Cocktail.dart';

enum Mode{
  Default,
  Search,
  Count
}

class DataManagerSingleton {
  static DataManagerSingleton _instance = DataManagerSingleton();

  int _loadingCount = 0;
  int bandwith = 50;
  CocktailSet _cocktailSet = CocktailSet();

  List<Cocktail> defultCocktails = [];
  List<Cocktail> currentCocktailSet = [];


  double _screenWidth = 0;

  String prevSearch = "";
  int mode = 0;

  static DataManagerSingleton getInstance() {
    return _instance;
  }

  void setScreenWidth(double screenWidth) {
    _screenWidth = screenWidth;
  }

  double getScreenWidth() {
    return _screenWidth;
  }


  Future<void> loadBySearch(String search) async {
    // Ensure only one instance is loading at a time
    if (_loadingCount > 0) return;

    if(search == "") {
      loadNextCocktails();
      return;
    }

    if(prevSearch == search) {
      return;
    }

    prevSearch = search;
    currentCocktailSet = [];

    _loadingCount++;
    try {
      // Fetch cocktails
      if(mode == 0) {
        currentCocktailSet = [];
        _cocktailSet = CocktailSet();
        mode = 1;
      }
      var cocktails = await ApiService.fetchCocktailsBySearch( (currentCocktailSet.length / bandwith).floor()+1, bandwith, search);

      // Add cocktails if any are returned
      if (cocktails.isNotEmpty) {
        _cocktailSet.addCocktails(cocktails);
        currentCocktailSet += cocktails;
      } else {
        print("No more cocktails to load.");
      }
    } finally {
      _loadingCount--;
    }
  }

  void loadNextCocktails() async {
    // Ensure only one instance is loading at a time
    if (_loadingCount > 0) return;

    _loadingCount++;
    try {
      if(mode == 1) {
        currentCocktailSet = defultCocktails;
        mode = 0;
        return;
      }
      // Fetch cocktails
      int nextPage = (currentCocktailSet.length / bandwith).floor() + 1;
      var cocktails = await ApiService.fetchCocktails(nextPage, bandwith);

      // Add cocktails if any are returned
      if (cocktails.isNotEmpty) {
        _cocktailSet.addCocktails(cocktails);
        currentCocktailSet += cocktails;
        defultCocktails += cocktails;
      } else {
        print("No more cocktails to load.");
      }
    } finally {
      _loadingCount--;
    }
  }


  bool isBusy() {
    return _loadingCount > 0;
  }

  CocktailSet getCocktailSet() {
    return _cocktailSet;
  }

  List<Ingredient> getIngredients(Cocktail cocktail) {
    List<Ingredient> ingredients = [];
    for (var id in cocktail.ingredientsIds) {
      ingredients.add(ApiService.getIngridient(id));
    }
    return ingredients;
  }
}