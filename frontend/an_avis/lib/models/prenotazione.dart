import "package:flutter/material.dart";

class PrenotazioneProvider extends ChangeNotifier {
    String tipoDonazione;

    setTipoDonazione(String tipo) {
      tipoDonazione = tipo;
    }

}
