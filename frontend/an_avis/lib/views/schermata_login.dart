import 'package:an_avis/models/donatore.dart';
import 'package:an_avis/models/sede.dart';
import 'package:an_avis/services/http_service.dart';
import 'package:an_avis/widgets/remove_glow.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import 'package:flushbar/flushbar.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

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
  String _email;
  String _password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Donatore _donatoreSingleton = Donatore();
  Sede _sedeSingleton = Sede();
  var _donatore;
  var _sede;
  HttpService _httpService = HttpService();

  void _toggleHidden() {
    setState(() {
      _hiddenText = !_hiddenText;
    });
  }

  Future<bool> _isRuoloGiusto() async {
    if (widget.isDonatore) {
      var donatori =
          await _httpService.getCall(context, "http://10.0.2.2:8080/donatori/");
      for (var donatore in donatori) {
        if (donatore["email"] == _email) {
          _donatore = donatore;
          return true;
        }
      }
    } else {
      var sedi =
          await _httpService.getCall(context, "http://10.0.2.2:8080/sedi");
      for (var sede in sedi) {
        if (sede["email"] == _email) {
          _sede = sede;
          return true;
        }
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
          _donatoreSingleton.setId(_donatore["id"]);
          _donatoreSingleton.setNome(_donatore["nome"]);
          _donatoreSingleton.setCognome(_donatore["cognome"]);
          _donatoreSingleton.setGruppoSanguigno(_donatore["gruppoSanguigno"]);
          _donatoreSingleton.setEmail(_email);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/donatore', (Route<dynamic> route) => false);
        } else {
          _sedeSingleton.setId(_sede["id"]);
          _sedeSingleton.setCitta(_sede["citta"]);
          _sedeSingleton.setEmail(_sede["email"]);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/sede', (Route<dynamic> route) => false);
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        Flushbar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          messageText: Text(
            "Password errata",
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
                                _email = value.toLowerCase();
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
