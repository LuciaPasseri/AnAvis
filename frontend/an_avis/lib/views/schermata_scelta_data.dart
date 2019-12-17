import 'package:an_avis/views/schermata_orario.dart';
import 'package:an_avis/widgets/pulsante_giorno.dart';
import 'package:an_avis/widgets/pulsante_listview.dart';
import "package:flutter/material.dart";

class SchermataSceltaData extends StatefulWidget {
  final String meseIntero;

  SchermataSceltaData({this.meseIntero});

  @override
  _SchermataSceltaDataState createState() => _SchermataSceltaDataState();
}

class _SchermataSceltaDataState extends State<SchermataSceltaData> {
  List<PulsanteGiorno> giorniPrenotazioni = List<PulsanteGiorno>();

  void _getDatePrenotazioni(String meseIntero) {
    giorniPrenotazioni.add(PulsanteGiorno(
      text: "Martedì 14",
      function: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => SchermataOrario(giorniPrenotazioni[0].text));
      },
    ));
    giorniPrenotazioni.add(PulsanteGiorno(
      text: "Giovedì 16",
      function: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => SchermataOrario(giorniPrenotazioni[1].text));
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    _getDatePrenotazioni(widget.meseIntero);
  }

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
          "Scegli il giorno",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          ListView.builder(
            padding: EdgeInsets.all(20),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: giorniPrenotazioni.length,
            itemBuilder: (BuildContext context, int index) {
              return giorniPrenotazioni[index];
            },
          )
        ],
      ),
    );
  }
}
