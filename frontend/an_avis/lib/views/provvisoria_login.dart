import 'package:an_avis/models/donatore.dart';
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
                    Provider.of<DonatoreProvider>(context)
                        .setId("09da317e-11ec-414d-a0ee-f2a3fcd92a6a");
                    print(Provider.of<DonatoreProvider>(context).getId());
                    Provider.of<DonatoreProvider>(context).setNome("Matteo");
                    Provider.of<DonatoreProvider>(context)
                        .setCognome("Bianchi");
                    Provider.of<DonatoreProvider>(context)
                        .setGruppoSanguigno("A+");
                    Provider.of<DonatoreProvider>(context)
                        .setEmail("matteo.bianchi@gmail.com");
                    Provider.of<DonatoreProvider>(context)
                        .setPassword("abcd123");
                    Navigator.pushNamed(context, "/donatore");
                  }),
              SizedBox(
                height: 25,
              ),
              Pulsante(
                  text: "Sede Avis",
                  function: () {
                    Provider.of<DonatoreProvider>(context)
                        .setId("09da317e-11ec-414d-a0ee-f2a3fcd92a6a");
                    print(Provider.of<DonatoreProvider>(context).getId());
                    Provider.of<DonatoreProvider>(context).setNome("Matteo");
                    Provider.of<DonatoreProvider>(context)
                        .setCognome("Bianchi");
                    Provider.of<DonatoreProvider>(context)
                        .setGruppoSanguigno("A+");
                    Provider.of<DonatoreProvider>(context)
                        .setEmail("matteo.bianchi@gmail.com");
                    Provider.of<DonatoreProvider>(context)
                        .setPassword("abcd123");
                    Provider.of<SedeProvider>(context)
                        .setId("330c20eb-b8be-489b-a8f8-967385aa675e");
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
