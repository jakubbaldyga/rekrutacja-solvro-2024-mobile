import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/DataStructures/Ingredient/Ingredient.dart';
import 'package:solvro_cocktails/Services/DataCacher.dart';

/*
We kinda treat each cocktail as a resource.
We don't expect cocktail to change, so we can cache it
and only fetch it once.
 */

class ApiService {

  static Future<List<int>> fetchCocktails(DataCacher dataCacher, String apiCall) async {
    final data = await _fetchData(apiCall);

    final jsonResponse = json.decode(data);

    final List<dynamic> jsonList = jsonResponse['data'];

    // Map the list of JSON to List<Cocktail>
    var list = <int>[];
    for(var json in jsonList) {
      if(!dataCacher.containsCocktail(json['id'])) {
        var cocktail = Cocktail.fromJson(json);
        dataCacher.cacheCocktail(cocktail);

        await _fetchIngredients(dataCacher, cocktail);
        list.add(cocktail.id);
      }
      else {
        list.add(json['id']);
      }
    }
    print('fetched ${list.length} items');
    return list;
  }

  static Future<void> _fetchIngredients(DataCacher dataCacher, Cocktail cocktail) async {
    final data =await _fetchData('https://cocktails.solvro.pl/api/v1/cocktails/${cocktail.id}');
    final jsonResponse = json.decode(data);

    final List<dynamic> jsonList = jsonResponse['data']['ingredients'];

    for (var json in jsonList) {
      var id = json['id'];
      cocktail.addIngredient(id);
      if (!dataCacher.containsIngredient(id)) {
        dataCacher.cacheIngredient(Ingredient.fromJson(json));
      }
    }
  }

  static Future<String> _fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://cocktails.solvro.pl/api/v1/cocktails/categories'));

    if (response.statusCode == 200) {
      final List<String> jsonResponse = List<String>.from(json.decode(response.body)['data']);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<String>> fetchGlasses() async {
    final response = await http.get(Uri.parse('https://cocktails.solvro.pl/api/v1/cocktails/glasses'));

    if (response.statusCode == 200) {
      final List<String> jsonResponse = List<String>.from(json.decode(response.body)['data']);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
