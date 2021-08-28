import 'package:flutter/material.dart';
import '../main.dart';
import '../Components/Tag.dart';
import '../Components/RecipeBanner.dart';

class RecipePage extends StatelessWidget {
  void Function(String, dynamic, VoidCallback) setPageCallback;
  VoidCallback backCallback;
  String id;
  Recipe recipe;

  RecipePage(
    this.setPageCallback,
    this.backCallback,
    this.id,
  ) {
    this.recipe = recipeBook[id];
  }

  @override
  Widget build(BuildContext context) {
    String ingredientsText = "";

    recipe.ingredients.forEach((element) {
      ingredientsText +=
          (ingredientsText != "" ? "\n" : "") + "\u2022 " + element;
    });

    return WillPopScope(
      onWillPop: () async {
        backCallback();
        return Future.value(false);
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            //image etc
            RecipeBanner(backCallback, recipe),
            SizedBox(height: appConfig['blockSizeVertical'] * 2),
            //title
            Text(recipe.title, style: titleStyle.copyWith(color: inputColor)),
            //underline
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: mint,
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                ),
              ),
            ),
            SizedBox(height: appConfig['blockSizeVertical']),
            //parameters
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    Icon(Icons.fitness_center_rounded),
                    Icon(Icons.restaurant_menu_rounded),
                  ]),
                  SizedBox(width: appConfig['blockSize'] * 3),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.difficulty, style: parameterValueStyle),
                        Text(recipe.typeOfDish, style: parameterValueStyle),
                      ]),
                  Expanded(child: Container()),
                  Column(children: [
                    Icon(Icons.schedule),
                    Icon(Icons.flag_outlined),
                  ]),
                  SizedBox(width: appConfig['blockSize'] * 3),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.time2make.toString() + " mins",
                            style: parameterValueStyle),
                        Text(recipe.countryOfOrigin,
                            style: parameterValueStyle),
                      ])
                ],
              ),
            ),
            SizedBox(height: appConfig['blockSizeVertical'] * 3),
            //tags
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Wrap(
                children: recipe.tags
                    .asMap()
                    .entries
                    .map((e) => Tag(e.value))
                    .toList(),
              ),
            ),
            SizedBox(height: appConfig['blockSizeVertical'] * 3),
            //ingredients tag
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Ingredients", style: parameterStyle),
              ),
            ),
            //ingredients
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Container(
                  width: appConfig['blockSize'] * 80,
                  decoration: BoxDecoration(
                    color: fullwhite,
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 5,
                      vertical: appConfig['blockSizeVertical']),
                  child: Text(ingredientsText,
                      style: parameterValueStyle.copyWith(
                          fontSize: 15, height: 1.75))),
            ),
            SizedBox(height: appConfig['blockSizeVertical'] * 2),
            //recipe text
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Recipe", style: parameterStyle),
              ),
            ),
            //recipe
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Container(
                  width: appConfig['blockSize'] * 80,
                  decoration: BoxDecoration(
                    color: fullwhite,
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: appConfig['blockSize'] * 5,
                      vertical: appConfig['blockSizeVertical']),
                  child: Text(recipe.prep,
                      style: parameterValueStyle.copyWith(
                          fontSize: 15, height: 1.75))),
            ),
            SizedBox(height: appConfig['blockSizeVertical'] * 2),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.delete, color: gray),
                      onPressed: () {
                        recipeBook.remove(recipe.id);
                        writeRecipes(recipeBook);
                        backCallback();
                      },
                      label: Text('Remove', style: parameterStyle),
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.edit, color: gray),
                      onPressed: () {
                        setPageCallback(
                            "addRecipe",
                            {'clear': true, 'setValues': recipe},
                            () => {
                                  setPageCallback(
                                      "recipe", recipe.id, backCallback)
                                });
                      },
                      label: Text('Edit', style: parameterStyle),
                    ),
                  ]),
            ),
            SizedBox(height: appConfig['blockSizeVertical'] * 2),
          ],
        ),
      ),
    );
  }
}
