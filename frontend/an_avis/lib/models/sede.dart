import "package:flutter/material.dart";

class SedeProvider extends ChangeNotifier {
  String _idSede;
  String _cittaSede;
  String _email;

  void setId(String id) {
    _idSede = id;
  }

  void setCitta(String citta) {
    _cittaSede = citta;
  }

  void setEmail(String email) {
    _email = email;
  }

  String getId() {
    return _idSede;
  }

  String getCittaSede() {
    return _cittaSede;
  }

  String getEmail() {
    return _email;
  }

}
