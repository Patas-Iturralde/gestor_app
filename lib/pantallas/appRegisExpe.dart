import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestor_app/pantallas/appcabeceras.dart';
import 'package:gestor_app/pantallas/provaider/appDirecciones.dart';
import 'package:gestor_app/pantallas/provaider/funciones.dart';
import 'package:provider/provider.dart';

import '../servicios/appvalidarAcceso.dart';
import '../ventasAlerta/alertaProgreso.dart';

class appRegisExpe extends StatefulWidget {
  const appRegisExpe({super.key});

  @override
  State<appRegisExpe> createState() => _appRegisExpeState();
}

const List<String> list = <String>[
  'Ruptura de calzado',
  'Albergue canino',
  'Sugerencias',
  'Quejas'
];

bool _validateEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return emailRegex.hasMatch(email);
}

bool _validatePhoneNumber(String phoneNumber) {
  // Expresión regular para validar números de teléfono (solo números)
  final phoneRegex = RegExp(r'^\d+$');
  return phoneRegex.hasMatch(phoneNumber);
}

bool _validateMessage(String message) {
  return message.isNotEmpty;
}

class _appRegisExpeState extends State<appRegisExpe> {
  final cedula = TextEditingController();
  final correo = TextEditingController();
  final celu = TextEditingController();
  final msgSoli = TextEditingController();
  bool blockCedula = true;
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            const Column(
              children: [appcabeceras()],
            ),
            const Divider(
              height: 30.0,
              color: Colors.transparent,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    maxLength: 10,
                    controller: cedula,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cedula',
                      labelStyle: TextStyle(
                        color: Colors.black, //<-- SEE HERE
                      ),
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(
                          color: Colors.black,
                          Icons.assignment,
                        ),
                      ),
                    ),
                    enabled: blockCedula,
                  ),
                ),
                const VerticalDivider(
                  width: 8.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      alertaProgreso().progreso(context);
                      final datVerificador =
                          await appvalidarAcceso().validarCedula(cedula.text);
                      final verificador = datVerificador[0].codigo;
                      final nombComple = datVerificador[0].completo;

                      if (verificador == 0) {
                        Navigator.of(context).pop();

                        alertaProgreso().alertas(context, 'Cedula Incorrecta',
                            'verifique Porfavor', 1);
                      } else {
                        blockCedula = false;
                        Navigator.of(context).pop();
                        context.read<appdireciones>().asignarNomb(nombComple);
                      }

                      ///var validador = _datAcceso[0].stdoAcceso;
                    },
                    icon: const Icon(
                        Icons.fingerprint), //icon data for elevated button
                    label: const Text(
                      "Validar",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ), //label text

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 16),
                      backgroundColor: Colors
                          .lightBlue[900], //elevated btton background color
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            Column(
              children: [
                TextField(
                  controller: TextEditingController(
                      text: context.watch<appdireciones>().completo),

                  ///enabled: true,
                  enableInteractiveSelection: false,

                  ///controller:completo,
                  ///readOnly: true,

                  ///controller: correo,

                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombres Completos',
                    labelStyle: TextStyle(
                      color: Colors.black, //<-- SEE HERE
                    ),
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        color: Colors.black,
                        Icons.perm_identity,
                      ),
                    ),
                  ),
                  enabled: false,
                ),
              ],
            ),
            const Divider(
              height: 80.0,
              color: Colors.transparent,
            ),
            Column(
              children: [
                TextField(
                  controller: correo,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo Electronico',
                    labelStyle: TextStyle(
                      color: Colors.black, //<-- SEE HERE
                    ),
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        color: Colors.black,
                        Icons.mail,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            Column(
              children: [
                TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: celu,

                  ///controller: correo,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Celular',
                    labelStyle: TextStyle(
                      color: Colors.black, //<-- SEE HERE
                    ),
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        color: Colors.black,
                        Icons.call,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            Column(
              children: [
                TextField(
                  maxLines: 2,
                  minLines: 1,
                  controller: msgSoli,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(40),
                    border: OutlineInputBorder(),
                    labelText: 'Mensaje',
                    labelStyle: TextStyle(
                      color: Colors.black, //<-- SEE HERE
                    ),
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        color: Colors.black,
                        Icons.border_color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            Column(
              children: [
                DropdownMenu<String>(
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                )
              ],
            ),
            const Divider(
              height: 20.0,
              color: Colors.transparent,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                        Icons.border_color), //icon data for elevated button
                    label: const Text(
                      "Registro",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ), //label text

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      backgroundColor: Colors
                          .lightBlue[900], //elevated btton background color
                    ),
                  ),
                ),
                const VerticalDivider(
                  width: 10.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_validatePhoneNumber(celu.text) &&
                          _validateMessage(msgSoli.text)) {
                        if (_validateEmail(correo.text)) {
                          alertaProgreso().progreso(context);
                          var datVerificador = await appvalidarAcceso()
                              .regisExpe(cedula.value.text, correo.text,
                                  celu.value.text, msgSoli.text);
                          var verificador = datVerificador[0].expediente;
                          Navigator.of(context).pop();

                          alertaProgreso().alertas(
                              context, 'Num Expediente', verificador, 2);
                          setState(() {
                            cedula.clear();
                            blockCedula = true;
                            context.read<appdireciones>().asignarNomb('');
                            correo.clear();
                            celu.clear();
                            msgSoli.clear();
                          });
                        } else {
                          alertaProgreso().alertas(
                              context,
                              'Correo electronico incorrecto',
                              'Verifique Porfavor',
                              1);
                        }
                      } else {
                        alertaProgreso().alertas(context, 'Campos incompletos',
                            'Verifique Porfavor', 1);
                      }

                      /*
                      if (verificador == 0) {
                        Navigator.of(context).pop();
                        alertaProgreso().alertas(
                            context, 'Cedula Incorrecta', 'verifique Porfavor');
                      } else {
                        Navigator.of(context).pop();
                        context.read<appdireciones>().asignarNomb(nombComple);
                      }*/

                      ///var validador = _datAcceso[0].stdoAcceso;
                    },
                    icon: const Icon(
                        Icons.send_to_mobile), //icon data for elevated button
                    label: const Text(
                      "Enviar",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ), //label text

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      backgroundColor: Colors
                          .lightBlue[900], //elevated btton background color
                    ),
                  ),
                ),
                const VerticalDivider(
                  width: 10.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons
                        .power_settings_new), //icon data for elevated button
                    label: const Text(
                      "Salir",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ), //label text

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      backgroundColor: Colors
                          .lightBlue[900], //elevated btton background color
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
