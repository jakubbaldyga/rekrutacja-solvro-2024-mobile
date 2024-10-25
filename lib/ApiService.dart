import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';

class ApiService {
  static Future<List<Cocktail>> fetchCocktails(int page, int how_many) async {
    final data = await _fetchData('https://cocktails.solvro.pl/api/v1/cocktails?page=$page&perPage=$how_many');

    // Decode the response
    final jsonResponse = json.decode(data);

    // Assuming the API response is like: {"cocktails": [...]}
    final List<dynamic> jsonList = jsonResponse['data']; // Access the list from the map

    // Map the list of JSON to List<Cocktail>
    return jsonList.map<Cocktail>((json) => Cocktail.fromJson(json)).toList();
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
