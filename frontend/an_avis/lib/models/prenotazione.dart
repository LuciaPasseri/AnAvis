import "package:flutter/material.dart";

class PrenotazioneProvider extends ChangeNotifier {
  String _tipoDonazione;
  String _idSede;
  String _data;
  String _mese;
  String _giorno;
  bool _questionarioCompilato;

  setTipoDonazione(String tipo) {
    _tipoDonazione = tipo;
  }

  setIdSede(String id) {
    _idSede = id;
  }

  setMese(String mese) {
    this._mese = mese;
  }

  setGiorno(String giorno) {
    this._giorno = giorno;
  }

  setData() {
    _data = DateTime.now().year.toString() +
        "-" +
        _mese.toString() +
        "-" +
        _giorno.toString();
  }

  setQuestionarioCompilato(bool value) {
    _questionarioCompilato = value;
  }

  String getTipoDonazione() {
    return _tipoDonazione;
  }

  String getIdSede() {
    return _idSede;
  }

  String getMese() {
    return _mese;
  }

  String getMeseCompleto() {
    switch (_mese) {
      case "01":
        return "Gennaio";
        break;
      case "02":
        return "Febbraio";
        break;
      case "03":
        return "Marzo";
        break;
      case "04":
        return "Aprile";
        break;
      case "05":
        return "Maggio";
        break;
      case "06":
        return "Giugno";
        break;
      case "07":
        return "Luglio";
        break;
      case "08":
        return "Agosto";
        break;
      case "09":
        return "Settembre";
        break;
      case "10":
        return "Ottobre";
        break;
      case "11":
        return "Novembre";
        break;
      case "12":
        return "Dicembre";
        break;
      default:
        return "Errore";
    }
  }

  String getGiorno() {
    return _giorno;
  }

  String getData() {
    return _data;
  }

  bool getQuestionarioCompilato() {
    return _questionarioCompilato;
  }
}
