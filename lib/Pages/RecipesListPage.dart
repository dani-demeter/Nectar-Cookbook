import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class RecipesListPage extends StatelessWidget {
  void Function(String, dynamic) setPageCallback;

  RecipesListPage(this.setPageCallback);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Welcome!",
              style:
                  titleStyle.copyWith(fontSize: appConfig['blockSize'] * 10)),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          InkWell(
              onTap: () => setPageCallback("addRecipe", null),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Container(
                height: appConfig['blockSizeVertical'] * 20,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: const Color(0xFF33A7FF),
                    boxShadow: [dropShadow]),
              )),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          InkWell(
              onTap: () => setPageCallback("findRecipe", null),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Container(
                height: appConfig['blockSizeVertical'] * 20,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: const Color(0xFF33A7FF),
                    boxShadow: [dropShadow]),
              )),
          SizedBox(height: appConfig['blockSizeVertical'] * 5),
          InkWell(
              onTap: () => print("Container pressed"),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Container(
                height: appConfig['blockSizeVertical'] * 10,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius)),
                    color: const Color(0xFF33A7FF),
                    boxShadow: [dropShadow]),
              )),
        ]));
  }
}
