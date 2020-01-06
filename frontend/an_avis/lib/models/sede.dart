import "package:flutter/material.dart";

class SedeProvider extends ChangeNotifier {
    String cittaSede;

    setCitta(String citta) {
      cittaSede = citta;
    }

}