import 'package:an_avis/widgets/domanda_questionario.dart';
import "package:flutter/material.dart";

class ListQuestionario extends StatefulWidget {
  @override
  _ListQuestionarioState createState() => _ListQuestionarioState();
}

class _ListQuestionarioState extends State<ListQuestionario> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DomandaQuestionario(
            tagValue: "buonaSalute",
            hasOptionalQuestion: false,
            question: "È attualmente in buona salute?"),
        DomandaQuestionario(
          tagValue: "ricoveratoOspedale",
          hasOptionalQuestion: true,
          optionalQuestion: "Perché?",
          question: "È mai stato ricoverato in\nospedale?",
          tagOptionalAnswer: "motivoRicovero",
        ),
        DomandaQuestionario(
          tagValue: "ultimaDonazioneSalute",
          hasOptionalQuestion: false,
          question:
              "Si è rivolto di recente al suo\nmedico di famiglia o ha\nintenzionedi farlo?",
        ),
        DomandaQuestionario(
          tagValue: "allergie",
          hasOptionalQuestion: true,
          optionalQuestion: "Quali?",
          question: "Ha attualmente manifestato\nallergie?",
          tagOptionalAnswer: "qualiAllergie",
        ),
        DomandaQuestionario(
          tagValue: "perditaPeso",
          hasOptionalQuestion: false,
          question: "Ha notato perdita di peso negli\nultimi tempi?",
        ),
      ],
    );
  }
}
