import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gestor_app/modelos/denominacion.dart';
import 'package:gestor_app/pantallas/appcabeceras.dart';
import 'package:gestor_app/pantallas/provaider/appDirecciones.dart';
import 'package:gestor_app/servicios/appvalidarAcceso.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../ventasAlerta/alertaProgreso.dart';

class AppRegisExpe extends StatefulWidget {
  const AppRegisExpe({super.key});

  @override
  State<AppRegisExpe> createState() => _AppRegisExpeState();
}

class _AppRegisExpeState extends State<AppRegisExpe> {
  final cedula = TextEditingController();
  final correo = TextEditingController();
  final celu = TextEditingController();
  final msgSoli = TextEditingController();
  final picker = ImagePicker();
  File? imagen; // Cambio a File? para permitir null
  var pickedfile;
  String selectedItemId = 'Seleccione una opción';

  bool blockCedula = true;

  @override
  void initState() {
    super.initState();
    getDenominaciones();
  }

  List<RespuestaDenominacion> list = [];

  Future<void> getDenominaciones() async {
    final AppvalidarAcceso appvalidarAcceso = AppvalidarAcceso();
    List<RespuestaDenominacion> data = await appvalidarAcceso.denominacion();
    setState(() {
      list = data;
      if (list.isNotEmpty) {
        selectedItemId = list[0].id.toString();
      }
    });
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\d+$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  bool _validateMessage(String message) {
    return message.isNotEmpty;
  }

  Future<void> _takePicture() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 1);
    if (pickedFile != null) {
      setState(() {
        imagen = File(pickedFile.path);
      });
      // Convierte la imagen en una cadena Base64
      String? base64Image = imageToBase64(imagen);

      // Ahora puedes usar base64Image según tus necesidades
      print("Imagen en Base64: $base64Image");
    }
  }

  Future<void> _selectPicture() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 1);
    if (pickedFile != null) {
      setState(() {
        imagen = File(pickedFile.path);
      });
      // Convierte la imagen en una cadena Base64
      String? base64Image = imageToBase64(imagen);

      // Ahora puedes usar base64Image según tus necesidades
      print("Imagen en Base64: $base64Image");
    }
  }

  String? imageToBase64(File? imageFile) {
    if (imageFile == null) {
      return null; // Devuelve null si no hay imagen
    }
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  @override
  Widget build(BuildContext context) {
    final appvalidarAcceso =
        Provider.of<AppvalidarAcceso>(context, listen: false);

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
                        color: Colors.black,
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
                    child: Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            alertaProgreso().progreso(context);
                            final datVerificador = await AppvalidarAcceso()
                                .validarCedula(cedula.text);
                            final verificador = datVerificador[0].codigo;
                            final nombComple = datVerificador[0].completo;

                            if (verificador == 0) {
                              Navigator.of(context).pop();

                              alertaProgreso().alertas(context,
                                  'Cedula Incorrecta', 'Verifique Porfavor', 1);
                            } else {
                              blockCedula = false;
                              Navigator.of(context).pop();
                              context
                                  .read<appdireciones>()
                                  .asignarNomb(nombComple);
                            }
                          },
                          icon: const Icon(Icons.fingerprint),
                          label: const Text(
                            "Validar",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 16),
                            backgroundColor: Colors.lightBlue[900],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    )),
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
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombres Completos',
                    labelStyle: TextStyle(
                      color: Colors.black,
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
              height: 20.0,
              color: Colors.transparent,
            ),
            imagen == null ? Center() : Image.file(imagen!, height: 200),
            const Divider(
              height: 20.0,
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
                      color: Colors.black,
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Celular',
                    labelStyle: TextStyle(
                      color: Colors.black,
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
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(),
                    labelText: 'Mensaje',
                    labelStyle: TextStyle(
                      color: Colors.black,
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
            Row(
              children: [
                Container(
                  width: 250, // Establece el ancho deseado
                  padding: EdgeInsets.all(10), // Agrega relleno para los bordes
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black), // Agrega bordes
                    borderRadius:
                        BorderRadius.circular(5), // Aplica bordes redondeados
                  ),
                  child: Center(
                    child: DropdownButton<String>(
                  value: selectedItemId,
  onChanged: (String? newValue) {
    setState(() {
      selectedItemId = newValue!;
      print(selectedItemId);
    });
  },
                  underline: Container(), // Quita la línea debajo del texto
                  items: list.map((RespuestaDenominacion item) {
                    return DropdownMenuItem<String>(
                      value: item.id,
                      child: Center(
                        child: Text(
                          item.denominacion,
                          style: TextStyle(
                            decoration: TextDecoration
                                .none, // Quita la decoración de texto (en este caso, la línea debajo del texto)
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                  ),
                ),
                const VerticalDivider(
                  width: 10.0,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    _takePicture();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: Colors.grey))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Tomar una foto",
                                          style: TextStyle(fontSize: 16),
                                        )),
                                        Icon(Icons.camera_alt,
                                            color: Colors.blue)
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _selectPicture();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Seleccionar una foto",
                                          style: TextStyle(fontSize: 16),
                                        )),
                                        Icon(Icons.image, color: Colors.blue)
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    imagen = null;
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration:
                                        BoxDecoration(color: Colors.deepOrange),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Quitar foto",
                                          style: TextStyle(fontSize: 16),
                                        )),
                                        Icon(Icons.image, color: Colors.blue)
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration:
                                        BoxDecoration(color: Colors.red),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Atras",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.camera),
                  label: Text("Foto"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 22),
                    backgroundColor: Colors.lightBlue[900],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20.0,
              color: Colors.transparent,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(11.0),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      cedula.clear();
                      blockCedula = true;
                      context.read<appdireciones>().asignarNomb('');
                      imagen = null;
                      correo.clear();
                      celu.clear();
                      msgSoli.clear();
                      
                      // Establecer en "predeterminado"
                    },
                    icon: const Icon(Icons.delete_outlined),
                    label: const Text(
                      "Limpiar",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      backgroundColor: Colors.deepOrangeAccent,
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
                          var datVerificador = await AppvalidarAcceso()
                              .regisExpe(
                                  cedula.value.text,
                                  correo.text,
                                  celu.value.text,
                                  msgSoli.text,
                                  selectedItemId);
                          var verificador = datVerificador[0].expediente;
                          Navigator.of(context).pop();

                          alertaProgreso().alertas(
                              context, 'Num Expediente', verificador, 2);
                          setState(() {
                            cedula.clear();
                            blockCedula = true;
                            context.read<appdireciones>().asignarNomb('');
                            imagen = null;
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
                    },
                    icon: const Icon(Icons.send_to_mobile),
                    label: const Text(
                      "Enviar",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      backgroundColor: Colors.lightBlue[900],
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
                    icon: const Icon(Icons.power_settings_new),
                    label: const Text(
                      "Salir",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      backgroundColor: Colors.lightBlue[900],
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
