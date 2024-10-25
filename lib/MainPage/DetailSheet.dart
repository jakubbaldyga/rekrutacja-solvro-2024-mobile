import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/CocktailCategoryEnum.dart';

class DetailBottomSheet extends StatelessWidget {
  final Cocktail cocktail;

  const DetailBottomSheet(this.cocktail, {super.key});

  String _constructCocktailString() {
    String result = "";
    result += cocktail.name + "\n";
    result += "${cocktailToString[cocktail.category]}\n";
    result += "${cocktail.glass}\n";
    result += "\nInstructions:\n";

    int constructionIndex = 1;
    for (String instruction in cocktail.instructions) {
      result += "$constructionIndex. $instruction\n";
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
        return _content(scrollController);
      },
    );
  }

  Widget _content(ScrollController scrollController) {
    return Stack(
      children: [
        _imageContent(),
        Positioned(
          top: 250, // Adjust this value to control how much the text overlaps the image
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

  Container _textContent(ScrollController scrollController) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
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
    );
  }

}
