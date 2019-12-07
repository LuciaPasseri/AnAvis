import "package:flutter/material.dart";

class PulsanteGiorno extends StatelessWidget {
  const PulsanteGiorno({
    Key key,
    @required this.text,
    @required this.function,
  }) : super(key: key);

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
      buttonColor: Colors.blue[50],
      minWidth: 300.0,
      height: 60.0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: RaisedButton(
            elevation: 12,
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
      ),
    );
  }
}
