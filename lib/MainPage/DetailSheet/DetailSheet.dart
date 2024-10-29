import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/DataStructures/DataManagerSingleton.dart';
import 'package:solvro_cocktails/DataStructures/Ingredient/Ingredient.dart';

import 'Labels.dart';

class DetailBottomSheet extends StatelessWidget {
  final Cocktail cocktail;
  final List<Ingredient> ingredients;
  ScrollController scrollController = ScrollController();

  DetailBottomSheet(this.cocktail, {super.key}) : ingredients = DataManagerSingleton.getInstance().getIngredients(cocktail);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,  // Start at 0.8 of screen height
      minChildSize: 0.4,      // Minimum height allowed
      maxChildSize: 0.9,      // Maximum height allowed (full screen)
      builder: (BuildContext context, ScrollController scrollController2) {
        return Stack(
          children: [
            _topContent(),

            SingleChildScrollView(
              controller: scrollController2,
              physics: BouncingScrollPhysics(),
              child: Container(
                child: _content(context),
              )
            ),
          ],
        );

        //   SingleChildScrollView(
        //   controller: scrollController,
        //   physics: BouncingScrollPhysics(),
        //   child: _content(scrollController, context),
        // );
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



  Widget _content(context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 5000,
            ),
            Positioned(
              top: 250, // Adjust to your needs
              left: 0,
              right: 0,
              bottom: 0, // Allow it to expand to the bottom of the Stack,
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              _ingridientsContent(),
                              _instructionsContent(),
                            ],
                          ),
                        )
                    ),
                  ],
              ),
            ),
    ],
        ),

    // ) _ingridientsContent(),
    //     ),
    //     Positioned(
    //       top: 430,
    //       left: 0,
    //       right: 0,
    //       child: _instructionsContent(scrollController),
    //     ),
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

  Container _ingridientsContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Ingredients:",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ingredients.map((ingredient) => _buildCard(ingredient)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Ingredient ingredient) {
    return Container(
      width: 140,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add the ingredient image at the top of the card
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                ingredient.imageUrl?? 'https://static-00.iconduck.com/assets.00/fluid-icon-2048x2048-wswzeuvy.png',
                height: 100, // Adjust the height as needed
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ingredient.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          _constructCocktailString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String _constructCocktailString() {
    String result = "";
    result += "Instructions:\n";

    int constructionIndex = 1;
    for (String instruction in cocktail.instructions) {
      result += "$constructionIndex) $instruction\n";
      constructionIndex++;
    }

    for(int i = 0; i < 5; i++) {
      result += "\n";
    }

    return result;
  }
}
