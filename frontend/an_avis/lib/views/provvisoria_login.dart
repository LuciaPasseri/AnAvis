import 'package:an_avis/models/sede.dart';
import 'package:an_avis/widgets/pulsante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchermataLogin extends StatefulWidget {
  @override
  _SchermataLoginState createState() => _SchermataLoginState();
}

class _SchermataLoginState extends State<SchermataLogin> {
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
        title: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "AnAvis",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
          ),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Pulsante(
                  text: "Donatore",
                  function: () {
                    Navigator.pushNamed(context, "/donatore");
                  }),
              SizedBox(
                height: 25,
              ),
              Pulsante(
                  text: "Sede Avis",
                  function: () {
                    Provider.of<SedeProvider>(context).setCitta("Tolentino");
                    Navigator.pushNamed(context, "/sede");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
