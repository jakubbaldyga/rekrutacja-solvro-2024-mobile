
import 'package:solvro_cocktails/ApiService.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/CocktailSet.dart';
import 'package:solvro_cocktails/DataStructures/Ingredient/Ingredient.dart';

import 'Cocktail/Cocktail.dart';

class DataManagerSingleton {
  static DataManagerSingleton _instance = DataManagerSingleton();

  int _loadingCount = 0;
  int currentPage = 0;
  CocktailSet _currentCocktailSet = CocktailSet();
  double _screenWidth = 0;

  List<String> _cocktailNames = [];

  static DataManagerSingleton getInstance() {
    return _instance;
  }

  void setScreenWidth(double screenWidth) {
    _screenWidth = screenWidth;
  }

  double getScreenWidth() {
    return _screenWidth;
  }

  void loadNextCocktails() async {
    _loadingCount++;
    var cocktails = await ApiService.fetchCocktails(++currentPage, 48);

    _currentCocktailSet.addCocktails(cocktails);

    for (var cocktail in cocktails) {
      _cocktailNames.add(cocktail.name);
    }

    _loadingCount--;
  }

  bool isBusy() {
    return _loadingCount > 0;
  }

  List<String> getCocktailNames() {
    return _cocktailNames;
  }

  CocktailSet getCocktailSet() {
    return _currentCocktailSet;
  }

  List<Ingredient> getIngredients(Cocktail cocktail) {
    List<Ingredient> ingredients = [];
    for (var id in cocktail.ingredientsIds) {
      ingredients.add(ApiService.getIngridient(id));
    }
    return ingredients;
  }
}