import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class Tag extends StatelessWidget {
  final String text;

  Tag(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 1),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: appConfig['blockSize'] * 3,
              vertical: appConfig['blockSizeVertical'] / 2),
          decoration: BoxDecoration(
              color: inputColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          child: Text(
            this.text,
            style: parameterValueStyle.copyWith(color: offwhite),
          ),
        ));
  }
}
