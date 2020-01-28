import 'package:an_avis/models/donatore.dart';
import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/services/http_service.dart';
import 'package:an_avis/widgets/pulsante.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SchermataSceltaTipoDonazione extends StatefulWidget {
  @override
  _SchermataSceltaTipoDonazioneState createState() =>
      _SchermataSceltaTipoDonazioneState();
}

class _SchermataSceltaTipoDonazioneState
    extends State<SchermataSceltaTipoDonazione> {
  int _giorniPerPoterPrenotare;
  HttpService _httpService = HttpService();

  Future<bool> _checkPossibilitaDonazione() async {
    var donatore = await _httpService.getCall(
        context, "http://10.0.2.2:8080/donatori/${Donatore().getId()}");
    if (donatore["tipoUltimaDonazione"] == "SANGUE") {
      _giorniPerPoterPrenotare = 90;
    } else {
      _giorniPerPoterPrenotare = 30;
    }
    List<String> tempDate = donatore["dataUltimaDonazione"].split("-");
    String formattedDate = tempDate[2] + tempDate[1] + tempDate[0];
    Duration difference =
        DateTime.now().difference(DateTime.parse(formattedDate));
    return difference.inDays < _giorniPerPoterPrenotare;
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
          "Scegli il tipo di donazione",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Nunito",
          ),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Pulsante(
                  text: "Sangue intero",
                  icon: Icons.invert_colors,
                  function: () async {
                    if (await _checkPossibilitaDonazione()) {
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
                      Prenotazione().setTipoDonazione("SANGUE");
                      Navigator.of(context).pushNamed('/sceltaSede');
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              Pulsante(
                  text: "Plasma",
                  icon: Icons.invert_colors,
                  function: () async {
                    if (await _checkPossibilitaDonazione()) {
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
                      Prenotazione().setTipoDonazione("PLASMA");
                      Navigator.of(context).pushNamed('/sceltaSede');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
