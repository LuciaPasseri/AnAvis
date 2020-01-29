class Donatore {
  static final Donatore _donatore = Donatore._internal();
  String _idDonatore;
  String _nome;
  String _cognome;
  String _gruppoSanguigno;
  String _email;

  factory Donatore() {
    return _donatore;
  }

  Donatore._internal();

  void setId(String id) {
    _idDonatore = id;
  }

  void setNome(String nome) {
    this._nome = nome;
  }

  void setCognome(String cognome) {
    this._cognome = cognome;
  }

  void setGruppoSanguigno(String gruppoSanguigno) {
    this._gruppoSanguigno = gruppoSanguigno;
  }

  void setEmail(String email) {
    this._email = email;
  }

  String getId() {
    return _idDonatore;
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
}
