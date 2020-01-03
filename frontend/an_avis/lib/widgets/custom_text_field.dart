import "package:flutter/material.dart";

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {@required this.text,
      @required this.validator,
      @required this.onSaved,
      this.icon,
      @required this.alignment,
      @required this.inputType,
      this.hiddenText,
      this.iconButton});

  final String text;
  final Function validator;
  final Function onSaved;
  final Icon icon;
  final TextAlign alignment;
  final TextInputType inputType;
  final bool hiddenText;
  final IconButton iconButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      textAlign: alignment,
      validator: validator,
      cursorColor: Colors.blue[900],
      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: iconButton == null ? null : iconButton,
        hintText: text,
        helperText: "",
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue[900], width: 2)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      obscureText: hiddenText == null ? false : hiddenText,
      onSaved: onSaved,
    );
  }
}
