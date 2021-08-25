import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../Components/Tag.dart';
import '../backButton.dart';
import '../Components/Ratings.dart';

class RecipePage extends StatelessWidget {
  void Function(String, dynamic) setPageCallback;
  Recipe recipe;

  RecipePage(
    this.setPageCallback,
    this.recipe,
  );

  @override
  Widget build(BuildContext context) {
    String ingredientsText = "";

    recipe.ingredients.forEach((element) {
      ingredientsText +=
          (ingredientsText != "" ? "\n" : "") + "\u2022 " + element;
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          //image etc
          Stack(children: [
            Container(
              height: appConfig['blockSizeVertical'] * 25,
              width: appConfig['blockSize'] * 100,
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/e/e2/2015_0718_K%C3%A4sesp%C3%A4tzle_S%C3%B6lden.jpg',
                  fit: BoxFit.cover),
            ),
            Positioned.fill(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: appConfig['blockSizeVertical']),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SizedBox(width: appConfig['blockSize'] * 2),
                      IconBackButton(() => print("back")),
                      Expanded(child: Container()),
                      Container(
                        width: appConfig['blockSize'] * 10,
                        height: appConfig['blockSizeVertical'] * 7,
                        child: Icon(Icons.add, color: mint),
                        decoration: BoxDecoration(
                            color: inputColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(borderRadius),
                                bottomLeft: Radius.circular(borderRadius))),
                      ),
                    ]),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: appConfig['blockSize'] * 2),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Ratings(
                                (newRating) =>
                                    print("rated " + newRating.toString()),
                                recipe.stars),
                            Icon(Icons.favorite_border_rounded, color: mint)
                          ]),
                    )
                  ]),
            )),
          ]),
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(recipe.difficulty, style: parameterValueStyle),
                  Text(recipe.typeOfDish, style: parameterValueStyle),
                ]),
                Expanded(child: Container()),
                Column(children: [
                  Icon(Icons.schedule),
                  Icon(Icons.flag_outlined),
                ]),
                SizedBox(width: appConfig['blockSize'] * 3),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(recipe.time2make.toString() + " mins",
                      style: parameterValueStyle),
                  Text(recipe.countryOfOrigin, style: parameterValueStyle),
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
              children:
                  recipe.tags.asMap().entries.map((e) => Tag(e.value)).toList(),
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
                decoration: BoxDecoration(
                  color: fullwhite,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
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
                decoration: BoxDecoration(
                  color: fullwhite,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: appConfig['blockSize'] * 5,
                    vertical: appConfig['blockSizeVertical']),
                child: Text(recipe.prep,
                    style: parameterValueStyle.copyWith(
                        fontSize: 15, height: 1.75))),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Align(
                alignment: Alignment.topRight,
                child: FlatButton.icon(
                    icon: Icon(Icons.edit, color: gray),
                    onPressed: () => print("edit"),
                    label: Text('Edit', style: parameterStyle))),
          ),
        ],
      ),
    );
  }
}
