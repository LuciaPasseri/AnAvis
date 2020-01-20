import 'package:flutter_svg/flutter_svg.dart';
import 'package:an_avis/models/sede.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:provider/provider.dart';

class SchermataPrenotazioneDonatore extends StatefulWidget {
  @override
  _SchermataPrenotazioneDonatoreState createState() =>
      _SchermataPrenotazioneDonatoreState();
}

class _SchermataPrenotazioneDonatoreState
    extends State<SchermataPrenotazioneDonatore> {
  dynamic _dataDonatori;
  dynamic _dataSedi;
  bool _isEmpty = true;

  dynamic _getDonatore(String idDonatore) {
    for (var donatore in _dataDonatori) {
      if (donatore["idDonatore"] == idDonatore) {
        return donatore;
      }
    }
    return null;
  }

  dynamic _getSede(String idSede) {
    for (var sede in _dataSedi) {
      if (sede["id"] == idSede) {
        return sede;
      }
    }
  }

  Future _getPrenotazioni() async {
    http.Response responsePrenotazioni =
        await http.get("http://10.0.2.2:8080/prenotazioni");
    http.Response responseDonatori =
        await http.get("http://10.0.2.2:8080/donatori");
    http.Response responseSedi = await http.get("http://10.0.2.2:8080/sedi");
    if (responsePrenotazioni.statusCode == 200 &&
        responseDonatori.statusCode == 200 &&
        responseSedi.statusCode == 200) {
      var dataPrenotazioni = jsonDecode(responsePrenotazioni.body);
      _dataDonatori = jsonDecode(responseDonatori.body);
      _dataSedi = jsonDecode(responseSedi.body);
      for (var prenotazione in dataPrenotazioni) {
        if (prenotazione["idSede"] ==
            Provider.of<SedeProvider>(context).getId()) {
          var donatore = _getDonatore(prenotazione["idDonatore"]);
          var sede = _getSede(prenotazione["idSede"]);
          if (donatore != null) {
            _isEmpty = false;
            return Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(25, 15, 20, 30),
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Donazione prenotata per il:",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.blue[900],
                                size: 24,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                prenotazione["data"],
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.blue[900],
                                size: 24,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Orario: " + prenotazione["orario"],
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.domain,
                                color: Colors.blue[900],
                                size: 24,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Sede: " + sede["citta"],
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.invert_colors,
                                color: Colors.blue[900],
                                size: 24,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Tipo donazione: " +
                                    prenotazione["tipoDonazione"].toLowerCase(),
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          children: <Widget>[
                            Spacer(),
                            Ink(
                              padding: EdgeInsets.all(0),
                              decoration: ShapeDecoration(
                                color: Colors.red[900],
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  size: 25,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: new Text(
                                            "Cancellare prenotazione?"),
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
                                                _isEmpty = true;
                                                http.delete(
                                                    "http://10.0.2.2:8080/prenotazioni/${prenotazione["id"]}");
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 85,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(25, 15, 20, 30),
                  color: Colors.red[900],
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Informazioni donatore",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Nome e cognome: " +
                                    donatore["nome"] +
                                    " " +
                                    donatore["cognome"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.invert_colors,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Gruppo sanguigno: " +
                                    donatore["gruppoSanguigno"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }
      }
    } else {
      print(responsePrenotazioni.statusCode);
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
            "Prenotazione",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder(
                  future: _getPrenotazioni(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return new RequestCircularLoading();
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return new RequestCircularLoading();
                      case ConnectionState.done:
                        if (snapshot.hasError)
                          return new RequestCircularLoading();
                        if (_isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/images/no_data.svg",
                                  height: 240,
                                  width: 240,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Card(
                                    elevation: 3,
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                            "Nessuna prenotazione effettuata"))),
                              ],
                            ),
                          );
                        } else {
                          return snapshot.data;
                        }
                    }
                    return null;
                  }),
            ),
          ],
        ));
  }
}
