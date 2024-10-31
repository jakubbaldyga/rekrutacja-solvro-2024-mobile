
import 'package:flutter/material.dart';
import 'package:solvro_cocktails/DataStructures/Cocktail/CocktailCategoryEnum.dart';
import 'package:solvro_cocktails/Services/QueryOptions.dart';

class FilterWindow extends StatefulWidget {
  QueryOptions options;
  static bool changed = false;

  var booleanList = [
    const DropdownMenuEntry(value: null, label: "Any"),
    const DropdownMenuEntry(value: false, label: "false"),
    const DropdownMenuEntry(value: true, label: "true")
  ];

  FilterWindow(this.options, {super.key});

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
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          filterWindowTitle(),
          categoryRow(),
          alcoholicRow(),
          sortingRow(),
        ]
      )
    );
  }

  Text filterWindowTitle() {
    return const Text(
        "Filter window",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Row categoryRow() {
    return Row(
      children: [
        const Text("Category:\t\t", style: TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        CustomDropDownMenu(
            dropdownMenuEntries: List.generate(ListCocktailCategory.length, (index) => DropdownMenuEntry(value: ListCocktailCategory[index], label: ListCocktailCategory[index])),
            initialSelection: widget.options.category ?? "Any",
            onSelected: (value) {
              widget.options.category = value;
              if(value == "Any") widget.options.category = null;
              FilterWindow.changed = true;
            }
        )
      ],
    );
  }

  Row alcoholicRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Alcoholic:\t\t", style: TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        CustomDropDownMenu(
          dropdownMenuEntries: widget.booleanList,
          initialSelection: widget.options.alcoholic,
          onSelected: (value) {
            setState(() {
              widget.options.alcoholic = value;
              FilterWindow.changed = true;
            });
          },
        ),
      ],
    );
  }

  static const List<DropdownMenuEntry> ListSortBy = [
    const DropdownMenuEntry(value: null, label: "Any"),
    const DropdownMenuEntry(value: "+name", label: "Name ascending"),
    const DropdownMenuEntry(value: "-name", label: "Name descending"),
    const DropdownMenuEntry(value: "+instructions", label: "Instructions ascending"),
    const DropdownMenuEntry(value: "-instructions", label: "Instructions descending"),
  ];

  Row sortingRow() {
    return Row(
      children: [
        const Text("Sort by:\t\t", style: TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        CustomDropDownMenu(
          dropdownMenuEntries: ListSortBy,
          initialSelection: widget.options.sortBy,
          onSelected: (value) {
            setState(() {
              widget.options.sortBy = value;
              FilterWindow.changed = true;
            });
          },
        ),
      ],
    );
  }

  DropdownMenu CustomDropDownMenu({dropdownMenuEntries, initialSelection, onSelected}) {
    return DropdownMenu(
      dropdownMenuEntries: dropdownMenuEntries,
      initialSelection: initialSelection,
      onSelected: onSelected,
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }


}