import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../Components/Tag.dart';
import '../backButton.dart';

class RecipePage extends StatelessWidget {
  VoidCallback callback;
  final String title;
  final int stars;
  final bool favorited;
  final String difficulty;
  final int time2make;
  final String typeOfDish;
  final String countryOfOrigin;

  final List<String> tags;
  final List<String> ingredients;
  final String recipe;

  RecipePage(
      this.callback,
      this.title,
      this.stars,
      this.favorited,
      this.difficulty,
      this.time2make,
      this.typeOfDish,
      this.countryOfOrigin,
      this.tags,
      this.ingredients,
      this.recipe);

  @override
  Widget build(BuildContext context) {
    String ingredientsText = "";
    ingredients.forEach((element) {
      ingredientsText +=
          (ingredientsText != "" ? "\n" : "") + "\u2022 " + element;
    });

    return Column(
      children: [
        Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/e/e2/2015_0718_K%C3%A4sesp%C3%A4tzle_S%C3%B6lden.jpg'),
        SizedBox(height: appConfig['blockSizeVertical']),
        Text(this.title, style: titleStyle.copyWith(color: inputColor)),
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
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(this.difficulty),
              Text(this.time2make.toString() + "mins")
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(this.typeOfDish), Text(this.countryOfOrigin)],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
          child: Wrap(
            children: tags.asMap().entries.map((e) => Tag(e.value)).toList(),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Ingredients"),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
          child: Text(ingredientsText),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Recipe"),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
          child: Text(recipe),
        ),
      ],
    );
  }
}
