import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Cocktail {
    Cocktail(this.id,
             this.name,
             this.category,
             this.glass,
             this.instructions,
             this.imageURL,
             this.alcoholic,
             this.createdAt,
             this.updatedAt): image = CachedNetworkImageProvider(imageURL);

    factory Cocktail.fromJson(Map<String, dynamic> json) {
        return Cocktail(
            json['id'],
            json['name'],
            json['category'],
            json['glass'],
            json['instructions'],
            json['imageUrl'],
            json['alcoholic'],
            DateTime.parse(json['createdAt']),
            DateTime.parse(json['updatedAt'])
        );
    }

    void addIngredient(int id) {
        ingredientsIds.add(id);
    }

    List<int> ingredientsIds = [];
    final int id;
    final String name;
    final String category;
    final String glass;
    final String instructions;
    final String imageURL;
    final ImageProvider image;
    final bool alcoholic;
    final DateTime createdAt;
    final DateTime updatedAt;

}