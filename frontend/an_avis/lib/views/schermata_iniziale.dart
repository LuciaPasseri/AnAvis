import 'package:an_avis/views/remove_glow.dart';
import "package:flutter/material.dart";

class SchermataIniziale extends StatefulWidget {
  @override
  _SchermataInizialeState createState() => _SchermataInizialeState();
}

class _SchermataInizialeState extends State<SchermataIniziale> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: ScrollConfiguration(
        behavior: RemoveGlow(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(80, 120, 80, 50),
                  child: Image.asset("assets/images/logo_avis_bianco.png")),
              Text(
                "Benvenuto!",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Sei un donatore o una sede?",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    elevation: 8,
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Text(
                      "Donatore",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue[900],
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/login", arguments: true);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    elevation: 8,
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Text(
                      "Sede Avis",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue[900],
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/login", arguments: false);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
