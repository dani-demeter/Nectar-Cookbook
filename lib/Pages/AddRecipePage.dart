import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../backButton.dart';
import '../parameterDropdown.dart';
import '../listMaker.dart';
import '../bigButton.dart';

class AddRecipePage extends StatefulWidget {
  void Function(String, dynamic) setPageCallback;

  AddRecipePage(this.setPageCallback);

  bool focusLastTag = false;
  var tagFocusNodes = <FocusNode>[];

  bool focusLastIngredient = false;
  var ingredientFocusNodes = <FocusNode>[];

  var tags = <String>["Heavy", "Mate", "Konyi"];
  var ingredients = <String>["1 liter of ketchup"];

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.tags[widget.tags.length - 1] != "") widget.tags.add("");
    while (widget.tagFocusNodes.length < widget.tags.length) {
      widget.tagFocusNodes.add(FocusNode());
    }
    if (widget.ingredients[widget.ingredients.length - 1] != "")
      widget.ingredients.add("");
    while (widget.ingredientFocusNodes.length < widget.ingredients.length) {
      widget.ingredientFocusNodes.add(FocusNode());
    }
    var res = SingleChildScrollView(
      child: Column(
        children: [
          //title
          Row(mainAxisSize: MainAxisSize.max, children: [
            new IconBackButton(() => widget.setPageCallback("home", null)),
            Expanded(
                child: Text(
              "New Recipe",
              textAlign: TextAlign.center,
              style: titleStyle,
            )),
            SizedBox(
                width: appConfig['blockSizeVertical'] * 7,
                height: appConfig['blockSizeVertical'] * 7)
          ]),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 5,
          ),
          //recipe name
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mint, width: 1.0),
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                  ),
                  filled: true,
                  fillColor: fullwhite,
                  labelText: "Recipe Name",
                  labelStyle: TextStyle(color: gray),
                ),
                style:
                    GoogleFonts.alata(textStyle: TextStyle(color: inputColor)),
              )),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 5,
          ),
          //time to make
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Time to Make", style: parameterStyle),
                new ParameterInput(() => print("callback")),
              ],
            ),
          ),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 2,
          ),
          //difficulty
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Difficulty", style: parameterStyle),
                new ParameterDropdown(
                    "Easy",
                    <String>['Easy', 'Medium', 'Hard'],
                    () => print("callback")),
              ],
            ),
          ),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 2,
          ),
          //type of dish
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Type of Dish", style: parameterStyle),
                new ParameterDropdown(
                    "Entree",
                    <String>['Appetizer', 'Entree', 'Dessert', 'Drink'],
                    () => print("callback")),
              ],
            ),
          ),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 2,
          ),
          //country
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Country of Origin", style: parameterStyle),
                new ParameterDropdown("Unknown",
                    ["Unknown"]..addAll(countryNames), () => print("callback")),
              ],
            ),
          ),
          SizedBox(
            height: appConfig['blockSizeVertical'] * 5,
          ),
          //tags text
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tags",
                style: listNameStyle,
              ),
            ),
          ),
        ]
          ..addAll(widget.tags
              .asMap()
              .entries
              .map((e) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 10,
                      vertical: appConfig['blockSizeVertical']),
                  child: new ListElement(e.value, e.key, addNewTag, removeTag,
                      setTag, widget.tagFocusNodes[e.key])))
              .toList())
          ..addAll([
            SizedBox(
              height: appConfig['blockSizeVertical'] * 5,
            ),
            //Ingredients text
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ingredients",
                  style: listNameStyle,
                ),
              ),
            ),
          ])
          ..addAll(widget.ingredients
              .asMap()
              .entries
              .map((e) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 10,
                      vertical: appConfig['blockSizeVertical']),
                  child: new ListElement(
                      e.value,
                      e.key,
                      addNewIngredient,
                      removeIngredient,
                      setIngredient,
                      widget.ingredientFocusNodes[e.key])))
              .toList())
          ..addAll([
            SizedBox(
              height: appConfig['blockSizeVertical'] * 5,
            ),
            //Recipe text
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recipe",
                    style: listNameStyle,
                  ),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Icons.check_circle_outline),
                      onPressed: () => FocusScope.of(context).unfocus())
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: TextField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                onSubmitted: (val) => print("submitted!"),
                onEditingComplete: () => print("editing complete!"),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 3,
                      vertical: appConfig['blockSizeVertical'] * 2),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mint, width: 1.0),
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                  ),
                  filled: true,
                  fillColor: fullwhite,
                ),
                style: parameterValueStyle,
              ),
            ),
          ])
          ..addAll([
            SizedBox(
              height: appConfig['blockSizeVertical'] * 5,
            ),
            BigButton(
                () => widget.setPageCallback("recipe", null), "Add Recipe"),
            SizedBox(
              height: appConfig['blockSizeVertical'] * 5,
            )
          ]),
      ),
    );

    if (widget.focusLastTag) {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(widget.tagFocusNodes.last);
      widget.focusLastTag = false;
    }

    if (widget.focusLastIngredient) {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(widget.ingredientFocusNodes.last);
      widget.focusLastIngredient = false;
    }
    return res;
  }

  void addNewTag(String newTag) {
    setState(() {
      widget.tags[widget.tags.length - 1] = newTag;
      widget.tags.add("");
      widget.focusLastTag = true;
    });
  }

  void removeTag(int idx) {
    setState(() {
      widget.tags.removeAt(idx);
      widget.tagFocusNodes.removeAt(idx);
      widget.focusLastTag = false;
    });
  }

  void setTag(int idx, String newVal) {
    setState(() {
      widget.tags[idx] = newVal;
      widget.focusLastTag = false;
    });
  }

  void addNewIngredient(String newIngredient) {
    setState(() {
      widget.ingredients[widget.ingredients.length - 1] = newIngredient;
      widget.ingredients.add("");
      widget.focusLastIngredient = true;
    });
  }

  void removeIngredient(int idx) {
    setState(() {
      widget.ingredients.removeAt(idx);
      widget.ingredientFocusNodes.removeAt(idx);
      widget.focusLastIngredient = false;
    });
  }

  void setIngredient(int idx, String newVal) {
    setState(() {
      widget.ingredients[idx] = newVal;
      widget.focusLastIngredient = false;
    });
  }
}
