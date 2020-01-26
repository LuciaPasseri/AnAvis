import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/models/questionario.dart';
import 'package:flutter/material.dart';

class DomandaQuestionario extends StatefulWidget {
  DomandaQuestionario(
      {@required this.question,
      @required this.hasOptionalQuestion,
      final this.optionalQuestion,
      final this.tagValue,
      final this.tagOptionalAnswer});

  final String tagValue;
  final String question;
  final bool hasOptionalQuestion;
  final String optionalQuestion;
  final String tagOptionalAnswer;

  @override
  _DomandaQuestionarioState createState() => _DomandaQuestionarioState();
}

class _DomandaQuestionarioState extends State<DomandaQuestionario> {
  Prenotazione _prenotazione = Prenotazione();
  Questionario _questionario = Questionario();
  bool _value = false;

  _setValueByTag(bool value) {
    switch (widget.tagValue) {
      case "buonaSalute":
        _questionario.setBuonaSalute(value);
        break;
      case "ricoveratoOspedale":
        _questionario.setRicoveratoOspedale(value);
        break;
      case "condizioniSaluteRecenti":
        _questionario.setCondizioniSaluteRecenti(value);
        break;
      case "perditaPeso":
        _questionario.setPerditaPeso(value);
        break;
      case "allergie":
        _questionario.setAllergie(value);
        break;
    }
  }

  _setOptionalAnswerByTag(String value) {
    switch (widget.tagOptionalAnswer) {
      case "motiviRicovero":
        _questionario.setMotiviRicovero(value);
        break;
      case "qualiAllergie":
        _questionario.setQualiAllergie(value);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _setValueByTag(false);
    _setOptionalAnswerByTag("");
    _prenotazione
        .setQuestionarioCompilato(null);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                  child: Text(
                    widget.question,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Nunito",
                    ),
                  )),
              Spacer(),
              Checkbox(
                value: _value,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    _value = value;
                    _setValueByTag(value);
                  });
                },
              ),
              Checkbox(
                value: !_value,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    _value = !value;
                    _setValueByTag(!value);
                  });
                },
              ),
            ],
          ),
          _value && widget.hasOptionalQuestion
              ? Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: TextFormField(
                    onChanged: (value) {
                      _setOptionalAnswerByTag(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Per favore rispondere alla domanda';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue[900],
                    decoration: InputDecoration(
                      hintText: widget.optionalQuestion,
                      hintStyle: TextStyle(fontFamily: "Nunito"),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[900]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[900]),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
