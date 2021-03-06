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
            fontFamily: "Nunito",
          ),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: GridView.count(
              padding: const EdgeInsets.all(50),
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              crossAxisCount: 3,
              children: <Widget>[
                PulsanteMese(meseTag: "GEN", meseNumero: "01"),
                PulsanteMese(meseTag: "FEB", meseNumero: "02"),
                PulsanteMese(meseTag: "MAR", meseNumero: "03"),
                PulsanteMese(meseTag: "APR", meseNumero: "04"),
                PulsanteMese(meseTag: "MAG", meseNumero: "05"),
                PulsanteMese(meseTag: "GIU", meseNumero: "06"),
                PulsanteMese(meseTag: "LUG", meseNumero: "07"),
                PulsanteMese(meseTag: "AGO", meseNumero: "08"),
                PulsanteMese(meseTag: "SET", meseNumero: "09"),
                PulsanteMese(meseTag: "OTT", meseNumero: "10"),
                PulsanteMese(meseTag: "NOV", meseNumero: "11"),
                PulsanteMese(meseTag: "DIC", meseNumero: "12"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
