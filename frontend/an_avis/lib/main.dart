import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/models/questionario.dart';
import 'package:an_avis/models/sede.dart';
import 'package:an_avis/services/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/donatore.dart';

void main() => runApp(AnAvis());

class AnAvis extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => PrenotazioneProvider(),
        ),
        ChangeNotifierProvider(
          builder: (context) => QuestionarioProvider(),
        ),
        ChangeNotifierProvider(
          builder: (context) => DonatoreProvider(),
        ),
        ChangeNotifierProvider(
          builder: (context) => SedeProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
        )
    );
  }
}
