
import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/CocktailCategoryEnum.dart';
import 'package:solvro_cocktails/Services/QueryOptions.dart';

class FilterWindow extends StatefulWidget {
  QueryOptions options;
  static bool changed = false;

  var booleanList = [
    const DropdownMenuEntry(value: null, label: "---"),
    const DropdownMenuEntry(value: false, label: "false"),
    const DropdownMenuEntry(value: true, label: "true")
  ];

  FilterWindow(this.options);

  @override
  _FilterWindowState createState() => _FilterWindowState();
}

class _FilterWindowState extends State<FilterWindow> {
  @override
  Widget build(BuildContext context) {
   // String category = widget.options.category == null? "Category: -": "Category: ${[widget.options.category]}";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40)
      ),
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxHeight: 300,
        maxWidth: 350
      ),
      child: Column(
        children: [
          Text("Filter window"),
          Row(
            children: [
              Text("Category:"),
              DropdownMenu(
                dropdownMenuEntries: List.generate(ListCocktailCategory.length, (index) => DropdownMenuEntry(value: ListCocktailCategory[index], label: ListCocktailCategory[index])),
                initialSelection: widget.options.category ?? "---",
                onSelected: (value) {
                  widget.options.category = value;
                  if(value == "---") widget.options.category = null;
                  FilterWindow.changed = true;
                }
              )
            ],
          ),
          Row(
            children: [
              Text("Alcoholic:"),
              DropdownMenu(
                  dropdownMenuEntries: widget.booleanList,
                  initialSelection: widget.options.alcoholic,
                  onSelected: (value) {
                    widget.options.alcoholic = value;
                    FilterWindow.changed = true;
                  }
              )
            ],
          )
        ]
      )
    );
  }

}