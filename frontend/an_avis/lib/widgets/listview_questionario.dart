import 'package:an_avis/widgets/domanda_questionario.dart';
import "package:flutter/material.dart";

class ListQuestionario extends StatefulWidget {
  @override
  _ListQuestionarioState createState() => _ListQuestionarioState();
}

class _ListQuestionarioState extends State<ListQuestionario> {
  bool isSss = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Hai bevuto ultimamente?",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Roboto",
                    ),
                  )),
              Spacer(),
              Checkbox(
                value: isSss,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    isSss = value;
                  });
                },
              ),
              Checkbox(
                value: !isSss,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    isSss = !value;
                  });
                },
              ),
            ],
          ),
        ), Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Hai bevuto ultimamente?",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Roboto",
                    ),
                  )),
              Spacer(),
              Checkbox(
                value: isSss,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    isSss = value;
                  });
                },
              ),
              Checkbox(
                value: !isSss,
                activeColor: Colors.blue[900],
                onChanged: (value) {
                  setState(() {
                    isSss = !value;
                  });
                },
              ),
            ],
          ),
        ), DomandaQuestionario(value: isSss, optionalQuestion: true, question: "Hai il sangue infetto?",),
      ],
    );
  }
}
