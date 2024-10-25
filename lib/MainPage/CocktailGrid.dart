import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DataStructures/Cocktail/Cocktail.dart';
import 'CocktailTile/AnimatedCocktailTile.dart';
import 'CocktailTile/CocktailTile.dart';

class CocktailGrid extends StatefulWidget {

  List<Cocktail> cocktails;
  static const double magicOffset = 22.7; //works on every machine i tried... dunno why XD
  final ScrollController scrollController;
  int gridIndice;

  final double spacing = 0.0;
  final List<int> gridOptions = [1, 2, 4];
  final List<double> tileSizes = [];

  CocktailGrid(this.cocktails, this.gridIndice, this.scrollController);

  void changeGridCount() {
      gridIndice-=1;
      if(gridIndice == -1) gridIndice = gridOptions.length-1;
  }

  @override
  _CocktailGrid createState() => _CocktailGrid();
}

class _InfiniteScroll extends Column {
  _InfiniteScroll({child, scrollController}) :
      super(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: child,
            ),
          ),
        ],
      );
}

class _CocktailGrid extends State<CocktailGrid> {
  @override
  Widget build(BuildContext context) {
    return _InfiniteScroll(
      scrollController: widget.scrollController,
      child: LayoutBuilder(
        builder: (context, constraints) {
          initTileSizes(constraints.maxWidth);
          double tileOffset = (widget.tileSizes[widget.gridIndice] + widget.spacing);
          // Calculate total grid height based on number of rows and spacing
          double totalHeight = ((widget.cocktails.length / widget.gridOptions[widget.gridIndice]).ceil() * tileOffset);
          return SizedBox(
            width: constraints.maxWidth, // Full width container
            height: totalHeight, // Height based on calculated total grid height
            child: Stack(
              children: List.generate(widget.cocktails.length, (index) {
                int row = index ~/ widget.gridOptions[widget.gridIndice];
                int column = index % widget.gridOptions[widget.gridIndice];
                double left = column * tileOffset - CocktailGrid.magicOffset - (widget.tileSizes[0] - widget.tileSizes[widget.gridIndice])/2;
                double top = row * tileOffset - (widget.tileSizes[0] - widget.tileSizes[widget.gridIndice])/2;
                double size = widget.tileSizes[0]; //this is always const
                double scale = widget.tileSizes[widget.gridIndice] / widget.tileSizes[0]; //this defines actual size <- its needed by scaling animation

                return AnimatedCocktailTile(
                  cocktailTile: CocktailTile(
                    cocktail: widget.cocktails[index],
                    size: size,
                    context: context,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  left: left,
                  top: top,
                  scale: scale,
                );
              }),
            ),
          );
        },
      ),
    );
  }

  void initTileSizes(screenWidth) {
    for (int i = 0; i < widget.gridOptions.length; i++) {
      widget.tileSizes.add((screenWidth/ widget.gridOptions[i]));
    }
  }
}