import 'package:flutter/material.dart';
import '../main.dart';
import '../backButton.dart';
import '../Components/RecipePreview.dart';

class RecipesListPage extends StatelessWidget {
  void Function(String, dynamic, VoidCallback) setPageCallback;
  String pageTitle;
  VoidCallback backCallback;
  Map<String, dynamic> criteria;

  RecipesListPage(
      this.setPageCallback, this.backCallback, this.criteria, this.pageTitle);

  @override
  Widget build(BuildContext context) {
    List<Recipe> recipes = findRecipesWithCriteria(criteria);
    return WillPopScope(
      onWillPop: () async {
        backCallback();
        return Future.value(false);
      },
      child: Column(
          children: <Widget>[
                SizedBox(
                  height: appConfig['blockSizeVertical'],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: appConfig['blockSize'] * 2),
                    IconBackButton(backCallback),
                    Expanded(
                      child: Text(pageTitle,
                          textAlign: TextAlign.center, style: titleStyle),
                    ),
                    SizedBox(width: appConfig['blockSizeVertical'] * 7),
                    SizedBox(width: appConfig['blockSize'] * 2),
                  ],
                )
              ] +
              recipes
                  .asMap()
                  .entries
                  .map((e) => RecipePreview(
                      setPageCallback,
                      () => setPageCallback(
                          "recipesList",
                          {'criteria': criteria, 'title': pageTitle},
                          backCallback),
                      e.value))
                  .toList()),
    );
  }
}
