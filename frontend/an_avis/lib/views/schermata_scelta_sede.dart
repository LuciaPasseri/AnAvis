import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import 'package:an_avis/widgets/pulsante_sede.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import 'package:provider/provider.dart';

class SchermataSceltaSede extends StatefulWidget {
  @override
  _SchermataSceltaSedeState createState() => _SchermataSceltaSedeState();
}

class _SchermataSceltaSedeState extends State<SchermataSceltaSede> {
  TextEditingController _controller = new TextEditingController();
  String _filtro;

  Future<List<PulsanteSede>> _getSediAvis() async {
    http.Response response = await http.get("http://10.0.2.2:8080/sedi");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<PulsanteSede> sediAvis = [];
      for (var d in data) {
        sediAvis.add(PulsanteSede(
            text: d["citta"],
            function: () {
              Provider.of<PrenotazioneProvider>(context).setIdSede(d["id"]);
              Navigator.pushNamed(context, "/sceltaMese");
            }));
      }
      sediAvis.sort((a, b) => a.text.compareTo(b.text));
      return sediAvis;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  @override
  initState() {
    super.initState();
    _getSediAvis();
    _controller.addListener(() {
      setState(() {
        _filtro = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<PrenotazioneProvider>(context).getTipoDonazione());
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
          "Scegli la sede in cui donare",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Nunito",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(22),
            child: Theme(
              data: Theme.of(context).copyWith(primaryColor: Colors.blue[800]),
              child: Container(
                height: 42,
                width: 350,
                child: TextField(
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Nunito",
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Cerca sede",
                      hintStyle: TextStyle(fontFamily: "Nunito"),
                      fillColor: Colors.red,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue[800], width: 2.0),
                          borderRadius: BorderRadius.circular(25.0))),
                  controller: _controller,
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: _getSediAvis(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return new RequestCircularLoading();
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return new RequestCircularLoading();
                  case ConnectionState.done:
                    if (snapshot.hasError) return new RequestCircularLoading();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _filtro == null || _filtro == ""
                            ? snapshot.data[index]
                            : snapshot.data[index].text
                                    .toLowerCase()
                                    .contains(_filtro.toLowerCase())
                                ? snapshot.data[index]
                                : Container();
                      },
                    );
                }
                return null;
              }),
        ],
      ),
    );
  }
}
