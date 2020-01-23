import 'dart:convert';
import 'package:an_avis/models/donatore.dart';
import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/models/questionario.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import 'package:an_avis/widgets/pulsante_giorno.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:uuid/uuid.dart';

class SchermataSceltaData extends StatefulWidget {
  @override
  _SchermataSceltaDataState createState() => _SchermataSceltaDataState();
}

class _SchermataSceltaDataState extends State<SchermataSceltaData> {
  String _oraSelezionata;
  bool _isEmpty = true;

  void _setPrenotazione() async {
    String idPrenotazione;
    String idQuestionario = Uuid().v4();
    var responseGet = await http.get("http://10.0.2.2:8080/prenotazioni");
    if (responseGet.statusCode == 200) {
      var data = jsonDecode(responseGet.body);
      for (var prenotazione in data) {
        if (prenotazione["idSede"] ==
                Provider.of<PrenotazioneProvider>(context).getIdSede() &&
            prenotazione["data"] ==
                Provider.of<PrenotazioneProvider>(context).getData() &&
            prenotazione["orario"] == _oraSelezionata) {
          idPrenotazione = prenotazione["id"];
        }
      }
    }
    var prenotazione = json.encode({
      "data": "${Provider.of<PrenotazioneProvider>(context).getData()}",
      "orario": _oraSelezionata,
      "idDonatore": "${Provider.of<DonatoreProvider>(context).getId()}",
      "idSede": "${Provider.of<PrenotazioneProvider>(context).getIdSede()}",
      "tipoDonazione":
          "${Provider.of<PrenotazioneProvider>(context).getTipoDonazione()}",
      "disponibilita": false,
      "idQuestionario": "$idQuestionario",
      "id": "$idPrenotazione"
    });
    var responsePut = await http.put(
      Uri.parse("http://10.0.2.2:8080/prenotazioni/$idPrenotazione"),
      body: prenotazione,
      headers: {
        "content-type": "application/json; charset=utf-8",
        "accept": "application/json; charset=utf-8",
      },
    );
    var questionario = json.encode({
      "buonaSalute":
          Provider.of<QuestionarioProvider>(context).getBuonaSalute(),
      "ricoveratoOspedale":
          Provider.of<QuestionarioProvider>(context).getRicoveroOspedale(),
      "allergie": Provider.of<QuestionarioProvider>(context).getAllergie(),
      "condizioniSaluteRecenti":
          Provider.of<QuestionarioProvider>(context).getCondizioniSaluteRecenti(),
      "perditaPeso":
          Provider.of<QuestionarioProvider>(context).getPerditaPeso(),
      "motiviRicovero":
          Provider.of<QuestionarioProvider>(context).getMotiviRicovero(),
      "qualiAllergie":
          Provider.of<QuestionarioProvider>(context).getQualiAllergie(),
    });
    var responsePost = await http.post(
      Uri.parse("http://10.0.2.2:8080/questionari"),
      body: questionario,
      headers: {
        "content-type": "application/json; charset=utf-8",
        "accept": "application/json; charset=utf-8",
      },
    );
    if (responsePut.statusCode == 200 && responsePost.statusCode == 200) {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        message: "Prenotazione confermata!",
      ).show(context);
    } else {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        message: "Errore",
      ).show(context);
    }
  }

  String _getData(String data) {
    List<String> temp = data.split("-");
    return temp[0];
  }

  String _getMese(String data) {
    List<String> temp = data.split("-");
    return temp[1];
  }

  int _getAnno(String data) {
    List<String> temp = data.split("-");
    return int.parse(temp[2]);
  }

  bool _checkGiornoDoppio(List<PulsanteGiorno> list, String giorno) {
    for (var pulsante in list) {
      if (pulsante.text.substring(0, 2) == giorno) return false;
    }
    return true;
  }

  bool _checkOrarioDoppio(List<DropdownMenuItem<String>> list, String ora) {
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
      for (var prenotazione in data) {
        if (prenotazione["disponibilita"] &&
            prenotazione["tipoDonazione"] ==
                Provider.of<PrenotazioneProvider>(context).getTipoDonazione() &&
            _checkGiornoDoppio(
                giorniPrenotazioni, _getData(prenotazione["data"])) &&
            prenotazione["idSede"] ==
                Provider.of<PrenotazioneProvider>(context).getIdSede() &&
            _getAnno(prenotazione["data"]) == DateTime.now().year &&
            _getMese(prenotazione["data"]) ==
                Provider.of<PrenotazioneProvider>(context).getMese()) {
          _isEmpty = false;
          giorniPrenotazioni.add(PulsanteGiorno(
            text: _getData(prenotazione["data"]) +
                " " +
                Provider.of<PrenotazioneProvider>(context).getMeseCompleto(),
            function: () {
              Provider.of<PrenotazioneProvider>(context)
                  .setGiorno(((_getData(prenotazione["data"]))));
              Provider.of<PrenotazioneProvider>(context).setData();
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
                            Text(
                              "Scegli l'orario",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(100, 25, 100, 35),
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
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            border: Border.all(
                                                color: Colors.blue[900],
                                                style: BorderStyle.solid,
                                                width: 2),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
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
                                            ),
                                          ),
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
                              height: 50,
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
                                        _setPrenotazione();
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
      giorniPrenotazioni.sort((a, b) => a.getDay().compareTo(b.getDay()));
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
            _checkOrarioDoppio(orari, d["orario"]) &&
            d["tipoDonazione"] ==
                Provider.of<PrenotazioneProvider>(context).getTipoDonazione() &&
            d["idSede"] ==
                Provider.of<PrenotazioneProvider>(context).getIdSede() &&
            d["data"] == Provider.of<PrenotazioneProvider>(context).getData()) {
          orari.add(DropdownMenuItem(
            child:
                Padding(padding: EdgeInsets.all(0), child: Text(d["orario"])),
            value: d["orario"],
          ));
        }
      }
      orari.sort((a, b) {
        List<String> oraEMinutiA = a.value.split(" : ");
        List<String> oraEMinutiB = b.value.split(" : ");
        int oraA = int.parse(oraEMinutiA[0]);
        int minutiA = int.parse(oraEMinutiA[1]);
        int oraB = int.parse(oraEMinutiB[0]);
        int minutiB = int.parse(oraEMinutiB[1]);
        if ((oraA == oraB && minutiA > minutiB) || oraA > oraB) {
          return 1;
        } else
          return -1;
      });
      return orari;
    } else {
      print(response.statusCode);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print("BuonaSal " + Provider.of<QuestionarioProvider>(context).getBuonaSalute().toString());
    print("Ricovero " + Provider.of<QuestionarioProvider>(context).getRicoveroOspedale().toString());
    print("Allergie " + Provider.of<QuestionarioProvider>(context).getAllergie().toString());
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
