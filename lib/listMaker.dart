import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class ListElement extends StatefulWidget {
  void Function(String) addNewTagCallback;
  void Function(int) removeTagCallback;
  int idx = 0;
  String value;
  ListElement(
      this.value, this.idx, this.addNewTagCallback, this.removeTagCallback) {
    print("creating element " +
        this.value.toString() +
        " " +
        this.idx.toString());
  }

  @override
  State<StatefulWidget> createState() =>
      _ListElementState(value, idx, addNewTagCallback, removeTagCallback);
}

class _ListElementState extends State<ListElement> {
  void Function(String) addNewTagCallback;
  void Function(int) removeTagCallback;
  int idx = 0;
  var txt = TextEditingController();
  bool finalized = false;
  String tagValue = "";

  _ListElementState(
      this.tagValue, this.idx, this.addNewTagCallback, this.removeTagCallback) {
    txt.text = this.tagValue;
    if (tagValue != "") {
      finalized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("list element being built: " + idx.toString() + " " + tagValue);
    return Row(
      children: [
        Flexible(
          child: TextField(
            onSubmitted: addTag,
            onChanged: (value) {
              setState(() {
                tagValue = value;
              });
            },
            controller: txt,
            maxLines: 1,
            decoration: InputDecoration(
              isDense: true,
              hintText: "Add new",
              hintStyle:
                  parameterValueStyle.copyWith(color: gray.withAlpha(100)),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: appConfig['blockSize'] * 3,
                  vertical: appConfig['blockSizeVertical'] * 2),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mint, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              filled: true,
              fillColor: fullwhite,
            ),
            style: parameterValueStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 2),
          child: finalized
              ? IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () => removeTagCallback(idx))
              : IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: tagValue.length > 0 ? gray : gray.withAlpha(100),
                  ),
                  onPressed: () => addTag(tagValue),
                ),
        )
      ],
    );
  }

  void addTag(String addedTag) {
    setState(() {
      if (!finalized) {
        print("added tag");
        if (addedTag.length != 0) {
          finalized = true;
          addNewTagCallback(addedTag);
        }
      }
    });
  }
}
