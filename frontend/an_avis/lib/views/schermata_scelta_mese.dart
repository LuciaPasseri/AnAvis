import 'package:an_avis/widgets/pulsante_mese.dart';
import 'package:flutter/material.dart';

class SchermataSceltaMese extends StatefulWidget {
  @override
  _SchermataSceltaMeseState createState() => _SchermataSceltaMeseState();
}

class _SchermataSceltaMeseState extends State<SchermataSceltaMese> {
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
          "Scegli il mese",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: GridView.count(
              padding: const EdgeInsets.all(40),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 3,
              children: <Widget>[
                PulsanteMese(meseTag: "GEN", meseIntero: "Gennaio"),
                PulsanteMese(meseTag: "FEB", meseIntero: "Febbraio"),
                PulsanteMese(meseTag: "MAR", meseIntero: "Marzo"),
                PulsanteMese(meseTag: "APR", meseIntero: "Aprile"),
                PulsanteMese(meseTag: "MAG", meseIntero: "Maggio"),
                PulsanteMese(meseTag: "GIU", meseIntero: "Giugno"),
                PulsanteMese(meseTag: "LUG", meseIntero: "Luglio"),
                PulsanteMese(meseTag: "AGO", meseIntero: "Agosto"),
                PulsanteMese(meseTag: "SET", meseIntero: "Settembre"),
                PulsanteMese(meseTag: "OTT", meseIntero: "Ottobre"),
                PulsanteMese(meseTag: "NOV", meseIntero: "Novembre"),
                PulsanteMese(meseTag: "DIC", meseIntero: "Dicembre"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
