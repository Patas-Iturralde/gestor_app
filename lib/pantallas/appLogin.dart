import 'package:flutter/material.dart';
import 'package:gestor_app/pantallas/appcabeceras.dart';
import 'package:gestor_app/servicios/appvalidarAcceso.dart';
import 'package:gestor_app/ventasAlerta/alertaProgreso.dart';
import 'package:provider/provider.dart';
import 'package:gestor_app/pantallas/provaider/appDirecciones.dart';

class applogin extends StatefulWidget {
  const applogin({super.key});

  @override
  State<applogin> createState() => _apploginState();
}

class _apploginState extends State<applogin> {
  final correo = TextEditingController();
  final clave = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            const appcabeceras(),
            const Divider(
              height: 30.0,
              color: Colors.transparent,
            ),
            const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 244, 245, 247),
              radius: 80,
              child: Icon(
                Icons.lock,
                color: Color.fromARGB(255, 1, 87, 155),
                size: 100,
              ),
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Iniciar Sesión",
                      style:
                          TextStyle(fontSize: 35, color: Colors.lightBlue[900]),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 80.0,
              color: Colors.transparent,
            ),
            Text(context.watch<appdireciones>().usuario),
            TextField(
              controller: correo,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Usuario',
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
            const Divider(
              height: 20.0,
              color: Colors.transparent,
            ),
            TextField(
              controller: clave,
              obscureText: context.watch<appdireciones>().contrasenia,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Contraseña',
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                prefixIcon: const Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Icon(
                    color: Colors.black,
                    Icons.lock,
                  ),
                ),
                suffixIcon: Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: IconButton(
                    onPressed: () {
                      context.read<appdireciones>().cambioIcoClave();
                    },
                    icon: Icon(
                      /// color: context.watch<appdireciones>().colorIco,
                      context.watch<appdireciones>().icoclave,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 40,
              color: Colors.transparent,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                alertaProgreso().progreso(context);

                var _datAcceso = await appvalidarAcceso()
                    .validarAcceso(correo.text, clave.text);
                var validador = _datAcceso[0].stdoAcceso;
                if (validador == '0') {
                  Navigator.of(context).pop();

                  ///Navigator.pop(context);
                  alertaProgreso().alertas(context, 'Acceso Incorrrecto',
                      'Revise de Correo y Clave', 2);
                }

                ///validador==0 ?Navigator.pop(context):
                ////context.read<appdireciones>().datRegistro(correo.text);
                ///Navigator.pop(context);
                ///print(_datAcceso[0].identificacion);
              },
              icon: Icon(Icons.login), //icon data for elevated button
              label: Text(
                "Acceso",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ), //label text

              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 180, vertical: 20),
                backgroundColor:
                    Colors.lightBlue[900], //elevated btton background color
              ),
            ),
            const Divider(
              height: 20,
              color: Colors.transparent,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.group_add,
                      color: Colors.blue,
                      size: 40,
                    ),
                    style: ButtonStyle(alignment: Alignment.bottomLeft),
                    label: const Text(
                      "Registrate",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.settings_power_outlined,
                      color: Colors.red,
                      size: 40,
                    ),
                    style: const ButtonStyle(alignment: Alignment.topRight),
                    label: const Text(
                      "Salir",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
