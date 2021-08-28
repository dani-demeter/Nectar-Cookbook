import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ListElement extends StatefulWidget {
  void Function(String) addNewTagCallback;
  void Function(int) removeTagCallback;
  void Function(int, String) setTagCallback;
  List<String> Function(String) suggestionCallback;
  int idx = 0;
  String value;
  var txt;
  bool finalized = false;
  FocusNode fn;
  ListElement(
      this.value,
      this.idx,
      this.addNewTagCallback,
      this.removeTagCallback,
      this.setTagCallback,
      this.fn,
      this.suggestionCallback) {
    txt = TextEditingController(text: value);
    finalized = value != "";
  }

  @override
  State<ListElement> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TypeAheadField(
            animationStart: 0.0,
            animationDuration: Duration(milliseconds: 125),
            keepSuggestionsOnLoading: false,
            getImmediateSuggestions: false,
            hideOnEmpty: true,
            direction: AxisDirection.up,
            textFieldConfiguration: TextFieldConfiguration(
              focusNode: widget.fn,
              onSubmitted: (newVal) {
                addTag(newVal, context);
              },
              onEditingComplete: () {},
              onChanged: (newVal) {
                setState(() {
                  widget.value = newVal;
                });
              },
              controller: widget.txt,
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
            suggestionsCallback: widget.suggestionCallback,
            debounceDuration: Duration(milliseconds: 100),
            hideOnLoading: true,
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: Icon(Icons.tag),
                title: Text(suggestion, style: parameterValueStyle),
                dense: true,
                tileColor: fullwhite,
              );
            },
            onSuggestionSelected: (suggestion) {
              widget.fn.requestFocus();
              widget.txt.text = suggestion;
              addTag(suggestion, context);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: appConfig['blockSize'] * 2),
          child: widget.finalized
              ? IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: removeTag,
                )
              : IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: widget.value.length > 0 ? gray : gray.withAlpha(100),
                  ),
                  onPressed: () {
                    addTag(widget.value, context);
                  },
                ),
        )
      ],
    );
  }

  void addTag(String addedTag, BuildContext context) {
    setState(() {
      if (!widget.finalized) {
        if (addedTag.length != 0) {
          widget.finalized = true;
          widget.addNewTagCallback(addedTag);
        } else {
          unfocusElement(context);
        }
      } else {
        if (addedTag.length == 0) {
          removeTag();
        } else {
          unfocusElement(context);
          widget.setTagCallback(widget.idx, addedTag);
        }
      }
    });
  }

  void removeTag() {
    unfocusElement(context);
    widget.removeTagCallback(widget.idx);
  }

  void unfocusElement(BuildContext context) {
    widget.fn.unfocus();
    FocusScope.of(context).unfocus();
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
