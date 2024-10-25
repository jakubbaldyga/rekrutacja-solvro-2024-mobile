
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';

class CocktailSet {
  List<Cocktail> _cocktails = [];


  void addCocktails(List<Cocktail> cocktails) {
    _cocktails.addAll(cocktails);
  }

  void addCocktail(Cocktail cocktail) {
    _cocktails.add(cocktail);
  }

  Cocktail findCocktailById(String id) {
    return _cocktails.where((cocktail) => cocktail.id == id).first;
  }

  List<Cocktail> getCocktails() {
    return _cocktails;
  }

  Cocktail getCocktail(int index) {
    return _cocktails[index];
  }
}