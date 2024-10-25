import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/DataStructures/Ingredient/Ingredient.dart';

/*
We kinda treat each cocktail as a resource.
We don't expect cocktail to change, so we can cache it
and only fetch it once.
 */

class ApiService {
  static Map<int, Cocktail> _cocktails = {};
  static Map<int, Ingredient> _ingredients = {};

  static Future<List<Cocktail>> fetchCocktails(int page, int howMany) async {
    final data = await _fetchData('https://cocktails.solvro.pl/api/v1/cocktails?page=$page&perPage=$howMany');

    final jsonResponse = json.decode(data);

    final List<dynamic> jsonList = jsonResponse['data'];

    // Map the list of JSON to List<Cocktail>
    var map = <Cocktail>[];
    for(var json in jsonList) {
      if(!_cocktails.containsKey(json['id'])) {
        var cocktail = Cocktail.fromJson(json);
        await _fetchIngredients(cocktail);
        _cocktails[cocktail.id] = cocktail;
        map.add(cocktail);
      }
      else {
        map.add(_cocktails[json['id']]!);
      }
    }

    return map;
  }

  static Future<void> _fetchIngredients(Cocktail cocktail) async {
    final data =await _fetchData('https://cocktails.solvro.pl/api/v1/cocktails/${cocktail.id}');
    final jsonResponse = json.decode(data);

    final List<dynamic> jsonList = jsonResponse['data']['ingredients'];

    for (var json in jsonList) {
      var id = json['id'];
      cocktail.addIngredient(id);
      if (!_ingredients.containsKey(id)) {
        _ingredients[id] = Ingredient.fromJson(json);
      }
    }
  }

  static Ingredient getIngridient(int id) {
    return _ingredients[id]!;
  }

  static Future<String> _fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

}
