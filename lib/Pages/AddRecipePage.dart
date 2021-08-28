import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../Components/backButton.dart';
import '../Components/parameterDropdown.dart';
import '../Components/listMaker.dart';
import '../Components/bigButton.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class AddRecipePage extends StatefulWidget {
  void Function(String, dynamic, VoidCallback) setPageCallback;
  VoidCallback backCallback;

  AddRecipePage(this.setPageCallback, this.backCallback);

  bool focusLastTag = false;
  var tagFocusNodes = <FocusNode>[];

  bool focusLastIngredient = false;
  var ingredientFocusNodes = <FocusNode>[];

  var tags = <String>["Unmade"];
  var ingredients = <String>[];

  var titleTextController = TextEditingController();
  var prepTextController = TextEditingController();
  var time2makeTextController = TextEditingController();

  String difficulty = "Easy";
  String typeOfDish = "Entree";
  String countryOfOrigin = "Unknown";

  bool isEditing = false;
  Recipe recipeBeingEdited;

  void setBackCallback(VoidCallback bcb) {
    this.backCallback = bcb;
  }

  void clearValues() {
    focusLastTag = false;
    tagFocusNodes.clear();

    focusLastIngredient = false;
    ingredientFocusNodes.clear();

    tags = <String>["Unmade"];
    ingredients = <String>[];

    titleTextController.text = "";
    prepTextController.text = "";
    time2makeTextController.text = "";

    difficulty = "Easy";
    typeOfDish = "Entree";
    countryOfOrigin = "Unknown";
  }

  void setValues(Recipe newRecipe) {
    recipeBeingEdited = newRecipe;
    focusLastTag = false;
    tagFocusNodes.clear();

    focusLastIngredient = false;
    ingredientFocusNodes.clear();

    tags = newRecipe.tags;
    ingredients = newRecipe.ingredients;

    titleTextController.text = newRecipe.title;
    prepTextController.text = newRecipe.prep;
    time2makeTextController.text = newRecipe.time2make.toString();

    difficulty = newRecipe.difficulty;
    typeOfDish = newRecipe.typeOfDish;
    countryOfOrigin = newRecipe.countryOfOrigin;

    isEditing = true;
  }

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.tags.length == 0 || widget.tags[widget.tags.length - 1] != "")
      widget.tags.add("");
    while (widget.tagFocusNodes.length < widget.tags.length) {
      widget.tagFocusNodes.add(FocusNode());
    }
    if (widget.ingredients.length == 0 ||
        widget.ingredients[widget.ingredients.length - 1] != "")
      widget.ingredients.add("");
    while (widget.ingredientFocusNodes.length < widget.ingredients.length) {
      widget.ingredientFocusNodes.add(FocusNode());
    }
    var res = WillPopScope(
        onWillPop: () {
          widget.backCallback();
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: appConfig['blockSizeVertical'],
              ),
              //title
              Row(mainAxisSize: MainAxisSize.max, children: [
                SizedBox(width: appConfig['blockSize'] * 2),
                new IconBackButton(
                    () => widget.setPageCallback("home", null, null)),
                Expanded(
                    child: Text(
                  widget.isEditing ? "Edit Recipe" : "New Recipe",
                  textAlign: TextAlign.center,
                  style: titleStyle,
                )),
                SizedBox(
                    width: appConfig['blockSizeVertical'] * 7,
                    height: appConfig['blockSizeVertical'] * 7),
                SizedBox(width: appConfig['blockSize'] * 2),
              ]),
              SizedBox(
                height: appConfig['blockSizeVertical'] * 5,
              ),
              //recipe name
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 10),
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
                    controller: widget.titleTextController,
                    style: GoogleFonts.alata(
                        textStyle: TextStyle(color: inputColor)),
                  )),
              SizedBox(
                height: appConfig['blockSizeVertical'] * 5,
              ),
              //time to make
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: appConfig['blockSize'] * 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time to Make", style: parameterStyle),
                    new ParameterInput(widget.time2makeTextController),
                  ],
                ),
              ),
              SizedBox(
                height: appConfig['blockSizeVertical'] * 2,
              ),
              //difficulty
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: appConfig['blockSize'] * 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Difficulty", style: parameterStyle),
                    new ParameterDropdown(
                      widget.difficulty,
                      <String>['Easy', 'Medium', 'Hard'],
                      (newDifficulty) {
                        widget.difficulty = newDifficulty;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: appConfig['blockSizeVertical'] * 2,
              ),
              //type of dish
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: appConfig['blockSize'] * 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Type of Dish", style: parameterStyle),
                    new ParameterDropdown(widget.typeOfDish, <String>[
                      'Appetizer',
                      'Soup',
                      'Entree',
                      'Dessert',
                      'Drink'
                    ], (newTypeOfDish) {
                      widget.typeOfDish = newTypeOfDish;
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: appConfig['blockSizeVertical'] * 2,
              ),
              //country
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: appConfig['blockSize'] * 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Country of Origin", style: parameterStyle),
                    new ParameterDropdown(
                        widget.countryOfOrigin, ["Unknown"] + countryNames,
                        (newCountryOfOrigin) {
                      widget.countryOfOrigin = newCountryOfOrigin;
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: appConfig['blockSizeVertical'] * 5,
              ),
              //tags text
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: appConfig['blockSize'] * 10),
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
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: appConfig['blockSize'] * 10,
                          vertical: appConfig['blockSizeVertical']),
                      child: new ListElement(
                        e.value,
                        e.key,
                        addNewTag,
                        removeTag,
                        setTag,
                        widget.tagFocusNodes[e.key],
                        (pattern) {
                          List<String> simTags =
                              similarTags(pattern, tagSimilarityCutoff);
                          return List.from(Set.from(simTags)
                              .difference(Set.from(widget.tags)));
                        },
                      ),
                    ),
                  )
                  .toList())
              ..addAll([
                SizedBox(
                  height: appConfig['blockSizeVertical'] * 5,
                ),
                //Ingredients text
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 10),
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
                          widget.ingredientFocusNodes[e.key], (pattern) {
                        return <String>[];
                      })))
                  .toList())
              ..addAll([
                SizedBox(
                  height: appConfig['blockSizeVertical'] * 5,
                ),
                //Recipe text
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 10),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 10),
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
                    controller: widget.prepTextController,
                  ),
                ),
              ])
              ..addAll([
                SizedBox(
                  height: appConfig['blockSizeVertical'] * 5,
                ),
                BigButton(() {
                  Recipe recipe2Add = Recipe(
                      widget.titleTextController.text,
                      widget.isEditing ? widget.recipeBeingEdited.stars : 0,
                      widget.isEditing
                          ? widget.recipeBeingEdited.favorited
                          : false,
                      widget.difficulty,
                      int.parse(widget.time2makeTextController.text.length == 0
                          ? "0"
                          : widget.time2makeTextController.text),
                      widget.typeOfDish,
                      widget.countryOfOrigin,
                      widget.tags.length != 0
                          ? widget.tags.sublist(0, widget.tags.length - 1)
                          : [],
                      widget.ingredients.length != 0
                          ? widget.ingredients
                              .sublist(0, widget.ingredients.length - 1)
                          : [],
                      widget.prepTextController.text,
                      widget.isEditing
                          ? widget.recipeBeingEdited.imagePath
                          : "",
                      widget.isEditing
                          ? widget.recipeBeingEdited.id
                          : uuid.v1());
                  recipeBook[recipe2Add.id] = recipe2Add;
                  updateAllTags();
                  writeRecipes(recipeBook);
                  if (widget.isEditing) {
                    widget.isEditing = false;
                    widget.recipeBeingEdited = null;
                    widget.backCallback();
                  } else {
                    widget.setPageCallback("recipe", recipe2Add.id,
                        () => widget.setPageCallback("home", null, null));
                  }
                }, widget.isEditing ? "Save Recipe" : "Add Recipe"),
                SizedBox(
                  height: appConfig['blockSizeVertical'] * 5,
                )
              ]),
          ),
        ));

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
