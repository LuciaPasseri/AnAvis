import 'package:an_avis/widgets/pulsante.dart';
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
          child: Text(
            "AnAvis",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
          ),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Pulsante(
                  text: "Inserisci prenotazione",
                  function: () {
                    Navigator.pushNamed(context, "/aggiuntaPrenotazione");
                  }),
              SizedBox(
                height: 20,
              ),
              Pulsante(
                  text: "Visualizza prenotazioni",
                  function: () {
                    Navigator.pushNamed(context, "/sceltaSede");
                  }),
              SizedBox(
                height: 20,
              ),
              Pulsante(
                  text: "Registra donatore",
                  function: () {
                    Navigator.pushNamed(context, "/sceltaSede");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
