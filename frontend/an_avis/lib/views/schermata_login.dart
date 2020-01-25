import 'dart:convert';
import 'package:an_avis/models/donatore.dart';
import 'package:an_avis/models/sede.dart';
import 'package:an_avis/widgets/remove_glow.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import 'package:flushbar/flushbar.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class SchermataLogin extends StatefulWidget {
  SchermataLogin({@required this.isDonatore});

  final bool isDonatore;

  @override
  _SchermataLoginState createState() => _SchermataLoginState();
}

class _SchermataLoginState extends State<SchermataLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _hiddenText = true;
  bool _isLoading = false;
  String _errorLogin;
  String _email;
  String _password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _donatore;
  var _sede;

  void _toggleHidden() {
    setState(() {
      _hiddenText = !_hiddenText;
    });
  }

  Future<bool> _isRuoloGiusto() async {
    var responseGetDonatori = await http.get("http://10.0.2.2:8080/donatori");
    var responseGetSedi = await http.get("http://10.0.2.2:8080/sedi");
    var dataDonatori = jsonDecode(responseGetDonatori.body);
    var dataSedi = jsonDecode(responseGetSedi.body);
    for (var donatore in dataDonatori) {
      if (widget.isDonatore && donatore["email"] == _email) {
        _donatore = donatore;
        return true;
      }
    }
    for (var sede in dataSedi) {
      if (!(widget.isDonatore) && sede["email"] == _email) {
        _sede = sede;
        return true;
      }
    }
    return false;
  }

  Future _login() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {
        _isLoading = true;
      });
      bool isRuoloGiusto = await _isRuoloGiusto();
      if (!isRuoloGiusto) {
        setState(() {
          _isLoading = false;
        });
        Flushbar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          messageText: Text(
            "Email inserita non valida",
            style: TextStyle(fontFamily: "Nunito", color: Colors.white),
          ),
        ).show(context);
        return;
      }
      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        if (widget.isDonatore) {
          Provider.of<DonatoreProvider>(context).setId(_donatore["id"]);
          Provider.of<DonatoreProvider>(context).setNome(_donatore["nome"]);
          Provider.of<DonatoreProvider>(context)
              .setCognome(_donatore["cognome"]);
          Provider.of<DonatoreProvider>(context)
              .setGruppoSanguigno(_donatore["gruppoSanguigno"]);
          Provider.of<DonatoreProvider>(context).setEmail(_email);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/donatore', (Route<dynamic> route) => false);
        } else {
          Provider.of<SedeProvider>(context).setId(_sede["id"]);
          Provider.of<SedeProvider>(context).setCitta(_sede["citta"]);
          Provider.of<SedeProvider>(context).setEmail(_sede["email"]);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/sede', (Route<dynamic> route) => false);
        }
      } catch (e) {
        setState(() {
          if (e.message ==
              "The password is invalid or the user does not have a password.")
            _errorLogin = "Password inserita non valida";
          _isLoading = false;
        });
        Flushbar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          messageText: Text(
            _errorLogin,
            style: TextStyle(fontFamily: "Nunito", color: Colors.white),
          ),
        ).show(context);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: ScrollConfiguration(
        behavior: RemoveGlow(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(80, 120, 80, 40),
                  child: Image.asset("assets/images/logo_avis_bianco.png")),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: Colors.white,
                elevation: 6,
                margin: EdgeInsets.all(38),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: Colors.blue[900]),
                          child: GestureDetector(
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            child: TextFormField(
                              style: TextStyle(height: 1, fontFamily: "Nunito"),
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.blue[900],
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue[900], width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.mail,
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(fontFamily: "Nunito"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Inserire email";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _email = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: Colors.blue[900]),
                          child: TextFormField(
                            obscureText: _hiddenText,
                            style: TextStyle(height: 1, fontFamily: "Nunito"),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.blue[900],
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue[900], width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_hiddenText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: _toggleHidden,
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(fontFamily: "Nunito"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Inserire password";
                              }
                              if (value.length < 6) {
                                return "Password troppo corta";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        !_isLoading
                            ? RaisedButton(
                                elevation: 4,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                color: Colors.blue[900],
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: "Nunito"),
                                  ),
                                ),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  _login();
                                })
                            : Padding(
                                padding: EdgeInsets.all(6),
                                child: RequestCircularLoading()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
