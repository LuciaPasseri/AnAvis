import 'package:an_avis/widgets/listview_questionario.dart';
import "package:flutter/material.dart";

class SchermataAggiuntaPrenotazione extends StatefulWidget {
  @override
  _SchermataAggiuntaPrenotazioneState createState() => _SchermataAggiuntaPrenotazioneState();
}

class _SchermataAggiuntaPrenotazioneState extends State<SchermataAggiuntaPrenotazione> {
  final _formKey = GlobalKey<FormState>();

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
          "Inserisci i dati",
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Per favore rispondere alla domanda';
                }
                return null;
              },
              cursorColor: Colors.blue[900],
              decoration: InputDecoration(
                hintText: "Inserire una data",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Per favore rispondere alla domanda';
                }
                return null;
              },
              cursorColor: Colors.blue[900],
              decoration: InputDecoration(
                hintText: "Inserire un'orario",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
              ),
            ),TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Per favore rispondere alla domanda';
                }
                return null;
              },
              cursorColor: Colors.blue[900],
              decoration: InputDecoration(
                hintText: "Tipo donazione",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Per favore rispondere alla domanda';
                }
                return null;
              },
              cursorColor: Colors.blue[900],
              decoration: InputDecoration(
                hintText: "Inserire tipo",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
