
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Ingredient {
  static const AssetImage _defaultImage = AssetImage("assets/default_ingredient_icon.png");

  Ingredient(this.id,
      this.name,
      this.description,
      this.alcohol,
      this.type,
      this.percentage,
      this.imageUrl,
      this.createdAt,
      this.updatedAt,
      this.measure): image = imageUrl != null
                              ? CachedNetworkImageProvider(imageUrl)
                              : _defaultImage;


  final int id;
  final String name;
  final String? description;
  final bool? alcohol;
  final String? type;
  final int? percentage;
  final String? imageUrl;
  final ImageProvider image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? measure;

  factory Ingredient.fromJson(json) {
      return Ingredient(
          json['id'],
          json['name'],
          json['description'],
          json['alcohol'],
          json['type'],
          json['percentage'],
          json['imageUrl'],
          DateTime.parse(json['createdAt']),
          DateTime.parse(json['updatedAt']),
          json['measure']);
  }
}