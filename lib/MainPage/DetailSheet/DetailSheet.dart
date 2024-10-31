import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/Services/DataManagerSingleton.dart';
import 'package:solvro_cocktails/DataStructures/Ingredient/Ingredient.dart';

import 'Labels.dart';

class DetailBottomSheet extends StatelessWidget {
  final Cocktail cocktail;
  final List<Ingredient> ingredients;
  ScrollController scrollController = ScrollController();

  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(19));
  static const double padding = 8;
  static const AssetImage defaultIngridientImage = AssetImage("assets/default_ingredient_icon.png");

  DetailBottomSheet(this.cocktail, {super.key}) : ingredients = DataManagerSingleton.getInstance().getIngredients(cocktail);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController2) {
        return Stack(
          children: [
            _content(context),
            _topContent()
          ],
        );
      },
    );
  }
  
  Widget _topContent() {
    return Stack(
      children: [
        Container(
          height: 5000,
        ),
        _imageContent(),
        Positioned(
          top: 10,
          left: 10,
          child: Labels.favouriteButton(),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Labels.alcoholLabel(cocktail),
        ),
        Positioned(
          top: 60,
          right: 10,
          child: Labels.cocktailGlassLabel(cocktail),
        ),
        Positioned(
          top: 110,
          right: 10,
          child: Labels.cocktailCategoryLabel(cocktail),
        ),
        Positioned(
          top: 200,
          left: 10,
          child: Labels.cocktailLabel(cocktail),
        ),
      ],
    );
  }

  Container _imageContent() {
    return Container(
      height: 300,
      child: ClipPath(
        clipper: BottomRoundedClipper(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            image: DecorationImage(
              image: NetworkImage(cocktail.imageURL),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }

  Positioned _content(context) {
          return Positioned(
              top: 250,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                              children: [
                                _ingredientsTitle(),
                                _ingridientsContent(),
                                _instructionsContent(),
                              ],
                            )
                          ),
                    ),
                  ],
                ),
              )
            );
  }


  Text _ingredientsTitle() {
    return const Text(
      "Ingredients:",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  SingleChildScrollView _ingridientsContent() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ingredients.map((ingredient) => _buildCard(ingredient)).toList(),
        )
      );
  }



  Widget _buildCard(Ingredient ingredient) {
    return Container(
      width: 140,
      margin: EdgeInsets.all(padding),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image(
                image: ingredient.image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ingredient.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: padding),
                  Text(
                    ingredient.measure ?? "",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _instructionsContent() {
      return Center(
        child: Padding(
            padding: const EdgeInsets.only(left: padding, right: padding, top: padding),
            child: Text(
              _constructCocktailString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )
      );
  }

  String _constructCocktailString() {
    String result = "";
    result += "Instructions:";

    int constructionIndex = 1;
    for (String instruction in cocktail.instructions) {
      result += "\n$constructionIndex) $instruction";
      constructionIndex++;
    }

    return result;
  }
}

class BottomRoundedClipper extends CustomClipper<Path> {
  static const double edgeRound = 19;
  static const double bottomPadding = 30;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height-bottomPadding);

    path.quadraticBezierTo(0, size.height - edgeRound - bottomPadding,
                           edgeRound, size.height-edgeRound-bottomPadding);

    path.lineTo(size.width-edgeRound, size.height-edgeRound-bottomPadding);

    path.quadraticBezierTo(size.width, size.height-edgeRound-bottomPadding,
                           size.width, size.height-bottomPadding);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}