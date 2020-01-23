import "package:flutter/material.dart";

class SedeProvider extends ChangeNotifier {
  String _idSede;
  String _cittaSede;

  void setId(String id) {
    _idSede = id;
  }

  void setCitta(String citta) {
    _cittaSede = citta;
  }

  String getId() {
    return _idSede;
  }

  String getCittaSede() {
    return _cittaSede;
  }
}
