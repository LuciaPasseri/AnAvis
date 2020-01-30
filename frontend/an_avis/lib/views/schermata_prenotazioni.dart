import 'dart:convert';

import 'package:an_avis/services/http_service.dart';
import 'package:an_avis/widgets/remove_glow.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:an_avis/models/sede.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class SchermataPrenotazioni extends StatefulWidget {
  @override
  _SchermataPrenotazioniState createState() => _SchermataPrenotazioniState();
}

class _SchermataPrenotazioniState extends State<SchermataPrenotazioni> {
  bool _isEmpty = true;
  bool _isFiltered = false;
  DateTime _data;
  int _countPrenotazioni;
  HttpService _httpService = HttpService();

  Future<List<Card>> _getPrenotazioni() async {
    _countPrenotazioni = 0;
    var dataPrenotazioni = await _httpService.getCall(
        context, "http://10.0.2.2:8080/prenotazioni/sede/${Sede().getId()}");
    List<Card> prenotazioni = [];
    for (var prenotazione in dataPrenotazioni) {
      var donatore;
      if (prenotazione["idDonatore"] != null) {
        donatore = await _httpService.getCall(context,
            "http://10.0.2.2:8080/donatori/${prenotazione["idDonatore"]}");
      }
      _countPrenotazioni++;
      _isEmpty = false;
      prenotazioni.add(Card(
        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          prenotazione["data"],
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Orario: ",
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          prenotazione["orario"],
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Tipo: ",
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          prenotazione["tipoDonazione"].toLowerCase(),
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      ],
                    ),
                    !prenotazione["disponibilita"]
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Prenotazione effettuata da: ",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                donatore["nome"] +
                                    " " +
                                    donatore["cognome"] +
                                    " (" +
                                    donatore["gruppoSanguigno"] +
                                    ")",
                                style: TextStyle(fontFamily: "Nunito"),
                              ),
                            ],
                          )
                        : Text("Prenotazione ancora disponibile",
                            style: TextStyle(fontFamily: "Nunito")),
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text(
                            "Cancellare prenotazione?",
                            style: TextStyle(fontFamily: "Nunito"),
                          ),
                          content: new Text(
                            "Così facendo la prenotazione verrà eliminata dal sistema.",
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
                                style: TextStyle(fontFamily: "Nunito"),
                              ),
                              onPressed: () async {
                                if (!prenotazione["disponibilita"]) {
                                  var donatoreToPut = jsonEncode({
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
                                  var responsePutDonatore =
                                      await _httpService.putCall(
                                          context,
                                          "http://10.0.2.2:8080/donatori/${donatore["id"]}}",
                                          donatoreToPut);
                                  var responseDeleteQuestionario =
                                      await _httpService.deleteCall(context,
                                          "http://10.0.2.2:8080/questionari/${prenotazione["idQuestionario"]}");
                                  var responseDeletePrenotazione =
                                      await _httpService.deleteCall(
                                    context,
                                    "http://10.0.2.2:8080/prenotazioni/${prenotazione["id"]}",
                                  );
                                  print("PORCOSIDODOOD " + donatore["id"]);
                                  print(responsePutDonatore.statusCode);
                                  print(responseDeletePrenotazione.statusCode);
                                  if (responsePutDonatore.statusCode == 200 &&
                                      responseDeleteQuestionario.statusCode ==
                                          200 &&
                                      responseDeletePrenotazione.statusCode ==
                                          200) {
                                    Flushbar(
                                      isDismissible: true,
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.green,
                                      messageText: Text(
                                          "Prenotazione eliminata correttamente",
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              color: Colors.white)),
                                    ).show(context);
                                  }
                                } else {
                                  _httpService.deleteCallWithSnackbar(
                                      context,
                                      "http://10.0.2.2:8080/prenotazioni/${prenotazione["id"]}",
                                      "Prenotazione eliminata correttamente");
                                }
                                _countPrenotazioni--;
                                if (_countPrenotazioni == 0) {
                                  setState(() {
                                    _isEmpty = true;
                                  });
                                }
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            )),
      ));
    }
    /*prenotazioni.sort((a, b) {
      List<String> dataA = a.data.split("-");
      List<String> dataB = b.data.split("-");
      List<String> oraEMinutiA = a.orario.split(" : ");
      List<String> oraEMinutiB = b.orario.split(" : ");
      int annoA = int.parse(dataA[0]);
      int meseA = int.parse(dataA[1]);
      int giornoA = int.parse(dataA[2]);
      int annoB = int.parse(dataB[0]);
      int meseB = int.parse(dataB[1]);
      int giornoB = int.parse(dataB[2]);
      int oraA = int.parse(oraEMinutiA[0]);
      int minutiA = int.parse(oraEMinutiA[1]);
      int oraB = int.parse(oraEMinutiB[0]);
      int minutiB = int.parse(oraEMinutiB[1]);
      if ((annoA > annoB) ||
          ((annoA == annoB) && meseA > meseB) ||
          (annoA == annoB && meseA == meseB && giornoA > giornoB) ||
          (a.data == b.data && oraA > oraB ||
              oraA == oraB && minutiA > minutiB)) {
        return 1;
      } else {
        return -1;
      }
    });*/
    return prenotazioni;
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
              fontFamily: "Nunito",
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Card(
              color: Colors.white,
              elevation: 8,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Row(
                children: <Widget>[
                  ButtonTheme(
                    buttonColor: Colors.white,
                    minWidth: 310.0,
                    height: 55.0,
                    child: RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25)),
                        ),
                        child: !_isFiltered
                            ? Text(
                                "Scegli un giorno per filtrare",
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Nunito",
                                ),
                              )
                            : Text(
                                "Giorno selezionato: ${DateFormat('dd-MM-yyyy').format(_data)}",
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Nunito",
                                ),
                              ),
                        onPressed: () async {
                          final now = DateTime.now();
                          DateTime data = await showDatePicker(
                            context: context,
                            initialDate:
                                DateTime(now.year, now.month, now.day + 1),
                            firstDate:
                                DateTime(now.year, now.month, now.day + 1),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  primaryColor: Colors.blue[900],
                                  accentColor: Colors.red[900],
                                ),
                                child: child,
                              );
                            },
                          );
                          if (data != null) {
                            setState(() {
                              _data = data;
                              _isFiltered = true;
                            });
                          }
                        }),
                  ),
                  IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      color: Colors.red[900],
                      disabledColor: Colors.grey,
                      icon: Icon(
                        Icons.clear,
                      ),
                      onPressed: _isFiltered
                          ? () {
                              setState(() {
                                _isFiltered = false;
                              });
                            }
                          : null),
                ],
              ),
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
                        if (_isEmpty && _countPrenotazioni == 0) {
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
                                          "Nessuna prenotazione disponibile",
                                          style:
                                              TextStyle(fontFamily: "Nunito"),
                                        ))),
                              ],
                            ),
                          );
                        } else {
                          return ScrollConfiguration(
                            behavior: RemoveGlow(),
                            child: ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return !_isFiltered
                                    ? snapshot.data[index]
                                    : snapshot.data[index].data ==
                                            DateFormat('dd-MM-yyyy')
                                                .format(_data)
                                        ? snapshot.data[index]
                                        : Container();
                              },
                            ),
                          );
                        }
                    }
                    return null;
                  }),
            ),
          ],
        ));
  }
}
