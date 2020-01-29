import 'dart:convert';
import 'package:an_avis/services/http_service.dart';
import 'package:an_avis/widgets/remove_glow.dart';
import 'package:an_avis/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import "package:http/http.dart" as http;

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
  HttpService _httpService = HttpService();

  void _toggleHidden() {
    setState(() {
      _hiddenText = !_hiddenText;
    });
  }

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

  void addDonatore(BuildContext context) async {
    var donatore = json.encode({
      "nome": "$_nome",
      "cognome": "$_cognome",
      "gruppoSanguigno": "$_gruppoSanguigno",
      "email": "$_email",
    });
    _httpService.postCallWithSnackBar(context, "http://10.0.2.2:8080/donatori",
        donatore, "Donatore aggiunto correttamente!");
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } catch (e) {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        messageText: Text(
          e.message,
          style: TextStyle(fontFamily: "Nunito", color: Colors.white),
        ),
      ).show(context);
    }
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
            fontFamily: "Nunito",
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ScrollConfiguration(
          behavior: RemoveGlow(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 30, 32, 0),
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
                      inputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 5, 32, 0),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(primaryColor: Colors.blue[900]),
                    child: CustomTextField(
                      icon: Icon(Icons.person_outline),
                      text: "Inserire cognome",
                      alignment: TextAlign.left,
                      onSaved: (value) {
                        _cognome = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Inserire valore valido";
                        }
                        return null;
                      },
                      inputType: TextInputType.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 5, 32, 0),
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
                                  "Selezionare gruppo sanguigno",
                                  style: TextStyle(fontFamily: "Nunito"),
                                ),
                              ],
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
                                child: Text(
                                  "0+",
                                  style: TextStyle(fontFamily: "Nunito"),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "0-",
                                child: Text(
                                  "0-",
                                  style: TextStyle(fontFamily: "Nunito"),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "A+",
                                child: Text(
                                  "A+",
                                  style: TextStyle(fontFamily: "Nunito"),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "A-",
                                child: Text("A-",
                                    style: TextStyle(fontFamily: "Nunito")),
                              ),
                              DropdownMenuItem(
                                value: "B+",
                                child: Text("B+",
                                    style: TextStyle(fontFamily: "Nunito")),
                              ),
                              DropdownMenuItem(
                                value: "B-",
                                child: Text("B-",
                                    style: TextStyle(fontFamily: "Nunito")),
                              ),
                              DropdownMenuItem(
                                value: "AB+",
                                child: Text("AB+",
                                    style: TextStyle(fontFamily: "Nunito")),
                              ),
                              DropdownMenuItem(
                                value: "AB-",
                                child: Text("AB-",
                                    style: TextStyle(fontFamily: "Nunito")),
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
                          style: TextStyle(
                              fontFamily: "Nunito",
                              color: Colors.red[700],
                              fontSize: 12),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 5, 32, 0),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(primaryColor: Colors.blue[900]),
                    child: CustomTextField(
                      text: "Inserire email",
                      alignment: TextAlign.left,
                      icon: Icon(Icons.email),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Inserire valore valido";
                        }
                        if (!EmailValidator.validate(value)) {
                          return "Inserita email non valida";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                      inputType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 5, 32, 0),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(primaryColor: Colors.blue[900]),
                    child: CustomTextField(
                      text: "Inserire password",
                      icon: Icon(Icons.lock),
                      hiddenText: _hiddenText,
                      iconButton: IconButton(
                        icon: Icon(
                          _hiddenText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: _toggleHidden,
                      ),
                      alignment: TextAlign.left,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Inserire valore valido";
                        }
                        if (value.length < 6) {
                          return "Password troppo corta";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                      inputType: TextInputType.text,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
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
                addDonatore(context);
                setState(() {
                  _formKey.currentState.reset();
                  _gruppoSanguigno = null;
                });
              }
            }),
      ),
    );
  }
}
