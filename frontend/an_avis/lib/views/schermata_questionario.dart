import 'package:an_avis/widgets/listview_questionario.dart';
import "package:flutter/material.dart";

class SchermataQuestionario extends StatefulWidget {
  @override
  _SchermataQuestionarioState createState() => _SchermataQuestionarioState();
}

class _SchermataQuestionarioState extends State<SchermataQuestionario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.red[900],
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        backgroundColor: Colors.blue[900],
        title: Text(
          "Compila il questionario",
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
            child: Row(
              children: <Widget>[
                Text("Domanda", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Roboto"),),
                Spacer(),
                Text("SI      NO", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
              ],
            ),
          ),
          ListQuestionario(),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                buttonColor: Colors.greenAccent[700],
                child: RaisedButton(
                  child: Text(
                    "Conferma",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  onPressed: () {},
                ),
              ),
              ButtonTheme(
                buttonColor: Colors.red,
                child: RaisedButton(
                  child: Text(
                    "Annulla",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/sceltaMese"));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
