import 'package:flutter/material.dart';
import '../main.dart';
import '../backButton.dart';
import '../parameterDropdown.dart';
import '../listMaker.dart';
import '../bigButton.dart';

class FindRecipePage extends StatefulWidget {
  void Function(String, dynamic, VoidCallback) setPageCallback;
  VoidCallback backCallback;

  FindRecipePage(this.setPageCallback, this.backCallback);

  bool focusLastTag = false;
  var tagFocusNodes = <FocusNode>[];

  bool focusLastIngredient = false;
  var ingredientFocusNodes = <FocusNode>[];

  var tags = <String>[];

  var keywordsController = TextEditingController();
  var time2makeTextController = TextEditingController();

  String difficulty = "Any";
  String typeOfDish = "Any";
  String countryOfOrigin = "Any";

  void clearValues() {
    focusLastTag = false;
    tagFocusNodes.clear();

    focusLastIngredient = false;
    ingredientFocusNodes.clear();

    tags = <String>[];

    keywordsController.text = "";
    time2makeTextController.text = "";

    difficulty = "Any";
    typeOfDish = "Any";
    countryOfOrigin = "Any";
  }

  @override
  _FindRecipePageState createState() => _FindRecipePageState();
}

class _FindRecipePageState extends State<FindRecipePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.tags.length == 0 || widget.tags[widget.tags.length - 1] != "")
      widget.tags.add("");
    while (widget.tagFocusNodes.length < widget.tags.length) {
      widget.tagFocusNodes.add(FocusNode());
    }
    var res = WillPopScope(
      onWillPop: () async {
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
                "Find Recipe",
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
            //time to make
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Max Time to Make", style: parameterStyle),
                  new ParameterInput(widget.time2makeTextController),
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
                  new ParameterDropdown(widget.difficulty, <String>[
                    'Any',
                    'Easy',
                    'Medium',
                    'Hard'
                  ], (newDifficulty) {
                    widget.difficulty = newDifficulty;
                  }),
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
                  new ParameterDropdown(widget.typeOfDish, <String>[
                    'Any',
                    'Appetizer',
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
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Country of Origin", style: parameterStyle),
                  new ParameterDropdown(
                      widget.countryOfOrigin, ["Any"] + countryNames,
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
              //Keywords text
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: appConfig['blockSize'] * 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Keywords",
                    style: listNameStyle,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: appConfig['blockSize'] * 10),
                child: TextField(
                  controller: widget.keywordsController,
                  onSubmitted: (val) => print("submitted!"),
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
                  () => widget.setPageCallback(
                      "recipesList",
                      {
                        'criteria': {
                          'maxTime2Make': widget.time2makeTextController.text ==
                                  ""
                              ? 0
                              : int.parse(widget.time2makeTextController.text),
                          'difficulty': widget.difficulty,
                          'typeOfDish': widget.typeOfDish,
                          'countryOfOrigin': widget.countryOfOrigin,
                          'tags': widget.tags.length != 0
                              ? widget.tags.sublist(0, widget.tags.length - 1)
                              : [],
                          'keywords': widget.keywordsController.text.split(" ")
                        },
                        'title': 'Recipes'
                      },
                      () => widget.setPageCallback(
                          "findRecipe", false, widget.backCallback)),
                  "Find Recipe"),
              SizedBox(
                height: appConfig['blockSizeVertical'] * 5,
              )
            ]),
        ),
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
}
