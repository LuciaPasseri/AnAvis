import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:an_avis/models/donatore.dart';
import 'package:an_avis/widgets/pulsante.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class SchermataDonatori extends StatefulWidget {
  @override
  _SchermataDonatoriState createState() => _SchermataDonatoriState();
}

class _SchermataDonatoriState extends State<SchermataDonatori> {
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
                fontFamily: "Roboto",
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
                  text: "Prenota donazione",
                  icon: Icons.calendar_today,
                  function: () async {
                    var response =
                        await http.get("http://10.0.2.2:8080/donatori");
                    var donatori = jsonDecode(response.body);
                    for (var donatore in donatori) {
                      if (donatore["email"] ==
                          Provider.of<DonatoreProvider>(context).getEmail()) {
                        List<String> tempDate =
                            donatore["dataUltimaDonazione"].split("-");
                        String formattedDate =
                            tempDate[2] + tempDate[1] + tempDate[0];
                        Duration difference = DateTime.now()
                            .difference(DateTime.parse(formattedDate));
                        if (difference.inDays < 90) {
                          Flushbar(
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.red,
                            titleText: Text(
                              "Azione non possibile",
                              style: TextStyle(
                                  fontFamily: "Nunito", color: Colors.white),
                            ),
                            messageText: Text(
                              "Non puoi prenotare perché non sono passati 90 giorni dalla tua ultima donazione",
                              style: TextStyle(
                                  fontFamily: "Nunito", color: Colors.white),
                            ),
                          ).show(context);
                        } else {
                          Navigator.pushNamed(context, "/sceltaTipoDonazione");
                        }
                      }
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              Pulsante(
                text: "Visualizza prenotazione",
                icon: Icons.description,
                function: () {
                  Navigator.pushNamed(context, "/prenotazioneEffettuata");
                },
              ),
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
