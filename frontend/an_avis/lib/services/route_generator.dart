import 'package:an_avis/views/provvisoria_login.dart';
import 'package:an_avis/views/schermata_aggiunta_prenotazione.dart';
import 'package:an_avis/views/schermata_donatori.dart';
import 'package:an_avis/views/schermata_questionario.dart';
import 'package:an_avis/views/schermata_registrazione_donatore.dart';
import 'package:an_avis/views/schermata_scelta_data.dart';
import 'package:an_avis/views/schermata_scelta_mese.dart';
import 'package:an_avis/views/schermata_scelta_sede.dart';
import 'package:an_avis/views/schermata_scelta_tipo_donazione.dart';
import 'package:an_avis/views/schermata_sede.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/': 
        return MaterialPageRoute(builder: (_) => SchermataLogin());
      case '/donatore':
        return MaterialPageRoute(builder: (_) => SchermataDonatori());
      case '/sede':
        return MaterialPageRoute(builder: (_) => SchermataSede());
      case '/aggiuntaPrenotazione':
        return MaterialPageRoute(
            builder: (_) => SchermataAggiuntaPrenotazione());
      case '/registrazioneDonatore':
        return MaterialPageRoute(
            builder: (_) => SchermataRegistrazioneDonatore());
      case '/sceltaTipoDonazione':
        return MaterialPageRoute(
            builder: (_) => SchermataSceltaTipoDonazione());
      case '/sceltaSede':
        return MaterialPageRoute(builder: (_) => SchermataSceltaSede());
      case '/sceltaMese':
        return MaterialPageRoute(builder: (_) => SchermataSceltaMese());
      case '/sceltaData':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => SchermataSceltaData(meseIntero: args));
        }
        return _errorRoute();
      case '/questionario':
        return MaterialPageRoute(builder: (_) => SchermataQuestionario());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
