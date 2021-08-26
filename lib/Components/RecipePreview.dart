import 'package:flutter/material.dart';
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
          onTap: () => setPageCallback("recipe", recipe, backCallback),
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
                      image: AssetImage('assets/images/cooking_bg1.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: appConfig['blockSizeVertical'],
                left: appConfig['blockSize'] * 3,
                child: Text(
                  recipe.title,
                  style: titleStyle.copyWith(color: offwhite),
                ),
              ),
            ]),
          ),
        ));
  }
}
