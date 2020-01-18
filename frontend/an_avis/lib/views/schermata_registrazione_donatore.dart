import 'dart:convert';
import 'package:an_avis/widgets/custom_text_field.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class SchermataRegistrazioneDonatore extends StatefulWidget {
  @override
  _SchermataRegistrazioneDonatoreState createState() =>
      _SchermataRegistrazioneDonatoreState();
}

class _SchermataRegistrazioneDonatoreState
    extends State<SchermataRegistrazioneDonatore> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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

  void addDonator(BuildContext context) async {
    var donator = json.encode({
        "nome": "$_nome",
        "cognome": "$_cognome",
        "gruppoSanguigno": "$_gruppoSanguigno",
        "email": "$_email",
        "password": "$_password"
    });
    var response = await http.post(
      Uri.parse("http://10.0.2.2:8080/donatori"),
      body: donator,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        content: Text("Donatore aggiunto!"),
      ));
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        content: Text("Errore"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                padding: EdgeInsets.fromLTRB(35, 30, 35, 0),
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
                padding: EdgeInsets.fromLTRB(35, 5, 35, 0),
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
                padding: EdgeInsets.fromLTRB(35, 5, 35, 0),
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
                padding: EdgeInsets.fromLTRB(35, 5, 35, 0),
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
                padding: EdgeInsets.fromLTRB(35, 5, 35, 0),
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
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          _toggleHidden();
                        }),
                    alignment: TextAlign.left,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Inserire valore valido";
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
            ],
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
                addDonator(context);
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
              }
            }),
      ),
    );
  }
}
