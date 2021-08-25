import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  void Function(String, dynamic) setPageCallback;

  HomePage(this.setPageCallback);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Welcome!",
            style: titleStyle.copyWith(fontSize: appConfig['blockSize'] * 10)),
        SizedBox(height: appConfig['blockSizeVertical'] * 5),
        Stack(children: [
          InkWell(
            onTap: () => setPageCallback("addRecipe", null),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: Container(
              height: appConfig['blockSizeVertical'] * 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: const Color(0xFF33A7FF),
                  boxShadow: [dropShadow]),
            ),
          ),
          Text("Add Recipe", style: titleStyle.copyWith(color: offwhite))
        ]),
        SizedBox(height: appConfig['blockSizeVertical'] * 5),
        Stack(children: [
          InkWell(
            onTap: () => setPageCallback("findRecipe", null),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: Container(
              height: appConfig['blockSizeVertical'] * 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: const Color(0xFF33A7FF),
                  boxShadow: [dropShadow]),
            ),
          ),
          Text("Find a Recipe", style: titleStyle.copyWith(color: offwhite))
        ]),
        SizedBox(height: appConfig['blockSizeVertical'] * 5),
        Stack(children: [
          InkWell(
            onTap: () => print("Container pressed"),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: Container(
              height: appConfig['blockSizeVertical'] * 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  color: const Color(0xFF33A7FF),
                  boxShadow: [dropShadow]),
            ),
          ),
          Text("Favorites", style: titleStyle.copyWith(color: offwhite))
        ]),
        ElevatedButton(
            onPressed: () {
              // writeRecipes([
              //   new Recipe(
              //       "Kasespatzle",
              //       4,
              //       true,
              //       "Easy",
              //       30,
              //       "Entree",
              //       "Austria",
              //       <String>["Heavy", "Mate", "Konyi"],
              //       <String>[
              //         "20 tons of cheese",
              //         "12 pieces of spatzle",
              //         "one liter of ketchup",
              //         "a really long ingredient that i don't think will fit in one line, but maybe will?"
              //       ],
              //       "Put the cheese all together. Cook the cheese. Bake the cheese. Eat the cheese. Repeat."),
              //   new Recipe(
              //       "Kugloaf",
              //       5,
              //       false,
              //       "Easy",
              //       30,
              //       "Entree",
              //       "Austria",
              //       <String>["Heavy", "Dani", "Konyi"],
              //       <String>[
              //         "20 tons of kug",
              //         "12 pieces of spatzle",
              //         "one liter of ketchup",
              //         "a really long ingredient that i don't think will fit in one line, but maybe will?"
              //       ],
              //       "Put the cheese all together. Cook the cheese. Bake the cheese. Eat the cheese. Repeat.")
              // ]);
              readRecipes().then((value) {
                print(value['recipes'][0]['ingredients'][0]);
              });
            },
            child: Container(color: Colors.red, width: 50, height: 50))
      ]),
    );
  }
}
