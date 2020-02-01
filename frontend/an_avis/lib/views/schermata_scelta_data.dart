import 'dart:convert';
import 'package:an_avis/models/donatore.dart';
import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/models/questionario.dart';
import 'package:an_avis/services/http_service.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import 'package:an_avis/widgets/pulsante_giorno.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:flushbar/flushbar.dart';

class SchermataSceltaData extends StatefulWidget {
  @override
  _SchermataSceltaDataState createState() => _SchermataSceltaDataState();
}

class _SchermataSceltaDataState extends State<SchermataSceltaData> {
  Prenotazione _prenotazione = Prenotazione();
  Donatore _donatore = Donatore();
  Questionario _questionario = Questionario();
  String _oraSelezionata;
  bool _isEmpty = true;
  HttpService _httpService = HttpService();

  String _getGiorno(String data) {
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
    var prenotazioni = await _httpService.getCall(context,
        "http://10.0.2.2:8080/prenotazioni/sede/${_prenotazione.getIdSede()}/disponibili");
    List<PulsanteGiorno> giorniPrenotazioni = [];
    for (var prenotazione in prenotazioni) {
      if (prenotazione["tipoDonazione"] == _prenotazione.getTipoDonazione() &&
          _checkGiornoDoppio(
              giorniPrenotazioni, _getGiorno(prenotazione["data"])) &&
          _getAnno(prenotazione["data"]) == DateTime.now().year &&
          _getMese(prenotazione["data"]) == _prenotazione.getMese()) {
        _isEmpty = false;
        giorniPrenotazioni.add(PulsanteGiorno(
          text: _getGiorno(prenotazione["data"]) +
              " " +
              _prenotazione.getMeseCompleto(),
          function: () {
            _prenotazione.setGiorno(((_getGiorno(prenotazione["data"]))));
            _prenotazione.setData();
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
                              fontFamily: "Nunito",
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
                                              fontFamily: "Nunito",
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
                                  fontFamily: "Nunito",
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                  ),
                                  onPressed: () {
                                    if (_oraSelezionata != null &&
                                        _prenotazione
                                                .getQuestionarioCompilato() !=
                                            null) {
                                      _prenotazione
                                          .setQuestionarioCompilato(null);
                                      _setPrenotazione(prenotazione["id"]);
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.popUntil(
                                            context, (route) => route.isFirst);
                                      });
                                    } else if (_prenotazione
                                            .getQuestionarioCompilato() ==
                                        null) {
                                      Flushbar(
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red,
                                        messageText: Text(
                                            "Compilare prima il questionario!",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                color: Colors.white)),
                                      ).show(context);
                                    } else {
                                      Flushbar(
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red,
                                        messageText: Text("Inserire un orario!",
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                color: Colors.white)),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                  ),
                                  onPressed: () {
                                    _prenotazione
                                        .setQuestionarioCompilato(null);
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        "/donatore", (route) => route.isFirst);
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
  }

  Future<List<DropdownMenuItem<String>>> _getOrari() async {
    var prenotazioni = await _httpService.getCall(context,
        "http://10.0.2.2:8080/prenotazioni/sede/${_prenotazione.getIdSede()}/disponibili");
    List<DropdownMenuItem<String>> orari = [];
    for (var prenotazione in prenotazioni) {
      if (_checkOrarioDoppio(orari, prenotazione["orario"]) &&
          prenotazione["tipoDonazione"] == _prenotazione.getTipoDonazione() &&
          prenotazione["data"] == _prenotazione.getData()) {
        orari.add(DropdownMenuItem(
          child: Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                prenotazione["orario"],
                style: TextStyle(fontFamily: "Nunito"),
              )),
          value: prenotazione["orario"],
        ));
      }
    }
    return orari;
  }

  void _setPrenotazione(String idPrenotazione) async {
    var questionario = json.encode({
      "buonaSalute": _questionario.getBuonaSalute(),
      "ricoveratoOspedale": _questionario.getRicoveroOspedale(),
      "allergie": _questionario.getAllergie(),
      "condizioniSaluteRecenti": _questionario.getCondizioniSaluteRecenti(),
      "perditaPeso": _questionario.getPerditaPeso(),
      "motiviRicovero": _questionario.getMotiviRicovero(),
      "qualiAllergie": _questionario.getQualiAllergie(),
    });
    var responsePostQuestionario = await _httpService.postCall(
        context, "http://10.0.2.2:8080/questionari", questionario);
    var questionari =
        await _httpService.getCall(context, "http://10.0.2.2:8080/questionari");
    String idQuestionario = questionari.last["id"];
    var prenotazione = json.encode({
      "data": "${_prenotazione.getData()}",
      "orario": _oraSelezionata,
      "idDonatore": "${_donatore.getId()}",
      "idSede": "${_prenotazione.getIdSede()}",
      "tipoDonazione": "${_prenotazione.getTipoDonazione()}",
      "disponibilita": false,
      "idQuestionario": "$idQuestionario",
    });
    var donatore = json.encode({
      "email": "${_donatore.getEmail()}",
      "nome": "${_donatore.getNome()}",
      "cognome": "${_donatore.getCognome()}",
      "gruppoSanguigno": "${_donatore.getGruppoSanguigno()}",
      "dataUltimaDonazione": "${_prenotazione.getData()}",
      "tipoUltimaDonazione": "${_prenotazione.getTipoDonazione()}",
    });
    var responsePutPrenotazione = await _httpService.putCall(context,
        "http://10.0.2.2:8080/prenotazioni/$idPrenotazione", prenotazione);
    var responsePutDonatore = await _httpService.putCall(context,
        "http://10.0.2.2:8080/donatori/${_donatore.getId()}", donatore);
    if (responsePutPrenotazione.statusCode == 200 &&
        responsePutDonatore.statusCode == 200 &&
        responsePostQuestionario.statusCode == 200) {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        messageText: Text("Prenotazione confermata!",
            style: TextStyle(fontFamily: "Nunito", color: Colors.white)),
      ).show(context);
    } else {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        messageText: Text("Errore",
            style: TextStyle(fontFamily: "Nunito", color: Colors.white)),
      ).show(context);
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
          "Scegli il giorno",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Nunito",
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
                                      "Nessuna prenotazione disponibile",
                                      style: TextStyle(fontFamily: "Nunito"),
                                    ))),
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
                  }),
            ),
          ),
        ],
      ),
    );
  }
}