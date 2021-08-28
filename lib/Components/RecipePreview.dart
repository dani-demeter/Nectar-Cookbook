import 'package:flutter/material.dart';
import 'dart:io';
import '../main.dart';

class RecipePreview extends StatelessWidget {
  void Function(String, dynamic, VoidCallback) setPageCallback;
  VoidCallback backCallback;
  Recipe recipe;

  RecipePreview(this.setPageCallback, this.backCallback, this.recipe);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: appConfig['blockSizeVertical'] * 1),
        child: InkWell(
          onTap: () => setPageCallback("recipe", recipe.id, backCallback),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
            child: Stack(children: [
              Container(
                height: appConfig['blockSizeVertical'] * 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  boxShadow: [dropShadow],
                  image: DecorationImage(
                      image:
                          (recipe.imagePath == null || recipe.imagePath == "")
                              ? AssetImage('assets/images/new_food.jpg')
                              : FileImage(File(recipe.imagePath)),
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: gray.withAlpha(200),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      bottomRight: Radius.circular(borderRadius),
                    ),
                  ),
                  width: appConfig['blockSize'] * 100,
                  child: Padding(
                    padding: EdgeInsets.only(left: appConfig['blockSize'] * 3),
                    child: Text(
                      recipe.title,
                      style: titleStyle.copyWith(color: offwhite),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
