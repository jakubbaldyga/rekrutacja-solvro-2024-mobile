import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DataStructures/Cocktail/Cocktail.dart';
import 'CocktailTile/AnimatedCocktailTile.dart';
import 'CocktailTile/CocktailTile.dart';
import 'ICocktailGridProvider.dart';

class CocktailGrid extends StatefulWidget {

  List<Cocktail> cocktails;
  static const double magicOffset = 22.7; //works on every machine i tried... dunno why XD
  final ScrollController scrollController;
  int gridIndice;
  ICocktailGridProvider provider;

  static final double spacing = 0.0;
  static final List<int> gridOptions = [1, 2, 3];
  static final List<double> tileSizes = [];

  CocktailGrid(this.cocktails, this.gridIndice, this.scrollController, this.provider);

  static void changeGridCount(gridIndice) {
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
  var shouldUpdate = false;
  @override
  void initState() {
    super.initState();

    // Add a listener to the scroll controller
    widget.scrollController.addListener(() {
      // Get the current scroll position
      double scrollPosition = widget.scrollController.position.pixels;

      // Check if we are at the bottom of the scroll
      if (scrollPosition >= widget.scrollController.position.maxScrollExtent) {
        // Load more cocktails when reaching the bottom
        if (!widget.provider.isLoadingMore()) {
          widget.provider.loadMoreCocktails();
        }
      }

      // Update the view based on scroll position
      setState(() {
        shouldUpdate = !shouldUpdate;
        // You can update any variables here that need to trigger a rebuild
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    if(widget.cocktails.isEmpty)
      return Align(
          alignment: Alignment(0, 0),
          child:
          Text("No cocktails:(",
              style: TextStyle(color: Colors.white),
          )
      );
    return _InfiniteScroll(
      scrollController: widget.scrollController,
      child: LayoutBuilder(
        builder: (context, constraints) {
          initTileSizes(constraints.maxWidth);
          double tileOffset = (CocktailGrid.tileSizes[widget.gridIndice] + CocktailGrid.spacing);
          // Calculate total grid height based on number of rows and spacing
          double totalHeight = ((widget.cocktails.length / CocktailGrid.gridOptions[widget.gridIndice]).ceil() * tileOffset);
          if (widget.provider.isLoadingMore()) {
            totalHeight += 60; // Adjust this height based on the loading indicator size
          }

          var topOfTheScreen = widget.scrollController.position.pixels;
          var bottomOfTheScreen = (widget.scrollController.position.pixels +  MediaQuery.of(context).size.height);

          return SizedBox(
            width: constraints.maxWidth, // Full width container
            height: totalHeight, // Height based on calculated total grid height
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: List.generate(widget.cocktails.length, (index) {

                      int row = index ~/ CocktailGrid.gridOptions[widget.gridIndice];
                      double top = row * tileOffset - (CocktailGrid.tileSizes[0] - CocktailGrid.tileSizes[widget.gridIndice]) / 2;

                      if(top > bottomOfTheScreen || top + CocktailGrid.tileSizes[0] < topOfTheScreen) {
                        return Container();
                      }

                      int column = index % CocktailGrid.gridOptions[widget.gridIndice];
                      double left = column * tileOffset - CocktailGrid.magicOffset - (CocktailGrid.tileSizes[0] - CocktailGrid.tileSizes[widget.gridIndice]) / 2;

                      double size = CocktailGrid.tileSizes[0]; // this is always const
                      double scale = CocktailGrid.tileSizes[widget.gridIndice] / CocktailGrid.tileSizes[0]; // this defines actual size <- its needed by scaling animation


                      // Load more cocktails when reaching the end
                      if (false && !widget.provider.isLoadingMore() && index > widget.cocktails.length - 12) {
                        widget.provider.loadMoreCocktails();
                      }

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
                ),
                if (widget.provider.isLoadingMore()) // Loading indicator
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );

        },
      ),
    );
  }

  void initTileSizes(screenWidth) {
    for (int i = 0; i < CocktailGrid.gridOptions.length; i++) {
      CocktailGrid.tileSizes.add((screenWidth/ CocktailGrid.gridOptions[i]));
    }
  }
}