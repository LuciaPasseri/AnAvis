import 'package:an_avis/models/donatore.dart';
import 'package:an_avis/widgets/targhetta_prenotazione.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  dynamic _prenotazione;
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
        if (prenotazione["idDonatore"] ==
            Provider.of<DonatoreProvider>(context).getId()) {
          var donatore = _getDonatore(prenotazione["idDonatore"]);
          var sede = _getSede(prenotazione["idSede"]);
          if (donatore != null) {
            _prenotazione = prenotazione;
            _isEmpty = false;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    elevation: 6,
                    margin: EdgeInsets.fromLTRB(20, 15, 20, 30),
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Donazione prenotata per il:",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          TargettaPrenotazione(
                            isType: false,
                            data: prenotazione,
                            label: "Data",
                            icon: Icons.calendar_today,
                            edgeInsets1: EdgeInsets.fromLTRB(5, 15, 0, 0),
                            edgeInsets2: EdgeInsets.fromLTRB(8.5, 0, 8.5, 0),
                            jsonTag: "data",
                          ),
                          TargettaPrenotazione(
                            isType: false,
                            data: prenotazione,
                            label: "Orario",
                            icon: Icons.access_time,
                            edgeInsets1: EdgeInsets.only(left: 5),
                            edgeInsets2: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            jsonTag: "orario",
                          ),
                          TargettaPrenotazione(
                            isType: false,
                            data: sede,
                            label: "Sede",
                            icon: Icons.domain,
                            edgeInsets1: EdgeInsets.only(left: 5),
                            edgeInsets2: EdgeInsets.fromLTRB(7, 0, 7, 0),
                            jsonTag: "citta",
                          ),
                          TargettaPrenotazione(
                            isType: true,
                            data: prenotazione,
                            label: "Tipo",
                            icon: Icons.invert_colors,
                            edgeInsets1: EdgeInsets.only(left: 5),
                            edgeInsets2: EdgeInsets.fromLTRB(9, 0, 9, 0),
                            jsonTag: "tipoDonazione",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              RaisedButton(
                                  elevation: 4,
                                  color: Colors.red[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Disdici",
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Disdire prenotazione?",
                                            style:
                                                TextStyle(fontFamily: "Nunito"),
                                          ),
                                          content: Text(
                                            "Così facendo la prenotazione verrà disdetta.",
                                            style:
                                                TextStyle(fontFamily: "Nunito"),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                "Chiudi",
                                                style: TextStyle(
                                                    fontFamily: "Nunito"),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                                child: Text(
                                                  "Accetta",
                                                  style: TextStyle(
                                                      fontFamily: "Nunito"),
                                                ),
                                                onPressed: () async {
                                                  var prenotazione =
                                                      json.encode({
                                                    "data":
                                                        _prenotazione["data"],
                                                    "orario":
                                                        _prenotazione["orario"],
                                                    "idSede":
                                                        _prenotazione["idSede"],
                                                    "tipoDonazione":
                                                        _prenotazione[
                                                            "tipoDonazione"],
                                                    "disponibilita": true,
                                                    "id": _prenotazione["id"],
                                                  });
                                                  http.Response
                                                      putPrenotazione =
                                                      await http.put(
                                                    Uri.parse(
                                                        "http://10.0.2.2:8080/prenotazioni/${_prenotazione["id"]}"),
                                                    body: prenotazione,
                                                    headers: {
                                                      "content-type":
                                                          "application/json; charset=utf-8",
                                                      "accept":
                                                          "application/json; charset=utf-8",
                                                    },
                                                  );
                                                  Navigator.of(context).pop();
                                                  if (putPrenotazione
                                                          .statusCode ==
                                                      200) {
                                                    Flushbar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      duration:
                                                          Duration(seconds: 2),
                                                      message:
                                                          "Prenotazione cancellata",
                                                    ).show(context);
                                                    setState(() {
                                                      _isEmpty = true;
                                                    });
                                                  }
                                                })
                                          ],
                                        );
                                      },
                                    );
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    elevation: 6,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    color: Colors.red[900],
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Informazioni donatore",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 22,
                                color: Colors.white),
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
                                      fontFamily: "Nunito",
                                      color: Colors.white,
                                      fontSize: 16),
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
                                      fontFamily: "Nunito",
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
              fontFamily: "Nunito",
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
                                          "Nessuna prenotazione effettuata",
                                          style: TextStyle(
                                            fontFamily: "Nunito",
                                          ),
                                        ))),
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
