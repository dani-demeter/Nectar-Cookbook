import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class IconBackButton extends StatelessWidget {
  VoidCallback callback;

  IconBackButton(this.callback);

  @override
  Widget build(BuildContext context) {
    var sideLength = appConfig['blockSizeVertical'] * 7;
    return Container(
      width: sideLength,
      height: sideLength,
      child: ElevatedButton(
        onPressed: this.callback,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(offwhite),
        ),
        child: Icon(Icons.arrow_back, color: gray),
      ),
    );
  }
}
