class Sede {
  static final Sede _sede = Sede._internal();
  String _idSede;
  String _cittaSede;
  String _email;

  factory Sede() {
    return _sede;
  }

  Sede._internal();

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
