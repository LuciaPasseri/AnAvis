import 'package:an_avis/services/route_generator.dart';
import 'package:flutter/material.dart';

void main() => runApp(AnAvis());

class AnAvis extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
