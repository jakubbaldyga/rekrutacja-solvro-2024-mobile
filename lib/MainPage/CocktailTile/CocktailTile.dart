import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/Cocktail.dart';
import '../DetailSheet/DetailSheet.dart';

class CocktailTile extends StatelessWidget {
  final Cocktail cocktail;
  final double size;
  final BuildContext context;
  final double scaleFactor = 1/384;

  const CocktailTile({
    required this.cocktail,
    required this.size,
    required this.context,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: () => _onPressed(cocktail, context),
      child: _content(cocktail, size),
    );
  }

  void _onPressed(Cocktail cocktail, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          child: DetailBottomSheet(cocktail),
        );
      },
    );
  }

  Widget _content(Cocktail cocktail, double size) {
    return _imageContent(
      width: size,
      height: size,
      child: _textBackground(
        width: size-16,
        child: Text(
          cocktail.name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 30 * size*scaleFactor ),
        ),
      ),
    );
  }

  Widget _imageContent({width, height, child}) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15 * size*scaleFactor), // Rounded edges
          image: DecorationImage(
            image:  NetworkImageWithRetry(cocktail.imageURL),
            fit: BoxFit.cover,
          ),
    ),

    child: child,
    );
  }

  Widget _textBackground({width, child}) {
    return Align(
        alignment: Alignment(0, 0.9),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12 * size/384),
          ),
          child: child,
        ),
    );
  }
}
