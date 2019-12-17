import 'package:flutter/material.dart';

class DomandaQuestionario extends StatefulWidget {
  DomandaQuestionario(
      {@required this.value,
      @required this.question,
      @required this.hasOptionalQuestion,
      this.optionalQuestion});

  bool value;
  String question;
  bool hasOptionalQuestion;
  String optionalQuestion;
  String optionalAnswer;

  @override
  _DomandaQuestionarioState createState() => _DomandaQuestionarioState();
}

class _DomandaQuestionarioState extends State<DomandaQuestionario> {

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
                  //padding: EdgeInsets.only(left: 10),
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
