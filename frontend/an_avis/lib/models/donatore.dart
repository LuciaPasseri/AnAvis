import "package:flutter/material.dart";

class DonatoreProvider extends ChangeNotifier {
    String _nome;
    String _cognome;
    String _gruppoSanguigno;
    String _email;
    String _password;

    setNome(String nome) {
      this._nome = nome;
    }

    setCognome(String cognome) {
      this._cognome = cognome;
    }

    setGruppoSanguigno(String gruppoSanguigno) {
      this._gruppoSanguigno = gruppoSanguigno;
    }

    setEmail(String email) {
      this._email = email;
    }

    setPassword(String password) {
      this._password = password;
    }

    String getNome() {
      return _nome;
    }

    String getCognome() {
      return _cognome;
    }

    String getGruppoSanguigno() {
      return _gruppoSanguigno;
    }

    String getEmail() {
      return _email;
    }

    String getPassword() {
      return _password;
    }

}