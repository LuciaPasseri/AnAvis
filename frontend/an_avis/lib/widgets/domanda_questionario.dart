import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/models/questionario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool _value = false;

  _setValueByTag(bool value) {
    switch (widget.tagValue) {
      case "buonaSalute":
        Provider.of<QuestionarioProvider>(context, listen: false).setBuonaSalute(value);
        break;
      case "ricoveratoOspedale":
        Provider.of<QuestionarioProvider>(context, listen: false).setRicoveratoOspedale(value);
        break;
      case "condizioniSaluteRecenti":
        Provider.of<QuestionarioProvider>(context, listen: false)
            .setCondizioniSaluteRecenti(value);
        break;
      case "perditaPeso":
        Provider.of<QuestionarioProvider>(context, listen: false).setPerditaPeso(value);
        break;
      case "allergie":
        Provider.of<QuestionarioProvider>(context, listen: false).setAllergie(value);
        break;
    }
  }

  _setOptionalAnswerByTag(String value) {
    switch (widget.tagOptionalAnswer) {
      case "motiviRicovero":
        Provider.of<QuestionarioProvider>(context, listen: false).setMotiviRicovero(value);
        break;
      case "qualiAllergie":
        Provider.of<QuestionarioProvider>(context, listen: false).setQualiAllergie(value);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _setValueByTag(false);
    _setOptionalAnswerByTag("");
    Provider.of<PrenotazioneProvider>(context, listen: false).setQuestionarioCompilato(null);
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
                      fontFamily: "Roboto",
                    ),
                  )),
              Spacer(),
              Checkbox(
                value: _value,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    _value = value;_setValueByTag(value);
                  });
                  
                },
              ),
              Checkbox(
                value: !_value,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    _value = !value;_setValueByTag(!value);
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
