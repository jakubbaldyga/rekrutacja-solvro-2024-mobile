import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/CocktailCategoryEnum.dart';
import 'package:solvro_cocktails/DataStructures/DataManagerSingleton.dart';
import 'package:solvro_cocktails/DataStructures/Ingredient/Ingredient.dart';

class DetailBottomSheet extends StatelessWidget {
  final Cocktail cocktail;
  final List<Ingredient> ingredients;

  DetailBottomSheet(this.cocktail, {super.key}) : ingredients = DataManagerSingleton.getInstance().getIngredients(cocktail);


  String _constructCocktailString() {
    String result = "";
    result += "Ingredients:\n";
    for (Ingredient ingredient in ingredients) {
      result += "${ingredient.name} - ${ingredient.measure}\n";
    }
    result += "\nInstructions:\n";

    int constructionIndex = 1;
    for (String instruction in cocktail.instructions) {
      result += "$constructionIndex) $instruction\n";
      constructionIndex++;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return _content(new ScrollController());
      },
    );
  }

  Widget _content(ScrollController scrollController) {
    return Stack(
      children: [
        _imageContent(),
        Positioned(
          top: 10,
          right: 10,
          child: _alcoholLabel(),
        ),
        Positioned(
          top: 60,
          right: 10,
          child: _cocktailGlassLabel(),
        ),
        Positioned(
          top: 110,
          right: 10,
          child: _cocktailCategoryLabel(),
        ),
        Positioned(
          top: 200,
          left: 10,
          child: _cocktailLabel(),
        ),
        Positioned(
          top: 250,
          left: 0,
          right: 0,
          child: _textContent(scrollController),
        ),
      ],
    );
  }

  Container _imageContent() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        image: DecorationImage(
          image: NetworkImage(cocktail.imageURL),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Container _cocktailLabel() {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        color: Color.fromARGB(0xA0, 0xFF, 0xFF, 0xFF),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        cocktail.name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _alcoholLabel() {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        cocktail.alcoholic ? "Alcoholic" : "Alcohol-free",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _cocktailGlassLabel() {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        cocktail.glass,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _cocktailCategoryLabel() {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        cocktailToString[cocktail.category]!,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _textContent(ScrollController scrollController) {
    return Container(
      height: 1000,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        verticalDirection: VerticalDirection.down,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: Text(
                  _constructCocktailString(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ),],
      ),
    );
  }

}
