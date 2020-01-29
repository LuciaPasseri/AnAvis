import 'dart:convert';
import 'package:an_avis/models/sede.dart';
import 'package:an_avis/services/http_service.dart';
import 'package:an_avis/widgets/custom_text_field.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class SchermataAggiuntaPrenotazione extends StatefulWidget {
  @override
  _SchermataAggiuntaPrenotazioneState createState() =>
      _SchermataAggiuntaPrenotazioneState();
}

class _SchermataAggiuntaPrenotazioneState
    extends State<SchermataAggiuntaPrenotazione> {
  final _formKey = GlobalKey<FormState>();
  Sede _sede = Sede();
  DateTime _data;
  String _tipoDonazione;
  String _dropdownError;
  TextEditingController _controllerDate = TextEditingController();
  HttpService _httpService = HttpService();

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

  String _getOra(int ora) {
    if (ora.toString().length == 1) {
      return "0" + ora.toString();
    } else
      return ora.toString();
  }

  String _getMinuti(int minuti) {
    if (minuti.toString().length == 1) {
      return "0" + minuti.toString();
    } else
      return minuti.toString();
  }

  void addPrenotazione(BuildContext context) async {
    var prenotazione = json.encode({
      "data": "${DateFormat('dd-MM-yyyy').format(_data)}",
      "orario": _getOra(_data.hour) + " : " + _getMinuti(_data.minute),
      "idSede": _sede.getId(),
      "tipoDonazione": "${_tipoDonazione.toUpperCase()}",
      "disponibilita": true,
    });
    _httpService.postCallWithSnackBar(context, "http://10.0.2.2:8080/prenotazioni",
        prenotazione, "Prenotazione aggiunta!");
  }

  Future _selezionaData() async {
    final now = DateTime.now();
    DateTime data = await showDatePicker(
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
    if (data != null) {
      setState(() => _data = data);
      _controllerDate.value =
          TextEditingValue(text: DateFormat('dd-MM-yyyy').format(data));
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
          "Inserisci i dati",
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Nunito",
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(32, 40, 32, 5),
              child: InkWell(
                onTap: () {
                  _selezionaData();
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
                      hintStyle: TextStyle(fontFamily: "Nunito"),
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
                    padding: EdgeInsets.fromLTRB(32, 25, 30, 10),
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
                            _data =
                                _data.add(Duration(hours: int.parse(value)));
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
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 25, 32, 10),
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
                        _data = _data.add(Duration(minutes: int.parse(value)));
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 8),
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
                        hint: Row(
                          children: <Widget>[
                            Icon(
                              Icons.invert_colors,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Scegliere tipo di donazione",
                              style: TextStyle(fontFamily: "Nunito"),
                            ),
                          ],
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
                            child: Text(
                              "Sangue intero",
                              style: TextStyle(fontFamily: "Nunito"),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Plasma",
                            child: Text(
                              "Plasma",
                              style: TextStyle(fontFamily: "Nunito"),
                            ),
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
        height: 65,
        width: 65,
        child: FloatingActionButton(
            backgroundColor: Colors.blue[900],
            child: Icon(
              Icons.check,
              size: 30,
            ),
            onPressed: () {
              if (_validateForm()) {
                addPrenotazione(context);
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context);
                });
              }
            }),
      ),
    );
  }
}
