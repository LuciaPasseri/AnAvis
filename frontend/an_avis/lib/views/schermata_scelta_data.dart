import 'dart:convert';
import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import 'package:an_avis/widgets/pulsante_giorno.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';

class SchermataSceltaData extends StatefulWidget {
  @override
  _SchermataSceltaDataState createState() => _SchermataSceltaDataState();
}

class _SchermataSceltaDataState extends State<SchermataSceltaData> {
  String _oraSelezionata;
  bool isEmpty = true;

  String _getData(String data) {
    List<String> temp = data.split("-");
    return temp[2];
  }

  String _getMese(String data) {
    List<String> temp = data.split("-");
    return temp[1];
  }

  int _getAnno(String data) {
    List<String> temp = data.split("-");
    return int.parse(temp[0]);
  }

  bool _checkDuplicateDay(List<PulsanteGiorno> list, String giorno) {
    for (var pulsante in list) {
      if (pulsante.text.substring(0, 2) == giorno) return false;
    }
    return true;
  }

  bool _checkDuplicateHour(List<DropdownMenuItem<String>> list, String ora) {
    for (var item in list) {
      if (item.value == ora) return false;
    }
    return true;
  }

  Future<List<PulsanteGiorno>> _getGiorniPrenotazioni() async {
    http.Response response =
        await http.get("http://10.0.2.2:8080/prenotazioni");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<PulsanteGiorno> giorniPrenotazioni = [];
      for (var d in data) {
        if (d["disponibilita"] &&
            d["tipoDonazione"] ==
                Provider.of<PrenotazioneProvider>(context).getTipoDonazione() &&
            _checkDuplicateDay(giorniPrenotazioni, _getData(d["data"])) &&
            d["sede"]["citta"] ==
                Provider.of<PrenotazioneProvider>(context).getCittaSede() &&
            _getAnno(d["data"]) == DateTime.now().year &&
            _getMese(d["data"]) ==
                Provider.of<PrenotazioneProvider>(context).getMese()) {
          isEmpty = false;
          giorniPrenotazioni.add(PulsanteGiorno(
            text: _getData(d["data"]) +
                " " +
                Provider.of<PrenotazioneProvider>(context).getMeseCompleto(),
            function: () {
              Provider.of<PrenotazioneProvider>(context)
                  .setGiorno(((_getData(d["data"]))));
              Provider.of<PrenotazioneProvider>(context).setData();
              print(Provider.of<PrenotazioneProvider>(context).getMese());
              print(Provider.of<PrenotazioneProvider>(context).getData());
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, setState) {
                    return Container(
                      height: 390,
                      color: Color(0xFF737373),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0))),
                        padding: EdgeInsets.all(35),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Scegli l'orario",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(25),
                              child: FutureBuilder(
                                  future: _getOrari(),
                                  builder: (BuildContext mainContext,
                                      AsyncSnapshot snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                        return new RequestCircularLoading();
                                      case ConnectionState.active:
                                      case ConnectionState.waiting:
                                        return new RequestCircularLoading();
                                      case ConnectionState.done:
                                        if (snapshot.hasError)
                                          return new RequestCircularLoading();
                                        return DropdownButton(
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          isExpanded: true,
                                          value: _oraSelezionata,
                                          items: snapshot.data,
                                          onChanged: (value) {
                                            setState(() {
                                              _oraSelezionata = value;
                                            });
                                          },
                                        );
                                    }
                                    return null;
                                  }),
                            ),
                            ButtonTheme(
                              minWidth: 300,
                              height: 50,
                              buttonColor: Colors.blue[800],
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text(
                                  "Compila questionario",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/questionario");
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ButtonTheme(
                                  buttonColor: Colors.greenAccent[700],
                                  child: RaisedButton(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                    ),
                                    onPressed: () {
                                      if (_oraSelezionata != null &&
                                          Provider.of<PrenotazioneProvider>(
                                                      context)
                                                  .getQuestionarioCompilato() !=
                                              null) {
                                        Provider.of<PrenotazioneProvider>(
                                                context)
                                            .setQuestionarioCompilato(null);
                                        Flushbar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.green,
                                          message: "Prenotazione confermata!",
                                        ).show(context);
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              "/donatore",
                                              (route) => route.isFirst);
                                        });
                                      } else if (Provider.of<
                                                  PrenotazioneProvider>(context)
                                              .getQuestionarioCompilato() ==
                                          null) {
                                        Flushbar(
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                          message:
                                              "Compilare prima il questionario!",
                                        ).show(context);
                                      } else {
                                        Flushbar(
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                          message: "Inserire un orario!",
                                        ).show(context);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ButtonTheme(
                                  buttonColor: Colors.red,
                                  child: RaisedButton(
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                    ),
                                    onPressed: () {
                                      Provider.of<PrenotazioneProvider>(context)
                                          .setQuestionarioCompilato(null);
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          "/donatore",
                                          (route) => route.isFirst);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            },
          ));
        }
      }
      return giorniPrenotazioni;
    } else {
      print(response.statusCode);
    }
    return null;
  }

  Future<List<DropdownMenuItem<String>>> _getOrari() async {
    http.Response response =
        await http.get("http://10.0.2.2:8080/prenotazioni");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<DropdownMenuItem<String>> orari = [];
      for (var d in data) {
        if (d["disponibilita"] &&
            _checkDuplicateHour(orari, d["orario"]) &&
            d["tipoDonazione"] ==
                Provider.of<PrenotazioneProvider>(context).getTipoDonazione() &&
            d["sede"]["citta"] ==
                Provider.of<PrenotazioneProvider>(context).getCittaSede() &&
            d["data"] == Provider.of<PrenotazioneProvider>(context).getData()) {
          orari.add(DropdownMenuItem(
            child: Text(d["orario"]),
            value: d["orario"],
          ));
        }
      }
      return orari;
    } else {
      print(response.statusCode);
    }
    return null;
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
          "Scegli il giorno",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
              child: FutureBuilder(
                  future: _getGiorniPrenotazioni(),
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
                        if (isEmpty) {
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
                                            "Nessuna prenotazione disponibile"))),
                              ],
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return snapshot.data[index];
                            },
                          );
                        }
                    }
                    return null;
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
