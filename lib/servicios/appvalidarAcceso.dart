import 'dart:convert';

import 'package:gestor_app/modelos/valiAcceso.dart';
import 'package:http/http.dart' as http;

class appvalidarAcceso {
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

  Future<List<dat_expediente>> regisExpe(
      solicitante, pedido, fono, mail) async {
    final http.Response respuestaV = await http.get(Uri.parse(
        'http://186.46.158.7/AppattCiu/Regis_Solicitudes.php?remitente=$solicitante&detaPedido=$pedido&celu=$fono&correo=$mail'));
    List<dat_expediente> datVali = [];
    if (respuestaV.statusCode == 200) {
      String cuerpo = utf8.decode(respuestaV.bodyBytes);
      final jsondataCed = jsonDecode(cuerpo);
      final datValidador = jsondataCed['respuesta'][0];
      datVali.add(
        dat_expediente(datValidador['num_expediente']),
      );
      return datVali;
    } else {
      throw Exception('fallo la conexion');
    }
  }
}
