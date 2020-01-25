import 'package:an_avis/models/prenotazione.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class PulsanteMese extends StatelessWidget {
  const PulsanteMese({
    @required this.meseTag,
    @required this.meseNumero,
  });

  final String meseTag;
  final String meseNumero;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.blue[800], width: 2),
      ),
      child: Text(
        meseTag,
        style: TextStyle(
          fontFamily: "Nunito",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red[800],
        ),
      ),
      textColor: Colors.white,
      color: Colors.white,
      onPressed: () {
        Provider.of<PrenotazioneProvider>(context).setMese(meseNumero);
        Navigator.of(context).pushNamed("/sceltaData");
      },
    );
  }
}
