import 'package:an_avis/widgets/domanda_questionario.dart';
import "package:flutter/material.dart";

class ListQuestionario extends StatefulWidget {
  @override
  _ListQuestionarioState createState() => _ListQuestionarioState();
}

class _ListQuestionarioState extends State<ListQuestionario> {
  bool buonaSalute = false;
  bool ultimaDonazioneSalute = false;
  bool allergie = false;
  bool perditaPeso = false;
  bool ricoveratoOspedale = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        Column(
          children: <Widget>[
            DomandaQuestionario(
                value: buonaSalute,
                hasOptionalQuestion: false,
                question: "È attualmente in buona salute?"),
            DomandaQuestionario(
                value: ricoveratoOspedale,
                hasOptionalQuestion: true,
                optionalQuestion: "Perché?",
                question: "È mai stato ricoverato in\nospedale?"),
            DomandaQuestionario(
              value: ultimaDonazioneSalute,
              hasOptionalQuestion: false,
              question:
                  "Si è rivolto di recente al suo\nmedico di famiglia o ha\nintenzionedi farlo?",
            ),
            DomandaQuestionario(
              value: allergie,
              hasOptionalQuestion: true,
              question: "Ha attualmente manifestato\nallergie?",
            ),
            DomandaQuestionario(
              value: perditaPeso,
              hasOptionalQuestion: false,
              question: "Ha notato perdita di peso negli\nultimi tempi?",
            ),
          ],
        ),
      ],
    );
  }
}
