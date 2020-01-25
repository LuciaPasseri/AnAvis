import "package:flutter/material.dart";

class PulsanteSede extends StatelessWidget {
  const PulsanteSede({
    Key key,
    @required this.text,
    @required this.function,
  }) : super(key: key);

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: function,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.domain,
                  color: Colors.blue[900],
                ),
                SizedBox(width: 15),
                Text(
                  text,
                  style: TextStyle(fontFamily: "Nunito", fontSize: 17),
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.blue[900],
                )
              ],
            )),
      ),
    );
  }
}
