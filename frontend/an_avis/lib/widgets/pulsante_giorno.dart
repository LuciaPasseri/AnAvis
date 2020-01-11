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
    return Card(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: function,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.calendar_today,
                  color: Colors.blue[900],
                ),
                SizedBox(width: 15),
                Text(
                  text,
                  style: TextStyle(fontSize: 17),
                ),
                Spacer(),
                Icon(
                  Icons.check_circle,
                  color: Colors.blue[900],
                )
              ],
            )),
      ),
    );
  }
}
