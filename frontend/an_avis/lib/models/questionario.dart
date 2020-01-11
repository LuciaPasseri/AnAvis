import "package:flutter/material.dart";

class QuestionarioProvider extends ChangeNotifier {
  bool _buonaSalute;
  bool _ricoveratoOspedale = false;
  bool _ultimaDonazioneSalute = false;
  bool _allergie = false;
  bool _perditaPeso = false;
  String _motivoRicovero;
  String _qualiAllergie;

  setBuonaSalute(bool value) {
    _buonaSalute = value;
  }

  setRicoveratoOspedale(bool value) {
    _ricoveratoOspedale = value;
  }

  setUltimaDonazioneSalute(bool value) {
    _ultimaDonazioneSalute = value;
  }

  setAllergie(bool value) {
    _allergie = value;
  }

  setPerditaPeso(bool value) {
    _perditaPeso = value;
  }

  setMotivoRicovero(String motivo) {
    _motivoRicovero = motivo;
  }

  setQualiAllergie(String allergie) {
    _qualiAllergie = allergie;
  }

  bool getBuonaSalute() {
    return _buonaSalute;
  }

  bool getRicoveroOspedale() {
    return _ricoveratoOspedale;
  }

  bool getUltimaDonazioneSalute() {
    return _ultimaDonazioneSalute;
  }

  bool getAllergie() {
    return _allergie;
  }

  bool getPerditaPeso() {
    return _perditaPeso;
  }

  String getMotivoRicovero() {
    return _motivoRicovero;
  }

  String getQualiAllergie() {
    return _qualiAllergie;
  }
}
