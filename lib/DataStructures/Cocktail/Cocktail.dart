/*
Cocktail data structure

json:
"id": 11002,
"name": "Long Island Tea",
"category": "Ordinary Drink",
"glass": "Highball glass",
"instructions": "Combine all ingredients (except cola) and pour over ice in a highball glass. Add the splash of cola for color. Decorate with a slice of lemon and serve.",
"imageUrl": "https://cocktails.solvro.pl/images/cocktails/long-island-tea.png",
"alcoholic": true,
"createdAt": "2024-08-23T16:47:20.258+00:00",
"updatedAt": "2024-08-23T17:36:24.019+00:00"
 */

import 'package:flutter/cupertino.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/CocktailCategoryEnum.dart';

class Cocktail {
    Cocktail(this.id,
             this.name,
             this.category,
             this.glass,
             this.instructions,
             this.imageURL,
             this.alcoholic,
             this.createdAt,
             this.updatedAt): image = NetworkImage(imageURL);

    factory Cocktail.fromJson(Map<String, dynamic> json) {
        return Cocktail(
            json['id'],
            json['name'],
            stringToCocktail[json['category']]!,
            json['glass'],
            json['instructions'].split("\n"),
            json['imageUrl'],
            json['alcoholic'],
            DateTime.parse(json['createdAt']),
            DateTime.parse(json['updatedAt'])
        );
    }

    final int id;
    final String name;
    final CocktailCategory category;
    final String glass;
    final List<String> instructions;
    final String imageURL;
    final NetworkImage image;
    final bool alcoholic;
    final DateTime createdAt;
    final DateTime updatedAt;

}