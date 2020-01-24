import 'package:an_avis/views/remove_glow.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class SchermataLogin extends StatefulWidget {
  @override
  _SchermataLoginState createState() => _SchermataLoginState();
}

class _SchermataLoginState extends State<SchermataLogin> {
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _hiddenText = true;
  String _email;
  String _password;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void _toggleHidden() {
    setState(() {
      _hiddenText = !_hiddenText;
    });
  }

  Future signIn() async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {}
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
                margin: EdgeInsets.all(35),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: Colors.blue[900]),
                          child: TextFormField(
                            style: TextStyle(height: 1),
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
                                Icons.person,
                              ),
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
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
                            style: TextStyle(height: 1),
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
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: _toggleHidden,
                              ),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                            validator: (val) =>
                                val.length < 6 ? 'Password too short.' : null,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        RaisedButton(
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
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          onPressed: () {},
                        ),
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
