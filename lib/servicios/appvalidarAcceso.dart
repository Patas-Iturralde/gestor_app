import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestor_app/modelos/denominacion.dart';
import 'package:gestor_app/modelos/valiAcceso.dart';
import 'package:http/http.dart' as http;

class AppvalidarAcceso extends ChangeNotifier {
  bool isloading = false;

  /// String correo;
  ///String clave;

  //// appvalidarAcceso(this.correo, this.clave);

  Future<List<valiAcceso>> validarAcceso(correo, clave) async {
    final http.Response respuesta = await http.get(Uri.parse(
        'http://186.46.158.7/apilab/lab_acceso.php?correo=$correo&clave=$clave'));
    List<valiAcceso> datVali = [];
    if (respuesta.statusCode == 200) {
      String cuerpo = utf8.decode(respuesta.bodyBytes);
      final jsondata = jsonDecode(cuerpo);
      datVali.add(
        valiAcceso(jsondata['vali_acceso'], jsondata['cedula']),
      );
      return datVali;
    } else {
      throw Exception('fallo la conexion');
    }
  }

  /*
    Future<List>  validarAcceso async {
    final http.Response respuesta = await http.get(Uri.parse(
        'http://186.46.158.7/apilab/lab_acceso.php?correo=$correo&clave=$clave'));
    var dato = jsonDecode(respuesta.body);
    return dato;
  }*/

  Future<List<valiCedula>> validarCedula(cedula) async {
    final http.Response respuestaV = await http.get(Uri.parse(
        'http://186.46.158.7/AppattCiu/verificador_ced.php?cedula=$cedula'));
    List<valiCedula> datVali = [];
    if (respuestaV.statusCode == 200) {
      String cuerpo = utf8.decode(respuestaV.bodyBytes);
      final jsondataCed = jsonDecode(cuerpo);
      final datValidador = jsondataCed['respuesta'][0];
      datVali.add(
        valiCedula(
            datValidador['cod_validador'], datValidador['Nomb_completo']),
      );
      return datVali;
    } else {
      throw Exception('fallo la conexion');
    }
  }

  Future<List<Respuesta>> regisExpe(
      solicitante, pedido, fono, mail, codigo) async {
    final http.Response respuestaV = await http.get(Uri.parse(
        'http://186.46.158.7/AppattCiu/Regis_Solicitudes.php?remitente=$solicitante&detaPedido=$pedido&celu=$fono&correo=$mail'));
    List<Respuesta> datVali = [];
    if (respuestaV.statusCode == 200) {
      String cuerpo = utf8.decode(respuestaV.bodyBytes);
      final jsondataCed = jsonDecode(cuerpo);
      final datValidador = jsondataCed['respuesta'][0];
      datVali.add(
        Respuesta(datValidador['num_expediente']),
      );
      return datVali;
    } else {
      throw Exception('fallo la conexion');
    }
  }

  Future<List<RespuestaDenominacion>> denominacion() async {
    try {
      isloading = true;
      final http.Response respuestaV = await http.get(
        Uri.parse('http://186.46.158.7/AppattCiu/tpoSolicitud.php'),
      );
      if (respuestaV.statusCode == 200) {
        String cuerpo = utf8.decode(respuestaV.bodyBytes);
        final jsondataDen = jsonDecode(cuerpo);
        final datDenominador = Denominacion.fromJson(jsondataDen);
        return datDenominador.respuesta;
      } else {
        throw Exception('Fallo la conexión');
      }
    } catch (e) {
      throw Exception('Fallo la conexión');
    }
  }
}
