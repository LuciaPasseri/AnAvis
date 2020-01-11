import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/models/sede.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:provider/provider.dart';

class SchermataPrenotazioni extends StatefulWidget {
  @override
  _SchermataPrenotazioniState createState() => _SchermataPrenotazioniState();
}

class _SchermataPrenotazioniState extends State<SchermataPrenotazioni> {
  Future<List<Card>> _getPrenotazioni() async {
    http.Response response =
        await http.get("http://10.0.2.2:8080/prenotazioni");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Card> prenotazioni = [];
      for (var d in data) {
        if (d["sede"]["citta"] ==
            Provider.of<SedeProvider>(context).getCittaSede())
          prenotazioni.add(Card(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 6,
                    ),
                    Icon(
                      Icons.assignment,
                      color: Colors.blue[800],
                      size: 28,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Data: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(d["data"]),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Orario: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(d["orario"]),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Tipo: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(d["tipoDonazione"].toLowerCase()),
                          ],
                        ),
                        !d["disponibilita"]
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Prenotazione effettuata da: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(d["donatore"]["nome"] +
                                      " " +
                                      d["donatore"]["cognome"] +
                                      " (" +
                                      d["donatore"]["gruppoSanguigno"] +
                                      ")"),
                                ],
                              )
                            : Text("Prenotazione ancora disponibile"),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red[700],
                        size: 26,
                      ),
                      onPressed: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Cancellare prenotazione?"),
                                content: new Text(
                                    "Così facendo la prenotazione verrà eliminata dal sistema."),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Chiudi"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("Accetta"),
                                    onPressed: () {
                                      setState(() {
                                        http.delete(
                                            "http://10.0.2.2:8080/prenotazioni/${d["idPrenotazione"]}");
                                      });
                                      print("wewe, rimossa");
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        });
                      },
                    ),
                  ],
                )),
          ));
      }
      return prenotazioni;
    } else {
      print(response.statusCode);
      return null;
    }
  }

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
          "Prenotazioni",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: FutureBuilder(
          future: _getPrenotazioni(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new RequestCircularLoading();
              case ConnectionState.active:
              case ConnectionState.waiting:
                return new RequestCircularLoading();
              case ConnectionState.done:
                if (snapshot.hasError) return new RequestCircularLoading();
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data.length == 0) {
                      return Center(
                        child: Text("Nessuna prenotazione disponibile"),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          snapshot.data[index],
                        ],
                      );
                    }
                  },
                );
            }
            return null;
          }),
    );
  }
}
