import "package:flutter/material.dart";

class SedeProvider extends ChangeNotifier {
    String _cittaSede;

    setCitta(String citta) {
      _cittaSede = citta;
    }

    String getCittaSede() {
      return _cittaSede;
    }

}