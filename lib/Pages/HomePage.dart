import 'package:flutter/material.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  void Function(String, dynamic, VoidCallback) setPageCallback;

  HomePage(this.setPageCallback);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome!",
              style:
                  titleStyle.copyWith(fontSize: appConfig['blockSize'] * 10)),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          //add a recipe
          InkWell(
            onTap: () => setPageCallback(
                "addRecipe",
                {'clear': true, 'setValues': false},
                () => setPageCallback("home", null, null)),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: Stack(
              children: [
                Container(
                  height: appConfig['blockSizeVertical'] * 20,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
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
                    "Add Recipe",
                    style: titleStyle.copyWith(color: offwhite),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          //find a recipe
          InkWell(
            onTap: () => setPageCallback(
                "findRecipe", true, () => setPageCallback("home", null, null)),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: Stack(
              children: [
                Container(
                  height: appConfig['blockSizeVertical'] * 20,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    boxShadow: [dropShadow],
                    image: DecorationImage(
                        image: AssetImage('assets/images/cooking_bg2.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: appConfig['blockSizeVertical'],
                  left: appConfig['blockSize'] * 3,
                  child: Text(
                    "Find a Recipe",
                    style: titleStyle.copyWith(color: offwhite),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          //favorites
          InkWell(
            onTap: () => setPageCallback(
                "recipesList",
                {
                  'criteria': {'favorite': true},
                  'title': "Favorites"
                },
                () => setPageCallback("home", null, null)),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: Stack(
              children: [
                Container(
                  height: appConfig['blockSizeVertical'] * 10,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    boxShadow: [dropShadow],
                    image: DecorationImage(
                        image: AssetImage('assets/images/cooking_bg3.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: appConfig['blockSizeVertical'],
                  left: appConfig['blockSize'] * 3,
                  child: Text(
                    "Favorites",
                    style: titleStyle.copyWith(color: offwhite),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          //all recipes
          InkWell(
            onTap: () => setPageCallback(
                "recipesList",
                {'criteria': <String, dynamic>{}, 'title': 'All Recipes'},
                () => setPageCallback("home", null, null)),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: Stack(
              children: [
                Container(
                  height: appConfig['blockSizeVertical'] * 10,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    boxShadow: [dropShadow],
                    image: DecorationImage(
                        image: AssetImage('assets/images/cooking_bg4.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: appConfig['blockSizeVertical'],
                  left: appConfig['blockSize'] * 3,
                  child: Text(
                    "All Recipes",
                    style: titleStyle.copyWith(color: offwhite),
                  ),
                ),
              ],
            ),
          ),

          // ElevatedButton(
          //     onPressed: () {
          //       writeRecipes({
          //         "Kasespatzle": new Recipe(
          //             "Kasespatzle",
          //             4,
          //             true,
          //             "Easy",
          //             30,
          //             "Entree",
          //             "Austria",
          //             <String>["Heavy", "Mate", "Konyi"],
          //             <String>[
          //               "20 tons of cheese",
          //               "12 pieces of spatzle",
          //               "one liter of ketchup",
          //               "a really long ingredient that i don't think will fit in one line, but maybe will?"
          //             ],
          //             "Put the cheese all together. Cook the cheese. Bake the cheese. Eat the cheese. Repeat."),
          //         "Kugloaf": new Recipe(
          //             "Kugloaf",
          //             5,
          //             false,
          //             "Easy",
          //             45,
          //             "Entree",
          //             "Hungary",
          //             <String>["Heavy", "Dani", "Konyi"],
          //             <String>[
          //               "20 tons of kug",
          //               "12 pieces of spatzle",
          //               "one liter of ketchup",
          //               "a really long ingredient that i don't think will fit in one line, but maybe will?"
          //             ],
          //             "Put the cheese all together. Cook the cheese. Bake the cheese. Eat the cheese. Repeat.")
          //       });
          //       readRecipes().then((value) {
          //         print(value);
          //         recipeBook = {};
          //         value.values.forEach((recipe2add) {
          //           recipeBook[recipe2add['title']] =
          //               Recipe.fromJson(recipe2add);
          //         });
          //       });
          //     },
          //     child: Container(color: Colors.red, width: 50, height: 50))
        ],
      ),
    );
  }
}
