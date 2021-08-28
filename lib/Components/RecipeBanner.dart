import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:io';
import 'backButton.dart';
import '../Components/Ratings.dart';
import 'package:image_picker/image_picker.dart';

class RecipeBanner extends StatefulWidget {
  VoidCallback backCallback;
  Recipe recipe;
  RecipeBanner(this.backCallback, this.recipe);

  @override
  State<RecipeBanner> createState() => _RecipeBannerState();
}

class _RecipeBannerState extends State<RecipeBanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: appConfig['blockSizeVertical'] * 25,
        width: appConfig['blockSize'] * 100,
        child: Image(
            image: (widget.recipe.imagePath == null ||
                    widget.recipe.imagePath == "")
                ? AssetImage('assets/images/new_food.jpg')
                : FileImage(File(widget.recipe.imagePath)),
            fit: BoxFit.cover),
      ),
      Positioned.fill(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: appConfig['blockSizeVertical']),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  SizedBox(width: appConfig['blockSize'] * 2),
                  IconBackButton(widget.backCallback),
                  Expanded(child: Container()),
                  Container(
                    width: appConfig['blockSize'] * 10,
                    height: appConfig['blockSizeVertical'] * 7,
                    child: IconButton(
                      icon: Icon(Icons.photo, color: mint),
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          widget.recipe.imagePath = image.path;
                          recipeBook[widget.recipe.id].imagePath = image.path;
                          writeRecipes(recipeBook);
                          setState(() {});
                        }
                      },
                    ),
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
                        Ratings((newRating) {
                          recipeBook[widget.recipe.id].stars = newRating;
                          writeRecipes(recipeBook);
                        }, widget.recipe.stars),
                        Favorited((newFavorited) {
                          recipeBook[widget.recipe.id].favorited = newFavorited;
                          writeRecipes(recipeBook);
                        }, widget.recipe.favorited)
                      ]),
                )
              ]),
        ),
      ),
    ]);
  }
}
