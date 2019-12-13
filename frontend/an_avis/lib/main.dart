import 'package:an_avis/views/provvisoria_login.dart';
import 'package:an_avis/views/schermata_donatori.dart';
import 'package:an_avis/views/schermata_questionario.dart';
import 'package:an_avis/views/schermata_scelta_data.dart';
import 'package:an_avis/views/schermata_scelta_mese.dart';
import 'package:an_avis/views/schermata_scelta_sede.dart';
import 'package:an_avis/views/schermata_sede.dart';
import 'package:flutter/material.dart';

void main() => runApp(AnAvis());

class AnAvis extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => SchermataLogin(),
        "/donatore": (context) => SchermataDonatori(),
        "/sede": (context) => SchermataSede(),
        "/sceltaSede": (context) => SchermataSceltaSede(),
        "/sceltaMese": (context) => SchermataSceltaMese(),
        "/questionario": (context) => SchermataQuestionario(),
      },
    );
  }
}
