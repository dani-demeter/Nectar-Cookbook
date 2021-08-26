import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class ParameterDropdown extends StatefulWidget {
  void Function(String) onChangedCallback;
  String defaultValue;
  List<String> items;

  ParameterDropdown(this.defaultValue, this.items, this.onChangedCallback);

  @override
  State<StatefulWidget> createState() =>
      _ParameterDropdownState(defaultValue, items);
}

class _ParameterDropdownState extends State<ParameterDropdown> {
  var _value = "";
  var _items;
  _ParameterDropdownState(this._value, this._items);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: fullwhite,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        padding: EdgeInsets.symmetric(
            horizontal: appConfig['blockSize'] * 3,
            vertical: appConfig['blockSizeVertical']),
        child: DropdownButton<String>(
            isDense: true,
            underline: SizedBox(),
            value: _value,
            icon: Padding(
              padding: EdgeInsets.only(left: appConfig['blockSize'] * 2),
              child: Icon(Icons.arrow_downward_sharp),
            ),
            iconSize: appConfig['blockSize'] * 4,
            items: this._items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  width: appConfig['blockSize'] * 25,
                  child: Text(
                    value,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: parameterValueStyle,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                widget.onChangedCallback(newValue);
                _value = newValue;
              });
            }));
  }
}

class ParameterInput extends StatefulWidget {
  TextEditingController txt;

  ParameterInput(this.txt);

  @override
  State<StatefulWidget> createState() => _ParameterInputState();
}

class _ParameterInputState extends State<ParameterInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: appConfig['blockSize'] * 35,
        decoration: BoxDecoration(
            color: fullwhite,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        padding: EdgeInsets.symmetric(
            horizontal: appConfig['blockSize'] * 3,
            vertical: appConfig['blockSizeVertical']),
        child: TextField(
          maxLines: 1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            isCollapsed: true,
            suffix: Text(
              "mins",
              style: parameterValueStyle.copyWith(color: gray),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: appConfig['blockSize'] * 3,
                vertical: appConfig['blockSizeVertical']),
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
          controller: widget.txt,
        ));
  }
}
