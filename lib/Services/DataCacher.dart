
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/DataStructures/Ingredient/Ingredient.dart';

class DataCacher {
  final Map<int, Cocktail> _cocktailCache = {};
  final Map<int, Ingredient> _ingredientCache = {};

  void cacheCocktail(Cocktail cocktail) {
    _cocktailCache[cocktail.id] = cocktail;
  }

  void cacheIngredient(Ingredient ingredient) {
    _ingredientCache[ingredient.id] = ingredient;
  }

  bool containsCocktail(int id) {
    return _cocktailCache.containsKey(id);
  }

  bool containsIngredient(int id) {
    return _ingredientCache.containsKey(id);
  }

  void cacheCocktails(cocktail) {
    for (var c in cocktail) {
      cacheCocktail(c);
    }
  }

  Cocktail getCocktail(int id) {
    return _cocktailCache[id]!;
  }

  List<Ingredient> getIngredients(Cocktail cocktail) {
    List<Ingredient> ingredients = [];
    for (var id in cocktail.ingredientsIds) {
      ingredients.add(_ingredientCache[id]!);
    }
    return ingredients;
  }
}