import 'package:an_avis/widgets/custom_text_field.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class SchermataRegistrazioneDonatore extends StatefulWidget {
  @override
  _SchermataRegistrazioneDonatoreState createState() =>
      _SchermataRegistrazioneDonatoreState();
}

class _SchermataRegistrazioneDonatoreState
    extends State<SchermataRegistrazioneDonatore> {
  final _formKey = GlobalKey<FormState>();
  String _nome;
  String _cognome;
  String _gruppoSanguigno;
  String _email;
  String _password;
  String _dropdownError;
  bool _hiddenText = true;

  bool _validateForm() {
    bool _isValid = _formKey.currentState.validate();
    if (_gruppoSanguigno == null) {
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

  void _toggleHidden() {
    setState(() {
      _hiddenText = !_hiddenText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(primaryColor: Colors.blue[900]),
                  child: CustomTextField(
                    icon: Icon(Icons.person),
                    text: "Inserire nome",
                    alignment: TextAlign.left,
                    onSaved: (value) {
                      _nome = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Inserire valore valido";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(primaryColor: Colors.blue[900]),
                  child: CustomTextField(
                    icon: Icon(Icons.person),
                    text: "Inserire cognome",
                    alignment: TextAlign.left,
                    onSaved: (value) {
                      _nome = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Inserire valore valido";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
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
                            "Selezionare gruppo sanguigno",
                            style: TextStyle(),
                          ),
                          value: _gruppoSanguigno,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              _gruppoSanguigno = value;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: "0+",
                              child: Text("0+"),
                            ),
                            DropdownMenuItem(
                              value: "0-",
                              child: Text("0-"),
                            ),
                            DropdownMenuItem(
                              value: "A+",
                              child: Text("A+"),
                            ),
                            DropdownMenuItem(
                              value: "A-",
                              child: Text("A-"),
                            ),
                            DropdownMenuItem(
                              value: "B+",
                              child: Text("B+"),
                            ),
                            DropdownMenuItem(
                              value: "B-",
                              child: Text("B-"),
                            ),
                            DropdownMenuItem(
                              value: "AB+",
                              child: Text("AB+"),
                            ),
                            DropdownMenuItem(
                              value: "AB-",
                              child: Text("AB-"),
                            )
                          ],
                        )));
                  },
                ),
              ),
              SizedBox(height: 7),
              _dropdownError == null
                  ? SizedBox(height: 15)
                  : Align(
                      alignment: Alignment(-0.74, 0),
                      child: Text(
                        _dropdownError ?? "",
                        style: TextStyle(color: Colors.red[700], fontSize: 12),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(primaryColor: Colors.blue[900]),
                  child: CustomTextField(
                    text: "Inserire email",
                    alignment: TextAlign.left,
                    icon: Icon(Icons.email),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Inserire vlaore valido";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(primaryColor: Colors.blue[900]),
                  child: CustomTextField(
                    text: "Inserire password",
                    icon: Icon(Icons.lock),
                    hiddenText: _hiddenText,
                    iconButton: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _hiddenText ? Icons.visibility : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          _toggleHidden();
                        }),
                    alignment: TextAlign.left,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Inserire vlaore valido";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 100),
                  ButtonTheme(
                    buttonColor: Colors.greenAccent[700],
                    child: RaisedButton(
                      child: Text(
                        "Conferma",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      onPressed: () {
                        if (_validateForm()) {
                          _formKey.currentState.save();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 30),
                  ButtonTheme(
                    buttonColor: Colors.red,
                    child: RaisedButton(
                      child: Text(
                        "Annulla",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
