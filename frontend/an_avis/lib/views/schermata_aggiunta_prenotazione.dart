import 'dart:convert';
import 'package:an_avis/widgets/custom_text_field.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "package:http/http.dart" as http;

class SchermataAggiuntaPrenotazione extends StatefulWidget {
  @override
  _SchermataAggiuntaPrenotazioneState createState() =>
      _SchermataAggiuntaPrenotazioneState();
}

class _SchermataAggiuntaPrenotazioneState
    extends State<SchermataAggiuntaPrenotazione> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _date;
  String _tipoDonazione;
  String _dropdownError;
  TextEditingController _controllerDate = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controllerDate.dispose();
  }

  bool _validateForm() {
    bool _isValid = _formKey.currentState.validate();
    if (_tipoDonazione == null) {
      setState(() => _dropdownError = "Inserire valore valido");
      _isValid = false;
    } else {
      setState(() {
        _dropdownError = null;
      });
    }
    if (_isValid == true) {
      _formKey.currentState.save();
    }
    return _isValid;
  }

  Future<String> addPrenotation(BuildContext context) async {
    var prenotation = json.encode({
      "data": "${DateFormat('yyyy-MM-dd').format(_date)}",
      "orario": "${_date.hour} - ${_date.minute}",
      "donatore": {},
      "sede": "Tolentino",
      "tipoDonazione": "PLASMA",
      "disponibilità": "true",
    });
    var response = await http.post(
      Uri.parse("http://10.0.2.2:8080/prenotazioni"),
      body: prenotation,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        content: Text("Prenotazione aggiunta"),
      ));
    }
  }

  Future _selectDate() async {
    final now = DateTime.now();
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day + 1),
      firstDate: DateTime(now.year, now.month, now.day + 1),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.blue[900],
            accentColor: Colors.red[900],
          ),
          child: child,
        );
      },
    );
    if (picked != null) {
      setState(() => _date = picked);
      _controllerDate.value =
          TextEditingValue(text: DateFormat('dd-MM-yyyy').format(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.red[900],
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        backgroundColor: Colors.blue[900],
        title: Text(
          "Inserisci i dati",
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(25, 30, 25, 5),
              child: InkWell(
                onTap: () {
                  _selectDate();
                },
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _controllerDate,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Inserire valore valido';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue[900],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      hintText: "Inserire una data",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.blue[900], width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 25, 25, 10),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: Colors.blue[900]),
                      child: CustomTextField(
                        text: "Ora",
                        alignment: TextAlign.center,
                        inputType: TextInputType.number,
                        validator: (String value) {
                          if (value.isEmpty ||
                              !(int.parse(value) >= 0 &&
                                  int.parse(value) <= 24)) {
                            return 'Valore non valido';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _date =
                                _date.add(Duration(hours: int.parse(value)));
                          });
                        },
                        icon: Icon(Icons.access_time),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    ":",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 25, 25, 10),
                    child: CustomTextField(
                      text: "Minuti",
                      alignment: TextAlign.center,
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty ||
                            !(int.parse(value) >= 0 &&
                                int.parse(value) <= 59)) {
                          return 'Valore non valido';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _date = _date.add(Duration(minutes: int.parse(value)));
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 8),
              child: FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                      decoration: InputDecoration(
                        enabledBorder: _dropdownError != null
                            ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              )
                            : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        hint: Text(
                          "Scegliere tipo di donazione",
                          style: TextStyle(),
                        ),
                        value: _tipoDonazione,
                        isDense: true,
                        onChanged: (value) {
                          setState(() {
                            _tipoDonazione = value;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: "Sangue",
                            child: Text("Sangue"),
                          ),
                          DropdownMenuItem(
                            value: "Plasma",
                            child: Text("Plasma"),
                          )
                        ],
                      )));
                },
              ),
            ),
            _dropdownError == null
                ? SizedBox.shrink()
                : Text(
                    _dropdownError ?? "",
                    style: TextStyle(color: Colors.red[700], fontSize: 12),
                  ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
            backgroundColor: Colors.blue[800],
            child: Icon(
              Icons.check,
              size: 32,
            ),
            onPressed: () {
              if (_validateForm()) {
                addPrenotation(context);
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
              }
            }),
      ),
    );
  }
}
