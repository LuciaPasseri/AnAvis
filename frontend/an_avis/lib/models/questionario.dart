import "package:flutter/material.dart";

class QuestionarioProvider extends ChangeNotifier {
  bool _buonaSalute = false;
  bool _ricoveratoOspedale = false;
  bool _condizioniSaluteRecenti = false;
  bool _allergie = false;
  bool _perditaPeso = false;
  String _motiviRicovero;
  String _qualiAllergie;

  void setBuonaSalute(bool value) {
    _buonaSalute = value;
  }

  void setRicoveratoOspedale(bool value) {
    _ricoveratoOspedale = value;
  }

  void setCondizioniSaluteRecenti(bool value) {
    _condizioniSaluteRecenti = value;
  }

  void setAllergie(bool value) {
    _allergie = value;
  }

  void setPerditaPeso(bool value) {
    _perditaPeso = value;
  }

  void setMotiviRicovero(String motivo) {
    _motiviRicovero = motivo;
  }

  void setQualiAllergie(String allergie) {
    _qualiAllergie = allergie;
  }

  bool getBuonaSalute() {
    return _buonaSalute;
  }

  bool getRicoveroOspedale() {
    return _ricoveratoOspedale;
  }

  bool getCondizioniSaluteRecenti() {
    return _condizioniSaluteRecenti;
  }

  bool getAllergie() {
    return _allergie;
  }

  bool getPerditaPeso() {
    return _perditaPeso;
  }

  String getMotiviRicovero() {
    return _motiviRicovero;
  }

  String getQualiAllergie() {
    return _qualiAllergie;
  }
}
