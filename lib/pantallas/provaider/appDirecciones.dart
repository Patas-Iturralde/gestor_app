import 'package:flutter/material.dart';

class appdireciones with ChangeNotifier {
  String _direc = 'http://186.46.158.7/appImagenes/logo_gad.png';
  String _usu = 'edico';
  bool _clave = true;
  IconData _icoclave = Icons.visibility_off;
  Color _colorIco = Colors.red;
  String _nombCompleto = '';
  String _cedulaV = '0502166903';
  String _name = '';
  String get cedulaV => _cedulaV;

  String get direcc => _direc;
  String get usuario => _usu;
  Color get colorIco => _colorIco;
  IconData get icoclave => _icoclave;
  bool get contrasenia => _clave;
  String get completo => _nombCompleto;

  String get name => _name;
  setname(String name) {
    _name = name;
    notifyListeners();
  }

  void datRegistro(usu) {
    _usu = usu;
    notifyListeners();
  }

  void cambioIcoClave() {
    if (_icoclave == Icons.visibility_off) {
      _icoclave = Icons.visibility;
      _clave = false;
      _colorIco = Colors.green;
    } else {
      _icoclave = Icons.visibility_off;
      _clave = true;
      _colorIco = Colors.red;
    }
    notifyListeners();
  }

  void asignarNomb(nombres) {
    _nombCompleto = nombres;
    notifyListeners();
  }
}
