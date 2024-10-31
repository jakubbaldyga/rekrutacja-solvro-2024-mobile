import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solvro_cocktails/MainPage/CocktailTile/CocktailTile.dart';

class AnimatedCocktailTile extends StatelessWidget {
  final CocktailTile cocktailTile;
  final Duration animationDuration;
  final double left;
  final double top;
  final double scale;

  const AnimatedCocktailTile({
    super.key,
    required this.cocktailTile,
    required this.animationDuration,
    required this.left,
    required this.top,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: animationDuration,
      curve: Curves.easeInOut,
      left: left,
      top: top,
      child: AnimatedScale(
        scale: scale,
        duration: animationDuration,
        child: cocktailTile,
        ),
    );
  }
}
