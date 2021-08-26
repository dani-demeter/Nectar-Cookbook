import 'package:flutter/material.dart';
import '../main.dart';
import '../backButton.dart';
import '../Components/RecipePreview.dart';

class RecipesListPage extends StatelessWidget {
  void Function(String, dynamic, VoidCallback) setPageCallback;
  VoidCallback backCallback;
  List<Recipe> recipes;

  RecipesListPage(this.setPageCallback, this.backCallback, this.recipes);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconBackButton(backCallback),
                  Text("Favorites", style: titleStyle),
                  SizedBox(width: appConfig['blockSizeVertical'] * 7)
                ],
              )
            ] +
            recipes
                .asMap()
                .entries
                .map((e) => RecipePreview(
                    setPageCallback,
                    () => setPageCallback("recipesList", recipes, backCallback),
                    e.value))
                .toList());
  }
}
