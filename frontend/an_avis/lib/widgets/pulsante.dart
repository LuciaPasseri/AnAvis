import "package:flutter/material.dart";

class Pulsante extends StatelessWidget {
  const Pulsante({
    Key key,
    @required this.function,
    @required this.text,
  }) : super(key: key);

  final Function function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.blue[800],
      minWidth: 310.0,
      height: 55.0,
      child: RaisedButton(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 21,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
          ), onPressed: function
      ),
    );
  }
}