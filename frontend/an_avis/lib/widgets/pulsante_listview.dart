import "package:flutter/material.dart";

class PulsanteListView extends StatelessWidget {
  const PulsanteListView({
    Key key,
    @required this.text,
    @required this.function,
  }) : super(key: key);

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.blue[50],
      minWidth: 325.0,
      height: 60.0,
      child: RaisedButton(
          elevation: 15,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red[900],
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
          ),
          onPressed: function),
    );
  }
}
