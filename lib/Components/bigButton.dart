import 'package:flutter/material.dart';
import '../main.dart';

class BigButton extends StatelessWidget {
  VoidCallback callback;
  String text;

  BigButton(this.callback, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: this.callback,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
                horizontal: appConfig['blockSize'] * 10,
                vertical: appConfig['blockSizeVertical']),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(mint),
        ),
        child: Text(
          this.text,
          style: titleStyle.copyWith(color: fullwhite),
        ),
      ),
    );
  }
}
