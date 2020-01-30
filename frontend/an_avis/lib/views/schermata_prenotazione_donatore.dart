import 'dart:convert';
import 'package:an_avis/models/donatore.dart';
import 'package:an_avis/services/http_service.dart';
import 'package:an_avis/widgets/targhetta_prenotazione.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import "package:flutter/material.dart";

class SchermataPrenotazioneDonatore extends StatefulWidget {
  @override
  _SchermataPrenotazioneDonatoreState createState() =>
      _SchermataPrenotazioneDonatoreState();
}

class _SchermataPrenotazioneDonatoreState
    extends State<SchermataPrenotazioneDonatore> {
  bool _isEmpty = true;
  HttpService _httpService = HttpService();

  Future _getPrenotazione() async {
    var prenotazioneGetCall = await _httpService.getCall(context,
        "http://10.0.2.2:8080/prenotazioni/donatore/${Donatore().getId()}");
    if (prenotazioneGetCall.isEmpty) return;
    var prenotazione = prenotazioneGetCall[0];
    var donatore = await _httpService.getCall(
        context, "http://10.0.2.2:8080/donatori/${Donatore().getId()}");
    var sede = await _httpService.getCall(
        context, "http://10.0.2.2:8080/sedi/${prenotazione["idSede"]}");
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
                                    style: TextStyle(fontFamily: "Nunito"),
                                  ),
                                  content: Text(
                                    "Così facendo la prenotazione verrà disdetta.",
                                    style: TextStyle(fontFamily: "Nunito"),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "Chiudi",
                                        style: TextStyle(fontFamily: "Nunito"),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                        child: Text(
                                          "Accetta",
                                          style:
                                              TextStyle(fontFamily: "Nunito"),
                                        ),
                                        onPressed: () async {
                                          var prenotazioneToPut = json.encode({
                                            "data": "${prenotazione["data"]}",
                                            "orario":
                                                "${prenotazione["orario"]}",
                                            "idSede":
                                                "${prenotazione["idSede"]}",
                                            "tipoDonazione":
                                                "${prenotazione["tipoDonazione"]}",
                                            "disponibilita": true,
                                            "id": "${prenotazione["id"]}",
                                          });
                                          var donatoreToPut = json.encode({
                                            "id": "${donatore["id"]}",
                                            "nome": "${donatore["nome"]}",
                                            "cognome": "${donatore["cognome"]}",
                                            "email": "${donatore["email"]}",
                                            "gruppoSanguigno":
                                                "${donatore["gruppoSanguigno"]}",
                                            "dataUltimaDonazione": "15-11-2019",
                                            "tipoUltimaDonazione":
                                                "${donatore["tipoUltimaDonazione"]}",
                                          });
                                          var responsePutPrenotazione =
                                              await _httpService.putCall(
                                            context,
                                            "http://10.0.2.2:8080/prenotazioni/${prenotazione["id"]}",
                                            prenotazioneToPut,
                                          );
                                          var responsePutDonatore =
                                              await _httpService.putCall(
                                                  context,
                                                  "http://10.0.2.2:8080/donatori/${Donatore().getId()}",
                                                  donatoreToPut);
                                          var responseDeleteQuestionario =
                                              await _httpService.deleteCall(
                                                  context,
                                                  "http://10.0.2.2:8080/questionari/${prenotazione["idQuestionario"]}");
                                          if (responsePutPrenotazione
                                                      .statusCode ==
                                                  200 &&
                                              responsePutDonatore.statusCode ==
                                                  200 &&
                                              responseDeleteQuestionario
                                                      .statusCode ==
                                                  200) {
                                            Navigator.pop(context);
                                            setState(() {
                                              _isEmpty = true;
                                            });
                                            Flushbar(
                                              isDismissible: true,
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Colors.green,
                                              messageText: Text(
                                                  "Prenotazione cancellata con successo",
                                                  style: TextStyle(
                                                      fontFamily: "Nunito",
                                                      color: Colors.white)),
                                            ).show(context);
                                          } else {
                                            Navigator.pop(context);
                                            Flushbar(
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Colors.red,
                                              messageText: Text(
                                                  "Qualcosa è andato storto",
                                                  style: TextStyle(
                                                      fontFamily: "Nunito",
                                                      color: Colors.white)),
                                            ).show(context);
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
                          "Gruppo sanguigno: " + donatore["gruppoSanguigno"],
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
                  future: _getPrenotazione(),
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
