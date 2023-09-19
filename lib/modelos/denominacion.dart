import 'dart:convert';

Denominacion denominacionFromJson(String str) =>
    Denominacion.fromJson(json.decode(str));

String denominacionToJson(Denominacion data) => json.encode(data.toJson());

class Denominacion {
  List<RespuestaDenominacion> respuesta;

  Denominacion({
    required this.respuesta,
  });

  factory Denominacion.fromJson(Map<String, dynamic> json) => Denominacion(
        respuesta: List<RespuestaDenominacion>.from(
            json["respuesta"].map((x) => RespuestaDenominacion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respuesta": List<dynamic>.from(respuesta.map((x) => x.toJson())),
      };
}

class RespuestaDenominacion {
  String id;
  String denominacion;

  RespuestaDenominacion({
    required this.id,
    required this.denominacion,
  });

  factory RespuestaDenominacion.fromJson(Map<String, dynamic> json) => RespuestaDenominacion(
        id: json["id"],
        denominacion: json["denominacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "denominacion": denominacion,
      };
}
