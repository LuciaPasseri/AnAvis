import 'package:an_avis/widgets/pulsante.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SchermataSede extends StatefulWidget {
  @override
  _SchermataSedeState createState() => _SchermataSedeState();
}

class _SchermataSedeState extends State<SchermataSede> {
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
        title: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(children: <Widget>[
            Text(
              "Avis",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Nunito",
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(Icons.invert_colors),
          ]),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 35,
              ),
              Pulsante(
                text: "Inserisci prenotazione",
                icon: Icons.note_add,
                function: () {
                  Navigator.pushNamed(context, "/aggiuntaPrenotazione");
                },
              ),
              SizedBox(
                height: 20,
              ),
              Pulsante(
                  text: "Visualizza prenotazioni",
                  icon: Icons.description,
                  function: () {
                    Navigator.pushNamed(context, "/prenotazioni");
                  }),
              SizedBox(
                height: 20,
              ),
              Pulsante(
                  text: "Registra donatore",
                  icon: Icons.person_add,
                  function: () {
                    Navigator.pushNamed(context, "/registrazioneDonatore");
                  }),
              SizedBox(
                height: 20,
              ),
              Pulsante(
                text: "Disconnettiti",
                icon: Icons.exit_to_app,
                function: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, "/");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
