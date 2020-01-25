import "package:flutter/material.dart";

class Pulsante extends StatelessWidget {
  const Pulsante({
    Key key,
    @required this.function,
    @required this.text,
    @required this.icon,
  }) : super(key: key);

  final Function function;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.blue[900],
      minWidth: 310.0,
      height: 58.0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(35, 6, 35, 0),
        child: RaisedButton(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 5,),
                Icon(
                    icon,
                    color: Colors.white,
                  ),
                SizedBox(
                  width: 21,
                ),
                Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Nunito",
                    ),
                  ),
              ],
            ),
            onPressed: function),
      ),
    );
  }
}
