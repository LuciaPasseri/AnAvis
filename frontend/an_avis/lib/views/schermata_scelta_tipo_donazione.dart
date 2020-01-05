import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/widgets/pulsante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchermataSceltaTipoDonazione extends StatefulWidget {
  @override
  _SchermataSceltaTipoDonazioneState createState() => _SchermataSceltaTipoDonazioneState();
}

class _SchermataSceltaTipoDonazioneState extends State<SchermataSceltaTipoDonazione> {
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
          "Scegli il tipo di donazione",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
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
                  text: "Sangue",
                  function: () {
                    Provider.of<PrenotazioneProvider>(context).setTipoDonazione("SANGUE");
                    Navigator.of(context).pushNamed('/sceltaSede');
                  }),
              SizedBox(
                height: 20,
              ),
              Pulsante(
                  text: "Plasma",
                  function: () {
                    Provider.of<PrenotazioneProvider>(context).setTipoDonazione("PLASMA");
                    Navigator.of(context).pushNamed("/sceltaSede");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}