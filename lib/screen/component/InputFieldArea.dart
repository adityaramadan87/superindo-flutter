// @dart=2.9
import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Color borderColor;
  final Color focusBorderColor;
  final Color fillColor;
  final Color textColor;
  final FormFieldValidator<String> validator;
  final GestureTapCallback onTap;
  final bool readOnly;
  final int maxLines;
  final TextInputAction textInputAction;
  InputFieldArea({
    this.controller,
    this.hint,
    this.obscure,
    this.icon,
    this.textInputType,
    this.borderColor,
    this.focusBorderColor,
    this.fillColor,
    this.textColor,
    this.validator,
    this.onTap,
    bool readOnly,
    int maxLines,
    TextInputAction textInputAction
  }) : readOnly = readOnly ?? false,
  maxLines = maxLines ?? 1,
  textInputAction = textInputAction ?? TextInputAction.done;
  @override
  Widget build(BuildContext context) {
    return (new Container(
        child:  new TextFormField(
          controller: this.controller,
          keyboardType: textInputType,
          obscureText: obscure,
          onTap: onTap,
          readOnly: this.readOnly,
          maxLines: this.maxLines,
          textInputAction: textInputAction,
          style: TextStyle(
              color: this.textColor,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: this.validator,
          decoration: new InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: new BorderSide(color: this.borderColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: new BorderSide(color: this.focusBorderColor)
            ),
            fillColor: this.fillColor,
            filled: true,
            prefixIcon: Icon(
              icon,
              color: this.textColor,
            ),
            hintText: hint,
            hintStyle: TextStyle(color: this.textColor, fontSize: 15.0),
            contentPadding: const EdgeInsets.only(
                top: 20.0, right: 30.0, bottom: 20.0, left: 5.0),
          ),
        )
    ));
  }
}