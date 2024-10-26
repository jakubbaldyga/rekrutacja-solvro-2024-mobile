
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';

class CocktailSet {
  // id -> Cocktail
  Map<int, Cocktail> _cocktails = [];


  void addCocktails(List<Cocktail> cocktails) {
    for (var cocktail in cocktails) {
      _cocktails[cocktail.id] = cocktail;
    }
  }

  void addCocktail(Cocktail cocktail) {
    _cocktails[cocktail.id] = cocktail;
  }

  Cocktail findCocktailById(int id) {
    return _cocktails[id]!;
  }

  Map<int, Cocktail> getCocktails() {
    return _cocktails;
  }
}