import 'package:an_avis/models/questionario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DomandaQuestionario extends StatefulWidget {
  DomandaQuestionario(
      {@required this.question,
      @required this.hasOptionalQuestion,
      this.optionalQuestion,
      this.tagValue,
      this.tagOptionalAnswer});

  bool value = false;
  String tagValue;
  String question;
  bool hasOptionalQuestion;
  String optionalQuestion;
  String tagOptionalAnswer;

  @override
  _DomandaQuestionarioState createState() => _DomandaQuestionarioState();
}

class _DomandaQuestionarioState extends State<DomandaQuestionario> {
  _setValueByTag(bool value) {
    switch (widget.tagValue) {
      case "buonaSalute":
        Provider.of<QuestionarioProvider>(context).setBuonaSalute(value);
        break;
      case "ricoveratoOspedale":
        Provider.of<QuestionarioProvider>(context).setRicoveratoOspedale(value);
        break;
      case "ultimaDonazioneSalute":
        Provider.of<QuestionarioProvider>(context)
            .setUltimaDonazioneSalute(value);
        break;
      case "perditaPeso":
        Provider.of<QuestionarioProvider>(context).setPerditaPeso(value);
        break;
      case "allergie":
        Provider.of<QuestionarioProvider>(context).setAllergie(value);
        break;
    }
  }

  _setOptionalAnswerByTag(String value) {
    switch (widget.tagOptionalAnswer) {
      case "motivoRicovero":
        Provider.of<QuestionarioProvider>(context).setMotivoRicovero(value);
        break;
      case "qualiAllergie":
        Provider.of<QuestionarioProvider>(context).setQualiAllergie(value);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _setValueByTag(false);
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
                value: widget.value,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    widget.value = value;
                    _setValueByTag(value);
                  });
                },
              ),
              Checkbox(
                value: !widget.value,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    widget.value = !value;
                  });
                },
              ),
            ],
          ),
          widget.value && widget.hasOptionalQuestion
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
